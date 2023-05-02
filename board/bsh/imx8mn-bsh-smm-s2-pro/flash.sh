#!/bin/bash

if [ $# -eq 0 ]; then
    OUTPUT_DIR=output
else
    OUTPUT_DIR=$1
fi

if ! test -d "${OUTPUT_DIR}" ; then
    echo "ERROR: no output directory specified."
    echo "Usage: $0 OUTPUT_DIR"
    echo ""
    echo "Arguments:"
    echo "    OUTPUT_DIR    The Buildroot output directory."
    exit 1
fi

IMAGES_DIR=${OUTPUT_DIR}/images

${OUTPUT_DIR}/host/bin/uuu -v -b emmc_all \
  ${IMAGES_DIR}/flash.bin \
  ${IMAGES_DIR}/sdcard.img

