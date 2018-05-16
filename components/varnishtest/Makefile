test:
	docker run -it \
		--volume {{component.vcldir}}/default.vcl:/etc/varnish/default.vcl \
		--volume {{component.vcldir}}/vcl_includes:/etc/varnish/vcl_includes \
		--volume {{component.workdir}}:/varnishtest \
		-t varnish_test_app_cache




