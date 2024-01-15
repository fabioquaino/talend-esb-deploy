#!/bin/bash

echo "Reinicia componentes..."
echo
echo "Reinicia datasources..."
find /Talend/Runtime_ESBSE/container/deploy/ -name "datasource*" -print -exec touch {} \; -exec sleep 5 \;
echo
echo "Reinicia boundle de login..."
find /Talend/Runtime_ESBSE/container/deploy/ -name "*login*.xml" -print -exec touch {} \; -exec sleep 5 \;
echo
echo "Reinicia SOAP Services..."
find /Talend/Runtime_ESBSE/container/deploy/ -name "*.kar" -print -exec touch {} \; -exec sleep 5 \;
echo
echo "Reinicia REST Services..."
find /Talend/Runtime_ESBSE/container/deploy/ -name "CbaInterop*.jar" -print -exec touch {} \; -exec sleep 5 \;

echo
echo "Componentes reiniciados."
