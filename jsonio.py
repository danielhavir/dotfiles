import os
import json


def readjson(path):
    with open(path, "r") as f:
        o = json.load(f)
    return o


def writejson(o, path):
    with open(path, "w") as f:
        json.dump(o, f)
