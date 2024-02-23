#!/bin/bash
ZIPFILE=FS22_AdjustableCamera.zip
if test -f "$ZIPFILE"; then
    echo "Deleting previous $ZIPFILE."
    rm $ZIPFILE
fi

echo "Creating new $ZIPFILE."
zip $ZIPFILE modDesc.xml icon.dds *.lua > /dev/null

if unzip -t "$ZIPFILE" > /dev/null; then
    echo "Zip file integrity check successful."
else
    echo "Zip file integrity check failed."
fi

if [ -n "$1" ]; then
    echo "copy $ZIPFILE to $1"
    cp $ZIPFILE "$1"
    echo "Done."
fi