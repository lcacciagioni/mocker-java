#!/usr/bin/env bash

if [ -z "$BP_URL" ]; then
	export BP_URL="https://github.com/cloudfoundry/java-buildpack.git"
else
	echo "Buildpack defined by user"
fi

if [ -z "$BP_VERSION" ]; then
	export BP_VERSION="v2.7.1"
else
	echo "Buildpack version defined by user"
fi

git clone $BP_URL /buildpack && cd /buildpack && git checkout $BP_VERSION && git submodule update --init --recursive

# Here we detect if the file is zipped
if [ "$(file /object | grep -b -i zip | wc -l)" -eq 1 ];then
	unzip -o -K /object -d $HOME
fi
cd $HOME
/buildpack/bin/compile $HOME $TMPDIR && /buildpack/bin/release $HOME > /opt/release.yml
if [ -d $HOME/.profile.d ]; then
	for profile in $(ls $HOME/.profile.d); do
		source $HOME/.profile.d/$profile
	done
fi
/rel_parser.py /opt/release.yml
