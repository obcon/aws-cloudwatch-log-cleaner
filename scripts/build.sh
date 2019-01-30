#!/bin/bash
cd $(dirname $0)
cd ..
BASE=$(pwd)

PACKAGE_DIR="${BASE}/target"
UPLOAD_DIR="${BASE}/upload"
SOURCE_DIR="${BASE}/source"

mkdir -p ${PACKAGE_DIR}
mkdir -p ${UPLOAD_DIR}

pip install -t ${PACKAGE_DIR} -r ${SOURCE_DIR}/requirements.txt
cp -r ${SOURCE_DIR}/source/*.py ${PACKAGE_DIR}
cd ${PACKAGE_DIR}
zip -r ${UPLOAD_DIR}/target.zip *
