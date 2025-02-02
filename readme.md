# T6 HTTP Library

A library for handling HTTP requests in **Plutonium T6 (Black Ops II)** 
- **GSC script** (`_http.gsc`) to send HTTP requests from within the game
- **Python script** (`t6_http_handler.py`) to process and execute those requests on the server side

---

## Features

- **GSC Script**:
  - Sends HTTP requests (`GET` and `POST`) from the game
  - Logs requests in a format readable by the Python script
  - Automatically assigns unique IDs to each request

- **Python Script**:
  - Monitors the game log for HTTP requests
  - Executes HTTP requests using the `requests` library
  - Handles duplicate requests and errors gracefully

---

## Requirements

### For the Python Script:
- Python 3.x
- `requests` library (`pip install requests`)

---

## Installation

- **GSC Script**:
   - Place `_http.gsc` in your `%LOCALAPPDATA%\Plutonium\storage\t6\scripts` folder

---

## Usage

### GSC Script
To send an HTTP request from the game, call the `ExecuteHttpRequest` function:
```php
ExecuteHttpRequest("GET", "https://example.com", "");
ExecuteHttpRequest("POST", "https://example.com", "param1=value1&param2=value2");
```

---

### Python Script

Run the Python script to process requests:
```bash
python t6_http_handler.py
```

---

## How It Works
- ### The GSC script logs HTTP requests in the following format:
```jsx
[T6HTTPREQ<ID>]: {"ID":"T6HTTPREQ<ID>","method":"<METHOD>","url":"<URL>","data":"<DATA>"} 
```
- ### Example:
```jsx
[T6HTTPREQ1]: {"ID":"T6HTTPREQ512","method":"GET","url":"https://example.com","data":""}
```
-  The Python script monitors the log for these entries, parses them, and executes the HTTP requests
-  The Python script ensures each request is processed only once by tracking unique request IDs
  
---

## Example
### GSC Script
```php
init() {
    level.index = 0; 

    // Calling the function
    httpRequest("GET", "https://jsonplaceholder.typicode.com/posts/1", "");
}

httpRequest( method, url, data ) {
    if (!isDefined( method ) || !isDefined( url )) {
        PrintLn( "HTTP Request Error: Missing required parameters" );
        return;
    }

    request = SpawnStruct();
    request.id       = "[T6HTTPREQ" + level.index + "]";
    request.method   = method;
    request.url      = url;
    request.data     = isDefined(data) ? data : "";

    thread writeHttpRequest( request );
}

```

---

# Come Play on Brownies SND (T6) 🍰
### Why Brownies? 🤔
- **Stability:** Brownies delivers a consistent, lag-free experience, making it the perfect choice for players who demand uninterrupted action
- **Community:** The players at Brownies are known for being helpful, competitive, and fun—something Orion can only dream of
- **Events & Features:** Brownies is constantly running unique events and offers more server-side customization options than Orion, ensuring every game feels fresh

---

#### [Brownies Discord](https://discord.gg/FAHB3mwrVF) | [Brownies IW4M](http://152.53.132.41:1624/) | Made With ❤️ By Budiworld

