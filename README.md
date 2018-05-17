# App-Cache Deployment

HTTP Requests made by our application servers are cached by a varnish reverse proxy. The VCL, testing and the deployment is versioned in this repository.

## Setup dev environment

You need Python2.7 (for batou) and Docker needs to be installed for the test environment. Run `bin/test` to install batou, run the local deployment and execute the tests

On Debian (or derivates) the user needs to be added to the docker group in order to build an image.

## Development

Edit VCL in `components/varnish` and the tests in `components/varnishtest/tests`. You might want to use fswatch to run `bin/test` whenever you edit a component file: `fswatch -o ./components | xargs -n1 ./bin/test`. Don't  watch the whole app-cache directory, since the work directory might change, which leads to an infinite loop. Took me a couple minutes to figure that one out.)

## ToDo: Cookbooks

The server is bootstrapped with chef. Cookboos is located in `./cookbooks`.

## ToDo: Deployment

To run a staging or production deployment you habe to check out the staging/production branch, maybe merge the master and run `./batou deploy staging`.
