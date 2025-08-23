import mcschematic

def make_schematic(mc_filename, schem_filename):
    mc_file = open(mc_filename, 'r')
    schem = mcschematic.MCSchematic()
    
    # Generate 64 xz positions
    
    mem_start_pos = [-4, -1, 2]
    pos_list = []

    for i in range(2):
        for j in range(8):
            pos = mem_start_pos.copy() 
            if i == 1:
                pos[0] -= 2

            pos[2] += 2 * j
            # if j >= 4:
            #     pos[2] += 4
            
            for k in range(4):
                pos_list.append(pos.copy())
                    
                if k % 2 == 0:
                    pos[0] -= 7
                    pos[2] += 1 if j < 4 else -1
                else:
                    pos[0] -= 7
                    pos[2] -= 1 if j < 4 else -1
    
    # Write instruction to each position

    lines = [line.strip() for line in mc_file]
    while len(lines) < 64:
        lines.append('0000000000000000')
    
    for address, line in enumerate(lines):
        if len(line) != 16:
            exit("Invalid machine code file")
        
        face = 'east' if address < 32 else 'west'
        new_pos = pos_list[address].copy()
        #print(f"MC {line}")

        byte1 = line[:8]
        byte2 = line[8:]

        for i, char in enumerate(byte1):
            if char == '1':
                #print(f"Setting block at {new_pos} to minecraft:repeater[facing={face}]")
                schem.setBlock(tuple(new_pos), f'minecraft:repeater[facing={face}]')
            else:
                schem.setBlock(tuple(new_pos), 'minecraft:purple_wool')
                #print(f"Setting block at {new_pos} to minecraft:purple_wool")
            new_pos[1] -= 2

        new_pos[1] -= 2

        for i, char in enumerate(byte2):
            if char == '1':
                #print(f"Setting block at {new_pos} to minecraft:repeater[facing={face}]")
                schem.setBlock(tuple(new_pos), f'minecraft:repeater[facing={face}]')
            else:
                #print(f"Setting block at {new_pos} to minecraft:purple_wool")
                schem.setBlock(tuple(new_pos), 'minecraft:purple_wool')
            new_pos[1] -= 2

    # Save

    if schem_filename[-6:] == '.schem':
        schem_filename = schem_filename[:-6]

    schem.save('.', schem_filename, version=mcschematic.Version.JE_1_18_2)


