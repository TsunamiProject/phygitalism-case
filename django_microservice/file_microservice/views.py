from pathlib import Path
import os
import datetime
import json

from django.shortcuts import render
from django.http import HttpResponse, JsonResponse

from file_microservice.config import root_directory

'''Return a json with info about files from root directory that is specified in config.py
        Response example: 
        {
            “data”:[
                {
                    “name”: ”name”,
                    “type”: “file”,
                    “time”: “time”
                },
                {
                    “name”: ”name”,
                    “type”: “file”,
                    “time”: “time”
                },
            ]
        } 
'''
def dir_files(request):
    directory = root_directory  # takes root directory path from config.py

    if os.path.exists(directory):   # if dir is found then create a filename list and dictionary for response
        files = os.listdir(directory)
        file_dict = {'data':[]}
        for i in range(len(files)):
            if os.path.isfile(directory+files[i]):  # checking if it's a file or directory in the summed path
                filename = os.path.basename(files[i]) # create a turple - (<file_name>, <file_ext>)
                file_dict['data'].append({
                                        'name': os.path.splitext(filename)[0],
                                        'type': os.path.splitext(filename)[1],
                                        'time': str(datetime.datetime.fromtimestamp(os.path.getctime(directory + files[i])))
                                        })
        return JsonResponse(file_dict, json_dumps_params={'ensure_ascii': False})
    else:
        return HttpResponse(f'Directory {directory} is not found!')
    
def home(request):
    return render(request, 'index.html')