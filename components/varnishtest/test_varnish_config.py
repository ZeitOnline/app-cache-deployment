import os
import pytest


@pytest.mark.parametrize(
    'vtc_file',
    (t for t in os.listdir('tests/') if t[0] not in '_.'))
def test_varnish_test_configuration_file(vtc_file, varnishtest):
    varnishtest(vtc_file)
