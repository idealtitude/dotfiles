#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""dotfiles
A simple, light, and fast utility to manage my dotfiles backup....
"""

import sys
import os

import subprocess
import json
import argparse

# App version
__version__ = '0.1.0'

# Constants
EXIT_SUCCESS = 0
EXIT_FAILURE = 1
APP_PATH = os.path.dirname(os.path.realpath(__file__))
#APP_CWD = os.getcwd()

# Command line arguments
parser = argparse.ArgumentParser(prog='dotfiles', description='STARTER', epilog='Help and documentation: man dotfiles')

parser.add_argument('-d', '--diffonly', action='store_true', help='Only execute a diff without syncing')
parser.add_argument('-t', '--target', nargs='?', help='Target: f (files) | d (dirs) | a (all); default: all')
parser.add_argument('-v', '--version', action='version', version=f'%(prog)s {__version__}')

_args = parser.parse_args()

def load_json():
    fd = open(f'{APP_PATH}/data/dotfiles.json', 'r')
    fc = fd.read()
    fd.close()
    return json.loads(fc)

def exec_cmd(cmd):
    res = subprocess.Popen(cmd, stdout=subprocess.PIPE, encoding='utf8')
    while True:
        output = res.stdout.readline()
        if output == '' and res.poll() is not None:
            break
        if output:
            print(output.strip())
    rc = res.poll()
    return rc

def process_target(target, cmd, opts, src, dest):
    for e in target:
        todo = [cmd]
        if opts is not None:
            todo.append(opts)
        todo.append(f'{src}{e}')
        todo.append(f'{dest}{e}')
        exec_cmd(todo)

# Entry point
def main(args):
    targets = ['f', 'd', 'a']
    target = 'a'

    files = load_json()
    src = files['source']
    dest = files['dest']

    if args.target and args.target in targets:
        target = args.target

    cmd = None
    opts = None

    if args.diffonly:
        cmd = 'diff'
        opts = '-q'
    else:
        cmd = 'rsync'
        opts = '-rhv'

    if target == 'a':
        process_target(files['files'], cmd, opts, src, dest)
        process_target(files['folders'], cmd, opts, src, dest)
    elif target == 'f':
        process_target(files['files'], cmd, opts, src, dest)
    if target == 'd':
        process_target(files['folders'], cmd, opts, src, dest)

    return EXIT_SUCCESS

if __name__ == '__main__':
    sys.exit(main(_args))
