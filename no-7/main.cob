       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANKING.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT IN-FILE ASSIGN TO "input.txt".
           SELECT ACC-FILE ASSIGN TO "accounts.txt"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT TMP-FILE ASSIGN TO "temp.txt"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OUT-FILE ASSIGN TO "output.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD IN-FILE.
       01 IN-RECORD             PIC X(20).

       FD ACC-FILE.
       01 ACC-RECORD            PIC X(17).

       FD TMP-FILE.
       01 TMP-RECORD            PIC X(17).

       FD OUT-FILE.
       01 OUT-RECORD            PIC X(100).

       WORKING-STORAGE SECTION.
       77 IN-ACCOUNT            PIC 9(6).
       77 IN-ACTION             PIC X(3).
       77 IN-AMOUNT             PIC 9(6)V99.

       77 ACC-ACCOUNT           PIC 9(6).
       77 ACC-ACTION            PIC X(3).
       77 ACC-BALANCE           PIC 9(6)V99.

       77 TMP-ACCOUNT           PIC 9(6).
       77 TMP-ACTION            PIC X(3).
       77 TMP-BALANCE           PIC 9(6)V99.
       
       77 MATCH-FOUND           PIC X VALUE "N".
       77 UPDATED               PIC X VALUE "N".
       77 APPLY-INTEREST        PIC X VALUE "N".
       77 TRANSACTION-VALID     PIC X VALUE "Y".
       77 ACCOUNT-EXISTS        PIC X VALUE "N".

       77 FORMATTED-AMOUNT      PIC Z(5)9.99.
       77 BALANCE-TEXT          PIC X(20).
       
       77 INT-RATE         PIC 9V9(5) VALUE 0.00025.
       77 INT-AMOUNT       PIC 9(6)V99.
       77 ARG-VALUE             PIC X(15).
       77 ARG-COUNT             PIC 9(4).
       77 MAX-BALANCE           PIC 9(6)V99 VALUE 999999.99.
       77 TEMP-BALANCE          PIC 9(6)V99.
       
       77 INTEREST-COUNTER      PIC 9(6) VALUE 0.
       77 RAI-TO-IDR-RATE       PIC 9(9) VALUE 120000000.
       77 IDR-BALANCE           PIC 9(15).
       77 IDR-AMOUNT            PIC 9(15).
       77 IDR-FORMATTED         PIC Z(14)9.
       77 INPUT-IDR-FLAG        PIC X VALUE "N".
       
       *> Auto-interest timing variables
       77 INTEREST-COUNTER      PIC 9(6) VALUE 0.
       
       PROCEDURE DIVISION.

       MAIN.
           ACCEPT ARG-VALUE FROM COMMAND-LINE
           IF ARG-VALUE = "--apply-interest"
               MOVE "Y" TO APPLY-INTEREST
               PERFORM APPLY-INTEREST-TO-ALL
           ELSE IF ARG-VALUE = "--auto-interest"
               PERFORM APPLY-INTEREST-TO-ALL
           ELSE IF ARG-VALUE = "--input-idr"
               MOVE "Y" TO INPUT-IDR-FLAG
               PERFORM READ-INPUT
               IF IN-ACTION = "NEW"
                   PERFORM CHECK-ACCOUNT-EXISTS
                   IF ACCOUNT-EXISTS = "Y"
                       OPEN OUTPUT OUT-FILE
                       MOVE "ACCOUNT ALREADY EXISTS" TO OUT-RECORD
                       WRITE OUT-RECORD
                       CLOSE OUT-FILE
                   ELSE
                       PERFORM APPEND-ACCOUNT
                       OPEN OUTPUT OUT-FILE
                       WRITE OUT-RECORD
                       CLOSE OUT-FILE
                   END-IF
               ELSE
                   PERFORM PROCESS-RECORDS
                   IF MATCH-FOUND = "N"
                       OPEN OUTPUT OUT-FILE
                       MOVE "ACCOUNT NOT FOUND" TO OUT-RECORD
                       WRITE OUT-RECORD
                       CLOSE OUT-FILE
                   ELSE
                       PERFORM FINALIZE
                   END-IF
               END-IF
           ELSE
               PERFORM READ-INPUT
               IF IN-ACTION = "NEW"
                   PERFORM CHECK-ACCOUNT-EXISTS
                   IF ACCOUNT-EXISTS = "Y"
                       OPEN OUTPUT OUT-FILE
                       MOVE "ACCOUNT ALREADY EXISTS" TO OUT-RECORD
                       WRITE OUT-RECORD
                       CLOSE OUT-FILE
                   ELSE
                       PERFORM APPEND-ACCOUNT
                       OPEN OUTPUT OUT-FILE
                       WRITE OUT-RECORD
                       CLOSE OUT-FILE
                   END-IF
               ELSE
                   PERFORM PROCESS-RECORDS
                   IF MATCH-FOUND = "N"
                       OPEN OUTPUT OUT-FILE
                       MOVE "ACCOUNT NOT FOUND" TO OUT-RECORD
                       WRITE OUT-RECORD
                       CLOSE OUT-FILE
                   ELSE
                       PERFORM FINALIZE
                   END-IF
               END-IF
           END-IF
           STOP RUN.
           
       APPLY-INTEREST-TO-ALL.
           OPEN INPUT ACC-FILE
           READ ACC-FILE
               AT END
                   CLOSE ACC-FILE
                   OPEN OUTPUT OUT-FILE
                   MOVE "NO ACCOUNTS FOUND" TO OUT-RECORD
                   WRITE OUT-RECORD
                   CLOSE OUT-FILE
                   EXIT PARAGRAPH
           END-READ
           CLOSE ACC-FILE
           
           MOVE "N" TO UPDATED
           
           OPEN INPUT ACC-FILE
           OPEN OUTPUT TMP-FILE
           
           PERFORM UNTIL 1 = 2
               READ ACC-FILE
                   AT END
                       EXIT PERFORM
                   NOT AT END
                       MOVE ACC-RECORD(1:6) TO ACC-ACCOUNT
                       MOVE ACC-RECORD(7:3) TO ACC-ACTION  
                       MOVE FUNCTION NUMVAL(ACC-RECORD(10:8))
                           TO ACC-BALANCE
                           
                       COMPUTE INT-AMOUNT = ACC-BALANCE * INT-RATE
                       
                       MOVE ACC-BALANCE TO TEMP-BALANCE
                       ADD INT-AMOUNT TO TEMP-BALANCE
                       
                       IF TEMP-BALANCE > MAX-BALANCE
                           MOVE MAX-BALANCE TO ACC-BALANCE
                       ELSE
                           ADD INT-AMOUNT TO ACC-BALANCE
                       END-IF
                       
                       MOVE ACC-ACCOUNT TO TMP-RECORD(1:6)
                       MOVE ACC-ACTION TO TMP-RECORD(7:3)
                       MOVE ACC-BALANCE TO FORMATTED-AMOUNT
                       MOVE FORMATTED-AMOUNT(2:8) TO TMP-RECORD(10:8)
                       
                       WRITE TMP-RECORD
                       MOVE "Y" TO UPDATED
           END-PERFORM
           
           CLOSE ACC-FILE
           CLOSE TMP-FILE
           
           OPEN OUTPUT OUT-FILE
           IF UPDATED = "Y"
               MOVE "INTEREST APPLIED TO ALL ACCOUNTS" TO OUT-RECORD
           ELSE
               MOVE "NO ACCOUNTS PROCESSED" TO OUT-RECORD
           END-IF
           WRITE OUT-RECORD
           CLOSE OUT-FILE
           
           IF UPDATED = "Y"
               CALL "SYSTEM" USING "mv temp.txt accounts.txt"
           END-IF.

       CHECK-ACCOUNT-EXISTS.
           MOVE "N" TO ACCOUNT-EXISTS
           OPEN INPUT ACC-FILE
           
           PERFORM UNTIL 1 = 2
               READ ACC-FILE
                   AT END
                       EXIT PERFORM
                   NOT AT END
                       MOVE ACC-RECORD(1:6) TO ACC-ACCOUNT
                       IF ACC-ACCOUNT = IN-ACCOUNT
                           MOVE "Y" TO ACCOUNT-EXISTS
                           EXIT PERFORM
                       END-IF
           END-PERFORM
           
           CLOSE ACC-FILE.

       READ-INPUT.
           OPEN INPUT IN-FILE
           READ IN-FILE AT END
               DISPLAY "NO INPUT"
               STOP RUN
           END-READ
           CLOSE IN-FILE

           MOVE IN-RECORD(1:6) TO IN-ACCOUNT
           MOVE IN-RECORD(7:3) TO IN-ACTION
           MOVE FUNCTION NUMVAL(IN-RECORD(10:9)) TO IN-AMOUNT
           
           IF INPUT-IDR-FLAG = "Y" AND IN-ACTION NOT = "BAL"
               COMPUTE IN-AMOUNT = IN-AMOUNT / RAI-TO-IDR-RATE
           END-IF.

       PROCESS-RECORDS.
           OPEN INPUT ACC-FILE
           OPEN OUTPUT TMP-FILE
           PERFORM UNTIL 1 = 2
               READ ACC-FILE
                   AT END
                       EXIT PERFORM
                   NOT AT END
                       MOVE ACC-RECORD(1:6) TO ACC-ACCOUNT
                       MOVE ACC-RECORD(7:3) TO ACC-ACTION
                       MOVE FUNCTION NUMVAL(ACC-RECORD(10:8))
                           TO ACC-BALANCE
                       IF ACC-ACCOUNT = IN-ACCOUNT
                           MOVE "Y" TO MATCH-FOUND
                           PERFORM APPLY-ACTION
                       ELSE
                           MOVE ACC-RECORD TO TMP-RECORD
                           WRITE TMP-RECORD
                       END-IF
           END-PERFORM
           CLOSE ACC-FILE
           CLOSE TMP-FILE.

       APPLY-ACTION.
           MOVE ACC-ACCOUNT TO TMP-ACCOUNT
           MOVE ACC-ACTION TO TMP-ACTION
           MOVE ACC-BALANCE TO TMP-BALANCE
           MOVE "Y" TO TRANSACTION-VALID
           
           EVALUATE IN-ACTION
               WHEN "DEP"
                   MOVE TMP-BALANCE TO TEMP-BALANCE
                   ADD IN-AMOUNT TO TEMP-BALANCE
                   
                   IF TEMP-BALANCE > MAX-BALANCE
                       MOVE "DEPOSIT REJECTED: EXCEEDS MAXIMUM BALANCE" 
                         TO OUT-RECORD
                       MOVE "N" TO TRANSACTION-VALID
                   ELSE
                       ADD IN-AMOUNT TO TMP-BALANCE
                       COMPUTE IDR-AMOUNT = IN-AMOUNT * RAI-TO-IDR-RATE
                       MOVE IDR-AMOUNT TO IDR-FORMATTED
                       MOVE SPACES TO OUT-RECORD
                       STRING "DEPOSITED: IDR " DELIMITED BY SIZE
                              IDR-FORMATTED DELIMITED BY SIZE
                              INTO OUT-RECORD
                   END-IF
               WHEN "WDR"
                   IF IN-AMOUNT > TMP-BALANCE
                       MOVE "WITHDRAWAL REJECTED: INSUFFICIENT FUNDS" 
                         TO OUT-RECORD
                       MOVE "N" TO TRANSACTION-VALID
                   ELSE
                       SUBTRACT IN-AMOUNT FROM TMP-BALANCE
                       COMPUTE IDR-AMOUNT = IN-AMOUNT * RAI-TO-IDR-RATE
                       MOVE IDR-AMOUNT TO IDR-FORMATTED
                       MOVE SPACES TO OUT-RECORD
                       STRING "WITHDREW: IDR " DELIMITED BY SIZE
                              IDR-FORMATTED DELIMITED BY SIZE
                              INTO OUT-RECORD
                   END-IF
               WHEN "BAL"
                   COMPUTE IDR-BALANCE = TMP-BALANCE * RAI-TO-IDR-RATE
                   MOVE IDR-BALANCE TO IDR-FORMATTED
                   MOVE SPACES TO OUT-RECORD
                   STRING "BALANCE: IDR " DELIMITED BY SIZE
                          IDR-FORMATTED DELIMITED BY SIZE
                          INTO OUT-RECORD
               WHEN "NEW"
                   MOVE "NEW ACCOUNT REQUEST PROCESSED ELSEWHERE" 
                     TO OUT-RECORD
               WHEN OTHER
                   MOVE "UNKNOWN ACTION" TO OUT-RECORD
           END-EVALUATE

           IF TRANSACTION-VALID = "Y"
               MOVE TMP-ACCOUNT TO TMP-RECORD(1:6)
               MOVE TMP-ACTION TO TMP-RECORD(7:3)
               MOVE TMP-BALANCE TO FORMATTED-AMOUNT
               MOVE FORMATTED-AMOUNT(2:8) TO TMP-RECORD(10:8)
               WRITE TMP-RECORD
               MOVE "Y" TO UPDATED
           ELSE
               MOVE ACC-RECORD TO TMP-RECORD
               WRITE TMP-RECORD
           END-IF.

       APPEND-ACCOUNT.
           OPEN EXTEND ACC-FILE
           MOVE IN-ACCOUNT TO ACC-RECORD(1:6)
           MOVE "NEW" TO ACC-RECORD(7:3)
           MOVE IN-AMOUNT TO FORMATTED-AMOUNT
           MOVE FORMATTED-AMOUNT(2:8) TO ACC-RECORD(10:8)
           
           WRITE ACC-RECORD
           CLOSE ACC-FILE
           
           COMPUTE IDR-AMOUNT = IN-AMOUNT * RAI-TO-IDR-RATE
           MOVE IDR-AMOUNT TO IDR-FORMATTED
           MOVE SPACES TO OUT-RECORD
           STRING "ACCOUNT CREATED WITH BALANCE: IDR " DELIMITED BY SIZE
                  IDR-FORMATTED DELIMITED BY SIZE
                  INTO OUT-RECORD.

       FINALIZE.
           IF UPDATED = "Y"
               CALL "SYSTEM" USING "mv temp.txt accounts.txt"
           END-IF
           OPEN OUTPUT OUT-FILE
           WRITE OUT-RECORD
           CLOSE OUT-FILE.
           