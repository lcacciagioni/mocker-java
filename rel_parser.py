#!/usr/bin/env python
# This script will try to parse and export as the env vars in the release yaml file and 
# the default web command
import yaml
import argparse
import os
from subprocess import call

parser = argparse.ArgumentParser("Execute java apps like if you are in Cloud Foundry")
parser.add_argument("file_to_read", help="File path to where the release file is")
args = parser.parse_args()

try:
    f = open(args.file_to_read, "r")
    release = yaml.load(f)
    if os.getenv("RUN_COMMAND") == None and len(release['default_process_types']['web']) > 0:
        os.environ["RUN_COMMAND"] = str(release['default_process_types']['web'])
    if len(release['config_vars']) > 0:
        for var, value in release['config_vars']:
            os.environ[str(var)] = str(value)
except IOError:
    print 'Cannot open:', args.file

print "Runing ", os.environ["RUN_COMMAND"]
call(str(os.environ["RUN_COMMAND"]), shell=True)
