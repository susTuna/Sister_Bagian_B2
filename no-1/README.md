# Assembly HTTP Server

This project implements an HTTP server entirely in x86-64 assembly language. It demonstrates low-level programming capabilities while providing a functional web server with various features.

## Features

### 1. Static File Serving

The server can serve static files from the `www/` directory.

![Static File Serving](https://i.imgur.com/SXPOPaf.png)

**How it works:**
- Server maps URL paths to files in the `www/` directory
- Determines MIME type based on file extensions (.html, .css, .js, etc.)
- Reads and serves file contents with appropriate HTTP headers

**Usage:**
- Place static files in the `www/` directory
- Access via `http://localhost:port/filename.ext`
- Default document is `index.html` when accessing a directory

### 2. Listening on Custom Port

The server can bind to a user-specified port, allowing for flexible deployment.

![Custom Port](https://i.imgur.com/ElcrjmT.png)

**How it works:**
- Command-line parameter is parsed to determine port number
- If no port is specified or it's invalid, a default port (6969) is used
- Socket is created and bound to the specified port

**Usage:**
```bash
# Start on default port (6969)
./build/http_server

# Start on specific port
./build/http_server 4646
```

### 3. Process Forking

The server creates a separate process for each client connection, enabling concurrent request handling.

**How it works:**
- Main process accepts new connections
- After accepting a connection, fork() creates a child process
- Child process handles the client request while parent continues listening
- Implementation around line 2142 in http_server.s:
```assembly
call fork@PLT
testl %eax, %eax
js .L325    # Error handling
je .L326    # Child process
```

### 4. HTTP Method Support

The server implements all standard HTTP methods: GET, POST, PUT, DELETE.

![HTTP Methods](https://i.imgur.com/neNaCcF.png)

**How it works:**
- Parses the first line of HTTP request to determine method type
- Routes to appropriate handler function based on method:
  - GET: Retrieve resources
  - POST: Create new resources
  - PUT: Update existing resources 
  - DELETE: Remove resources

**Usage:**
- Use appropriate HTTP clients (browsers, curl, etc.) with desired method
- Standard HTTP status codes are returned based on operation results

### 5. Request Routing

The server implements path-based routing to handle different types of requests.

![Request Routing](https://i.imgur.com/XBGiU0u.png)

**How it works:**
- Different path prefixes are routed to specific handlers:
  - `/template/`: Processes templates with variable substitution
  - `/exec/`: Executes binaries and returns their output
  - `/private/` and `/admin/`: Protected paths requiring authentication
  - Other paths: Mapped directly to files in www/ directory
- Default file (`index.html`) is served when requesting a directory

**Usage:**
- Access different functionality based on URL path patterns
- Use paths that match the server's routing configuration

### 6. [CREATIVITY] Template Rendering

The server includes a template engine for dynamic HTML generation.

![Template Rendering](https://i.imgur.com/XBGiU0u.png)

**How it works:**
- Templates contain placeholders in `{{ variable_name }}` format
- Server replaces placeholders with actual values at runtime
- Templates are loaded from files in the `www/templates/` directory

**Usage:**
- Create HTML templates with `{{ variable }}` syntax in `www/templates/`
- Access templates via `http://localhost:port/template/template_name`
- Example: `welcome.html` template displays personalized content

### 7. [CREATIVITY] Authentication System

The server implements HTTP Basic Authentication for protecting resources.

![Authentication System](https://i.imgur.com/PK9ClLc.png)

**How it works:**
- Specific paths (`/private/`, `/admin/`) are protected
- When accessing protected resources, server checks Authorization header
- If missing or invalid, server returns 401 Unauthorized with WWW-Authenticate header
- Uses hardcoded credentials (admin/password123, user1/userpass)

**Usage:**
- Access protected content at `/private/` or `/admin/` paths
- Browser will prompt for username/password
- Authenticated users can access the protected resources

### 8. [CREATIVITY] Logging System

Comprehensive logging of server activities for monitoring and debugging.

![Logging System](https://i.imgur.com/psdm2it.png)

**How it works:**
- Multiple log levels: INFO, WARNING, ERROR
- Logs HTTP method, URL path, response status, and timestamps
- Can output to file (server.log) or standard output
- Detailed error reporting for debugging

**Usage:**
- Server automatically logs activities during operation
- Check `server.log` file for request history and error details
- Console output shows real-time server activity

### 9. Binary Integration

The server can execute binaries and incorporate their output in HTTP responses.

![Binary Integration](https://i.imgur.com/k9wroZY.png)

**How it works:**
- Binaries in the `bin/` directory can be executed by the server
- Output from the binary is captured and sent as HTTP response
- Supports binary programs that output HTML or other content types

**Usage:**
- Place executable programs in the `bin/` directory
- Access via `http://localhost:port/exec/binary_name`
- Example: `sysinfo` binary provides system information in HTML format

## Building and Running

### Prerequisites
- Linux environment with GCC and development tools
- Make utility

### Building
```bash
# Navigate to the project directory
cd /path/to/http-server

# Build the project
make
```

### Running
```bash
# Run the server (default port 6969)
./build/http_server

# Run on a specific port
./build/http_server 4646
```