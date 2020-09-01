#!/usr/bin/env bash

case "$1" in
    "make-patches" | "make")
	echo "Making patches..."
	rm -r patches/
	cd operating-systems-lecture/
	git format-patch --output-directory ../patches/ --full-index --no-stat -N origin/master
	cd ..
	echo "Patches saved to patches/"
    ;;
    "apply-patches" | "apply")
	echo "Applying all patched from patches/"
	if [ ! -d  "operating-systems-lecture" ]; then
            git clone https://github.com/victorRodriguez/operating-systems-lecture/
        fi
	cd operating-systems-lecture/
	git fetch
	git reset --hard origin/master
	find "../patches/"*.patch -print0 | xargs -0 git am --3way --ignore-whitespace
	echo "Applied all patches"
    ;;
esac
