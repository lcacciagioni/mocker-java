#!/usr/bin/env bash
${BP_URL:="https://github.com/cloudfoundry/java-buildpack.git"}
${BP_VERSION:="v2.7.1"}
git clone $BP_URL /buildpack && cd /buildpack && git checkout $BP_VERSION && git submodule update --init --recursive
# Here we detect if the file is zipped
if [$(file -b /object | grep -i zip)]; then
	unzip -o -K -d $HOME 
fi
cd $HOME
/buildpack/bin/compile $HOME $TMPDIR
if [ -d $HOME/.profile.d ]; then
	for profile in $(ls $HOME/.profile.d); do
		source $HOME/.profile.d/$profile
	done
fi
$RUN_COMMAND
