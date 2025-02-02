# --------------------------------------------------------- #
#   HTTP Library For Plutonium T6 (Black Ops II)            #
#   Author:  Budiworld                                      #
#   GitHub:  https://github.com/Yallamaztar/T6HttpLibrary   #
#   Version: 0.1                                            #
# --------------------------------------------------------- #

import os, json, time
import requests

SCRIPTDATA_DIR = os.path.join(os.environ["LOCALAPPDATA"], "Plutonium", "storage", "t6", "raw", "scriptdata")

def get_all_requests():
    reqs = []
    for file in os.listdir(SCRIPTDATA_DIR): 
        if file.startswith("http_request_") and file.endswith(".json"):
            reqs.append(file[13:][:-5])
    return reqs

def http_request(method: str, url: str, data: str = None):
    try:
        method = method.upper()
        if method == "GET":
            response = requests.get(url)
        elif method == "POST":
            response = requests.post(url, data=data)
        else:
            print(f"Unsupported HTTP method: {method}")
            return None
        
        return response
    
    except requests.exceptions.RequestException as e:
        print(f"Request failed: {e}")
        return None

def process_request():
    while True:
        reqs = get_all_requests()
        for request in reqs:
            with open(os.path.join(SCRIPTDATA_DIR, f"http_request_{request}.json"), 'r', encoding='utf-8') as req:
                req_data = json.load(req)

            method = req_data.get("method", "GET").upper()
            url    = req_data.get("url", "")
            data   = req_data.get("data", "")

            response = http_request(method, url, data)
            if response is not None:
                response_path = os.path.join(SCRIPTDATA_DIR, f"http_response_{request}.json")
                with open(response_path, "w") as resp_file:
                    json.dump(response.text, resp_file)
                
            os.remove(os.path.join(SCRIPTDATA_DIR, f"http_request_{request}.json"))
        
        time.sleep(1)

if __name__ == "__main__":
    process_request()