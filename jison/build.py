#!/usr/bin/env python

import os
import commands
import json


# 1. Compile Human
os.system("jison human.jison")

# 2. Run unit tests
def unittest(case, expected_result):
    unittest_filename = case + ".human"
    run_result = commands.getoutput("node human.js " + unittest_filename)
    assert json.loads(run_result) == expected_result, [run_result == expected_result]


unittest("simple", {"count": 3, "class": 'Week'})
