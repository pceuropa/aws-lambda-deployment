"""
File: main.py
Author: Rafal Marguzewicz
Description: Example python file to check available modules on AWS Lambda
"""

# from __future__ import print_function
import logging
import sys

log = logging.getLogger(__name__)
log.addHandler(logging.StreamHandler())
log.setLevel(logging.INFO)


def handler(event=None, context=None):
    # print(set([i.split('.')[0] for i in sys.modules]))
    log.info(set([i.split('.')[0] for i in sys.modules]))


if __name__ == "__main__":
    handler()
