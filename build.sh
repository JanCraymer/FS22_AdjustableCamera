#!/bin/bash
ZIPFILE=FS22_AdjustableCamera.zip
if test -f "$ZIPFILE"; then
    echo "Deleting previous $ZIPFILE."
    rm FS22_AdjustableCamera.zip
fi

echo "Creating new $ZIPFILE."
zip FS22_AdjustableCamera.zip modDesc.xml icon.dds *.lua > /dev/null

if unzip -t "$ZIPFILE" > /dev/null; then
    echo "Zip file integrity check successful."
else
    echo "Zip file integrity check failed."
fi