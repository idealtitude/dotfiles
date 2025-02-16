#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
App description
"""

import sys
import os
import subprocess
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
__version__      : str       = "0.1.1"
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
        self.home: str = os.path.expanduser("~")
        self.config_path: str = os.path.join(self.home, CONFIG_PATH)
        self.backup_dest: str = ''
        self.config: Any
        self.log: LogMessage = LogMessage()

        if not self.load_config():
            return None

        self.prepare_backup()

    def load_config(self) -> bool:
        try:
            with open(self.config_path, 'r') as fd:
                self.config = json.load(fd)
                self.backup_dest = self.config["paths"]["backup"]
                return True
        except (FileNotFoundError, json.JSONDecodeError, KeyError) as e:
            self.log.logit("error", f"config -> {e}") # More informative message
        except Exception as e:
            self.log.logit("error", f"unexpected config error -> {e}")
        return False # Return False only if an exception occurred

    #def do_backup(self, fpath: str, elem: str) -> None:
        # flags: str = self.flags
        # rsync_cmd: list[str] = ["rsync", flags, "--progress", fpath, f"{self.backup_dest}{elem}"]
        # print(rsync_cmd)
    def do_backup(self, fpath: str, elem: str) -> None:
        rsync_cmd = ["rsync", self.flags, "--progress", fpath, os.path.join(self.backup_dest, elem)]
        try:
            sync_result = subprocess.run(rsync_cmd, capture_output=True, text=True, check=True)  # Capture output
            self.log.logit("success", f"backed up {fpath} to {self.backup_dest}")
            # print(sync_result.stdout)  # If you want to see rsync's output
        except subprocess.CalledProcessError as e:
            self.log.logit("error", f"rsync failed -> {e}")
            print(e.stderr)  # Print stderr for debugging
        except FileNotFoundError:
            self.log.logit("error", "rsync not found. Is it installed?")
        except Exception as e:
            self.log.logit("error", f"an unexpected error occurred -> {e}")

    def prepare_backup(self) -> bool:
        for item_type, items in self.config.get("items", {}).items(): # Handle missing "items"
            base_path = self.config.get("paths", {}).get(item_type) if item_type in self.config.get("paths", {}) else self.home if item_type == "home" else None
            if base_path:
                for item in items:
                    tmp_path = os.path.join(base_path, item)
                    self.do_backup(tmp_path, item)
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
