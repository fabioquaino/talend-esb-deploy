#!/bin/bash

echo "Copìa configuraciones en /Talend/Runtime_ESBSE/container/etc"

rsync -v          --dirs --checksum /config/  /Talend/Runtime_ESBSE/container/etc

echo "Copìa boundles en /Talend/Runtime_ESBSE/container/deploy"

rsync -v --delete --dirs --checksum /deploy/  /Talend/Runtime_ESBSE/container/deploy