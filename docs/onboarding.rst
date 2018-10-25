==========
Onboarding
==========

Sandbox aufsetzen
=================

::

    $ git clone git@github.com:ZeitOnline/app-cache-deployment.git
    $ cd app-cache-deployment
    $ bin/test


Die Tests laufen mit `varnishtest`_ unter Docker, starten mit ``bin/test`` (einzelne kann man mit ``bin/test -k error_page_fallback`` anwählen).

.. _`varnishtest`: https://varnish-cache.org/docs/5.1/reference/vtc.html

Die Testdateien leben in ``component/varnishtest/tests/*.vtc``. Details dazu siehe `<http://docs.zeit.de/delivery/varnish/onboarding.html>`_.
