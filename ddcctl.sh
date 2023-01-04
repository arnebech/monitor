#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
cd $DIR
echo $DIR

monitor1="./ddcctl -d 1"
monitor2="./ddcctl -d 2"

dim() {
	$monitor1 -b 1
	$monitor2 -b 1
}

medium() {
  $monitor1 -b 40
  $monitor2 -b 40
}

normal() {
	$monitor1 -b 70
	$monitor2 -b 70
}

case "$1" in
	dim|normal|medium) $1;;
	*)	# no match
		echo "unknown option? Try dim|normal|medium"
		;;
esac
