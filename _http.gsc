/* 
*  HTTP Library For Plutonium T6 (Black Ops II)
*  Author:  Budiworld
*  GitHub:  https://github.com/Yallamaztar/T6HttpLibrary
*  Version: 0.1
*/ 

init()
{
    setDvar("sv_cheats", "1");
    setDvar("scr_allowFileIo", "1");
    level.index = 1; 
    /* 
    * httpRequest(METHOD: str, url: str, debug: bool)
    */
    // Example request
    req = httpRequest("GET", "http://ip-api.com/json/24.48.0.1"); 
    PrintLn(req);
}

httpRequest( method, url, data, debug ) {
    if (!isDefined( method ) || !isDefined( url )) {
        PrintLn( "HTTP Request Error: Missing required parameters" );
        return;
    }

    request = SpawnStruct();
    request.id       = "[T6HTTPREQ" + level.index + "]";
    request.method   = method;
    request.url      = url;
    request.data     = isDefined(data) ? data : "";
    request.debug    = isDefined(debug) ? debug : false;

    thread writeHttpRequest( request );
}

writeHttpRequest( request ) {
    json = "{\"id\":\"" + request.id + "\",\"method\":\"" + request.method + "\",\"url\":\"" + request.url + "\",\"data\":\"" + request.data + "\"}";
    // printLn("[ JSON Content ]: " + json);
    file = fs_fopen("http_request_" + request.id + ".json", "write");
    fs_write(file, json);
    fs_fclose(file);

    level.index += 1;
    wait 1;

    thread readHttpResponse( request );
}

readHttpResponse( request ) {
    reqFile = "http_response_" + request.id + ".json";
    while (!fs_testfile(reqFile)) {
        wait 0.1;
    }

    file     = fs_fopen(reqFile, "read");
    response = fs_readline(file);
    fs_fclose(file);
    fs_remove(reqFile);

    if (request.debug == true) {
        PrintLn("[ Response ]: " + response);
    } else {
        PrintLn("niggerrr")
    }
    
    return response;
}
