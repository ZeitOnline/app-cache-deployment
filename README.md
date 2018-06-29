# App-Cache Deployment

HTTP Requests made by our application servers are cached by a varnish reverse proxy. The VCL, testing and the deployment is versioned in this repository.

## Setup dev environment

You need Python2.7 (for batou) and Docker needs to be installed for the test environment. Run `bin/test` to install batou, run the local deployment and execute the tests

On Debian (or derivates) the user needs to be added to the docker group in order to build an image.

## Development

Edit VCL in `components/varnish` and the tests in `components/varnishtest/tests`.

You can use fswatch to run `bin/test` whenever you edit a component file. This runs bin/test in the background and Batou rebuilds the files and runs the tests on changes. On macOS you can do `brew install fswatch` (refer to the [fswatch repository](https://github.com/emcrisostomo/fswatch) for different OS).

Run `fswatch -o ./components | xargs -n1 ./bin/test`. Don't  watch the whole app-cache directory, since the work directory might change, which leads to an infinite loop. Took me a couple minutes to figure that one out.

## Cookbooks

The chef cookbook to bootstrap a server is located in `./cookbooks`. It basically installs a Varnish 6.0 an makes sure, that the service can be configured with batou. To test this setup locally you have to run `kitchen test`. The default of this test run is lxc. If you want to us VirtualBox you have to run it with `KITCHEN_PROVIDER="virtualbox" kitchen test`

## Deployment

To run a staging or production deployment you habe to check out the staging/production branch, maybe merge the master and run `./batou deploy staging`.
