#!/bin/sh -e
#
# This script will prepare environment and start the build process

echo "Get dependencies..."
sudo apt-get install -qq --no-install-recommends git build-essential autoconf automake cmake libevent-dev libcurl4-openssl-dev libglib2.0-dev uuid-dev intltool libsqlite3-dev libmysqlclient-dev libarchive-dev libtool libjansson-dev valac libfuse-dev libzdb-dev python-setuptools python-dev

echo "Get thirdpart libs..."

mkdir thirdpart
export PYTHONPATH=$(pwd)/thirdpart
easy_install --optimize 1 --always-unzip -d $PYTHONPATH \
    Django==1.5.1 \
    Djblets==0.6.14 \
    chardet==2.1.1 \
    flup==1.0 \
    gunicorn==0.16.1 \
    lockfile==0.9.1 \
    python_daemon==1.5.5 \
    python_dateutil==1.5 \
    six==1.4.1

echo "Start build process..."

echo "  Building static libevhtp & install to /usr/local"
cd src/libevhtp
cmake .
make -j4
sudo make install
cd -

echo "  Building other modules & package..."
./build-server.py --version=4.0.1 --builddir=$(pwd) --srcdir=$(pwd)/src --thirdpartdir=$(pwd)/thirdpart --keep

echo "DONE"
