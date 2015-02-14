#!/bin/sh -e
#
# This script will prepare environment and start the build process

echo "Get dependencies..."
sudo apt-get install -qq --no-install-recommends git build-essential autoconf automake cmake libevent-dev libcurl4-openssl-dev libglib2.0-dev uuid-dev intltool libsqlite3-dev libmysqlclient-dev libarchive-dev libtool libjansson-dev valac libfuse-dev libzdb-dev python-setuptools python-dev
sudo apt-get build-dep -qq python-pil

echo "Get thirdpart libs..."

export PYTHONPATH=$(pwd)/thirdpart
export PATH=$PATH:$(pwd)/thirdpart

# Avatars preparing doesn't work, use already prepared archive
#mkdir -p thirdpart
#easy_install --optimize 1 --always-unzip -d $PYTHONPATH \
#    Django==1.5.1 \
#    Djblets==0.6.14 \
#    chardet==2.1.1 \
#    flup==1.0 \
#    gunicorn==0.16.1 \
#    lockfile==0.9.1 \
#    python_daemon==1.5.5 \
#    python_dateutil==1.5 \
#    six==1.4.1
curl -LO https://bitbucket.org/haiwen/seafile/downloads/seafile-server_4.0.1_x86-64.tar.gz
tar xf seafile-server_4.0.1_x86-64.tar.gz --strip-components 2 seafile-server-4.0.1/seahub/thirdpart
rm -rf thirdpart/captcha thirdpart/registration thirdpart/rest_framework thirdpart/seafdav thirdpart/seafobj
sed -i 's/python2.6/python2/' thirdpart/django-admin.py

echo "Start build process..."

echo "  Building static libevhtp & install to /usr/local"
cd src/libevhtp
cmake .
make -j4
sudo make install
cd -

echo "  Building other modules & package..."
./build-server.py "--version=4.0.1-rabits" --builddir=$(pwd) --srcdir=$(pwd)/src --thirdpartdir=$(pwd)/thirdpart --keep

echo "DONE"
