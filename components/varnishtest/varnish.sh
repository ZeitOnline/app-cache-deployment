#!/bin/bash
exec varnishd -j unix,user=vcache -F -a :8080 -f /varnishtest/local.vcl
