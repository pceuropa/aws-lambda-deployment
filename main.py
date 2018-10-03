"""
File: example.py
Author: Rafal Marguzewicz
Email: info@pceuropa.net
Gitlab: https://gitlab.com/pceuropa/
Description: Example python file to check available modules on Aws Lambda
"""

# from __future__ import print_function
import logging
import sys

log = logging.getLogger(__name__)
log.setLevel(logging.INFO)


def handler(event, context):
    # print(set([i.split('.')[0] for i in sys.modules]))
    log.info(set([i.split('.')[0] for i in sys.modules]))
