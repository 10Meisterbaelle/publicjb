#!/usr/bin/env bash
if [[ "$ostype" == "linux"* ]]; then # Linux usage of repo.me
	cd "$(dirname "$0")" || exit

	clear

	rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release

	apt-ftparchive packages ./debians > Packages
	gzip -c9 Packages > Packages.gz
	xz -c9 Packages > Packages.xz
	zstd -c19 Packages > Packages.zst
	bzip2 -c9 Packages > Packages.bz2

	apt-ftparchive release -c ./assets/repo/repo.conf . > Release

	echo "Repository Updated, thanks for using repo.me!"
elif [[ "$(uname)" == Darwin ]]; then # macOS usage of repo.me
	cd "$(dirname "$0")" || exit
	clear
	echo "Checking for Homebrew & wget..."
	if test ! "$(which brew)"; then
                /bin/bash -c -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        fi
	brew list --verbose wget || brew install wget
	clear

	echo "apt-ftparchive compiled by @Diatrus" # credits to Hayden!
	wget -q -nc https://apt.procurs.us/apt-ftparchive # assuming Homebrew is already installed, download apt-ftparchive via wget
	sudo chmod 751 ./apt-ftparchive # could change this to be pointed in documentation, but people don't like to read what needs READING. i'll think about it later.
	
	rm {Packages{,.xz,.gz,.bz2,.zst},Release{,.gpg}}

	./apt-ftparchive packages ./debians > Packages
	gzip -c9 Packages > Packages.gz
	xz -c9 Packages > Packages.xz
	zstd -c19 Packages > Packages.zst
	bzip2 -c9 Packages > Packages.bz2

	./apt-ftparchive release -c ./assets/repo/repo.conf . > Release

	echo "Repository Updated, thanks for using repo.me!"
elif [[ "$(uname -r)" == *Microsoft ]]; then # WSL usage of repo.me
	cd "$(dirname "$0")" || exit

	clear

	rm Packages Packages.xz Packages.gz Packages.bz2 Packages.zst Release

	apt-ftparchive packages ./debians > Packages
	gzip -c9 Packages > Packages.gz
	xz -c9 Packages > Packages.xz
	zstd -c19 Packages > Packages.zst
	bzip2 -c9 Packages > Packages.bz2

	apt-ftparchive release -c ./assets/repo/repo.conf . > Release

	echo "Repository Updated, thanks for using repo.me!"
else
    echo "Running an unsupported operating system...? Contact me via Twitter @truesyns" # incase I've missed support for something, they should be contacting me. 
fi
