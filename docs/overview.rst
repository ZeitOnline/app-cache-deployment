=========
Überblick
=========

Der ``internal-lb`` ist ein Loadbalancer, der RZ-interne HTTP-Requests zwischen unseren Diensten (sowie an 3rdparty-Dienste) bündelt.
Ein varnish ist vorhanden, um manche Dienste zu cachen und zu entlasten.
Außerdem steht ein memcache zur Verfügung (der von zeit.web fürs Caching genutzt wird).


.. image:: ./architecture.png
    :alt: Architecture Overview
    :align: center
    :target: _images/architecture.png

Fast alle Backends drehen eine "Schleife", d.h. der Varnish dreht sich wieder um und geht über den haproxy.
Das dient dazu, dass haproxy im Gegensatz zu varnish folgende Features bietet:

* HTTPS für Backends
* DNS periodisch neu auflösen (nicht nur beim VCL kompilieren)
