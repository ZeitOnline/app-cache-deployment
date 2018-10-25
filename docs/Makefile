# convenience makefile to set up the project documentation

htdocs/objects.inv: $(shell git ls-files )
	pipenv sync
	pipenv run build

serve:
	pipenv sync
	pipenv run serve

Pipfile.lock: Pipfile
	@pipenv install

clean:
	git clean -fXd

.PHONY: clean serve
