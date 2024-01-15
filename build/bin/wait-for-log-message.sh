#!/bin/bash

log_file=/Talend/Runtime_ESBSE/container/log/tesb.log

regex=""
while [ -n "$1" ]; do
	if [ -n "$regex" ]; then
		regex="$regex.*"
	fi
	regex="$regex$1"
	shift
done

echo "Waitning for $regex"

( tail -f -n0 $log_file & ) | egrep -q -i "$regex"

echo "Continue...."