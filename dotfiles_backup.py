#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
App description
"""

import sys
import os
#import re

from typing import Any
import argparse
import json

# App metas
__app_name__     : str       = "dotfiles"
__author__       : str       = "idealtitude"
__copyright__    : str       = "Copyright 2025, Stéphane Catalanotto (idealtitude)"
__credits__      : list[str] = ["Gemini"]
__maintainer__   : str       = "idealtitude"
__date__         : str       = "2025-02-015"
__version__      : str       = "0.1.0"
__status__       : str       = "Development"
__license__      : str       = "MT108"

# Constants
EXIT_SUCCESS: int = 0
EXIT_FAILURE: int = 1
CONFIG_PATH:  str = "Documents/Perso/dotfiles.json"
#APP_PATH   : str = os.path.dirname(os.path.realpath(__file__))
#APP_CWD    : str = os.getcwd()

class LogMessage:
    def __init__(self) -> None:
        self.log_colors: dict[str, str] = {
            "error":     "\033[91mError:\033[0m",
            "success":   "\033[92mSuccess:\033[0m",
            "warningr": "\033[93mWarning:\033[0m",
            "info":      "\033[94mInfo:\033[0m"
        }

    def logit(self, log_type: str, message: str) -> None:
        color: str = self.log_colors[log_type]
        print(f"{color} {message}")

class Backup:
    """This is where the backup of the dotfiles is done"""
    def __init__(self, flags: str) -> None:
        self.flags: str = flags
        self.paths: None | dict[str, str] = None
        self.home: str = self.get_home()
        self.config_path: str = f"{self.home}{CONFIG_PATH}"
        self.backup_dest: str = ''
        self.config: Any
        self.log: LogMessage = LogMessage()

        if not self.load_config():
            return None

        self.prepare_backup()

    def correct_path(self, path: str) -> str:
        if not path.endswith('/'):
            path += '/'
            return path

        return path

    def get_home(self) -> str:
        home = os.path.expanduser("~")
        home = self.correct_path(home)
        return home

    def load_config(self) -> bool:
        if not os.path.exists(self.config_path):
            self.log.logit("error", f"config file not found at the expected place -> {self.config_path}")
            return False

        fc: None|str = None

        with open(self.config_path, 'r') as fd:
            fc = fd.read()

        if fc is None:
            self.log.logit("error", f"can't load the content of the config file -> {self.config_path}")
            return False

        try:
            self.config = json.loads(fc)
            self.backup_dest = self.config["paths"]["backup"]
        except FileNotFoundError:
            self.log.logit("error", f"config file not found at {self.config_path}")
        except json.JSONDecodeError:
            self.log.logit("error", f"invalid JSON format in {self.config_path}")
        except Exception as err:
            self.log.logit("error", f"unexpected {err=}, {type(err)=}")

        return True

    def do_backup(self, fpath: str, elem: str) -> None:
        flags: str = self.flags
        rsync_cmd: list[str] = ["rsync", flags, "--progress", fpath, f"{self.backup_dest}{elem}"]
        print(rsync_cmd)

    def prepare_backup(self) -> bool:
        #print(f"{type(self.config["items"])=}")
        items: dict[str,list[str]] =  self.config["items"]
        for item in items:
            #print(f"{type(self.config["items"][item])=}")
            #tmp_path: str
            if item == "config":
                for elem in self.config["items"][item]:
                    tmp_path = f"{self.config["paths"][item]}{elem}"
                    self.do_backup(tmp_path, elem)
            elif item == "home":
                for elem in self.config["items"][item]:
                    tmp_path = f"{self.home}{elem}"
                    self.do_backup(tmp_path, elem)

        return True

# Command line arguments
def get_args() -> Any:
    """Parsing command line arguments"""
    parser: Any = argparse.ArgumentParser(
        prog=f"{__app_name__}", description="A small app to backup my dorfiles and other configuration and prefs files; it uses rsync with subprocess", epilog=f"Do {__app_name__} -h to see the help or read the doc on how to use it and configure it according to your needs"
    )

    parser.add_argument("-d", "--dryrun", action="store_true", help="Operate a rsync -n; it performs a \"dry run\" without actually transferring or deleting any files. You can see exactly what rsync would do before you actually do it")
    parser.add_argument(
        "-v", "--version", action="version", version=f"%(prog)s {__version__}"
    )

    return parser.parse_args()

def main() -> int:
    """Entry point, main function."""

    args: Any = get_args()

    flags: str = "-rvh"

    if args.dryrun:
        flags = "-n"

    backup = Backup(flags)
    if backup.config is None:
        print("\033[91mError:\033[0m can not instantiate the Backup object...")
        return EXIT_FAILURE

    return EXIT_SUCCESS

if __name__ == "__main__":
    sys.exit(main())
