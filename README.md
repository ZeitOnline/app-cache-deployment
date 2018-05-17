# App-Cache Deployment

HTTP Requests made by our application servers are cached by a varnish reverse proxy. The VCL, testing and the deployment is versioned in this repository.

## Setup dev environment

You need Python 3 >= 3.6 and Docker needs to be installed for the test environment. Run `bin/test` to install batou, run the local deployment and execute the tests

## Development

Edit VCL in `components/varnish` and the tests in `components/varnishtest/tests`.

## ToDo: Cookbooks

The server is bootstrapped with chef. Cookboos is located in `./cookbooks`.

## ToDo: Deployment

To run a staging or production deployment you habe to check out the staging/production branch, maybe merge the master and run `./batou deploy staging`.
