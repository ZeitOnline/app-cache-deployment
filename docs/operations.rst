================
Betriebshandbuch
================

Deployment
==========

Mit batou::

    ./deploy production  # Oder `staging`


Prozesssteuerung
================

varnish (v5) ist als OS-Paket installiert, neustarten mit::

    /etc/init.d/varnish stop
    /etc/init.d/varnish start

(Wir hatten schon Probleme, dass ein ``restart`` nicht richtig funktioniert hat)

Normalerweise muss nur sehr selten wirklich der Prozess neugestartet werden, meistens genügt es, die VCL neu zu kopieren (was das ``./deploy`` tut), das Äquivalent dafür ist ``/etc/init.d/varnish reload``.


Logdateien
==========

Meldungen landen im ``/var/log/syslog``.
