test: foodcritic unit integration

foodcritic:
	foodcritic --context -t ~FC078 -t ~FC048 cookbooks/zeit-app-cache

unit:
	chef exec rspec

integration:
	@kitchen destroy batou
	@kitchen converge batou
	@./batou deploy kitchen
	@kitchen converge batou
	@kitchen verify batou

# For local development
batou:
	@./batou --fast deploy kitchen
	@kitchen verify batou

doc:
	$(MAKE) -C docs/

.PHONY: test foodcritic unit integration batou doc
