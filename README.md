Seafile package
===============

This repo contains build tools to prepare seafile distribution from sources.

Right now it will build `v4.0.1-rabits` with SVG addon (see in seafile & seahub subrepos).

Usage
-----
* Run new docker container with ubuntu 14.04
* Clone this repo inside by `git clone --recursive --branch=master ssh://git@git.parshev.net:222/sergey/seafile-package.git`
* Go into seafile-package dir and run build.sh
* Get prepared seafile tar.gz archive
