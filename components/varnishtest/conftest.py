# -*- coding: utf-8 -*-
import os
import logging
import time
import pytest
import subprocess


@pytest.fixture()
def varnishtest():
    def segment(line):
        return (line.strip('*#-+').split() + [line])[0]

    def validate(line):
        for token in 'not match', 'not pass', 'not true', '--- ':
            if token in line.lower():
                return False
        return True

    def run(vtc_file):
        path = 'tests/{}'.format(vtc_file)
        print('varnishtest {}'.format(path))
        proc = subprocess.run(
            ["varnishtest", path], stdout=subprocess.PIPE)

        out = proc.stdout.decode("utf-8")
        print(out)
        assert '{} passed'.format(path) in out, (
            'tests/{} did not pass'.format(vtc_file))
    return run
