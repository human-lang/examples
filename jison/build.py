#!/usr/bin/env python
# -*-coding:utf-8-*-

import os
import commands
import json


# 1. Compile Human
os.system("jison human.jison")

# 2. Run unit tests
def unittest(case, expected_result):
    unittest_filename = case + ".human"
    status, run_result = commands.getstatusoutput("node human.js " + unittest_filename)

    if status is 0:
        assert json.loads(run_result) == expected_result, [run_result, json.dumps(expected_result)]
    else:
        print run_result

unittest("simple", json.loads("""{"value": null, "class": "Week"}"""))

string_json = """{"value": "Human Programming Language", "class": "String"}"""
unittest("string_basic", json.loads(string_json))

book_json = """{"value": {"name": "Human Programming Language", "author": "David Chen"}, "class": "Book"}"""
unittest("class", json.loads(book_json))
