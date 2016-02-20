#!/bin/sh
set -e

: ${ENTRYPOINT_PATH:=$ENTRYPOINT_D}

if [ -d ${ENTRYPOINT_PATH} ]; then
	for f in ${ENTRYPOINT_PATH}/*.sh; do
		echo "$0: running $f"; . "$f" ;
	done
fi

exec "$@"
