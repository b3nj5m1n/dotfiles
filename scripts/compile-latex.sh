#!/bin/sh

# https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/compiler

# Compiles latex

file=$(readlink -f "$1")
dir=${file%/*}
base="${file%.*}"
ext="${file##*.}"

if [ -z "$2" ]
then
    outputDir="$dir"
else
    outputDir="$2"
fi

echo "$outputDir"

cd "$dir" || exit 1

textype() { \
	command="pdflatex"
	( head -n5 "$file" | grep -qi 'xelatex' ) && command="xelatex"
	$command --output-directory="$outputDir" "$base" &&
	grep -qi addbibresource "$file" &&
	biber --input-directory "$dir" "$base" &&
	$command --output-directory="$outputDir" "$base" &&
	$command --output-directory="$outputDir" "$base"
}

case "$ext" in
	# Try to keep these cases in alphabetical order.
	tex) textype "$file" ;;
	*) head -n1 "$file" | grep "^#!/" | sed "s/^#!//" | xargs -r -I % "$file" ;;
esac
