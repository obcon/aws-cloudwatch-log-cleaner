#!/bin/bash
cd $(dirname $0)
cd ..
BASE=$(pwd)

PACKAGE_DIR="${BASE}/target"
UPLOAD_DIR="${BASE}/upload"
SOURCE_DIR="${BASE}/source"

source ${BASE}/project.env

mkdir -p ${PACKAGE_DIR}
mkdir -p ${UPLOAD_DIR}

pip install -t ${PACKAGE_DIR} -r ${SOURCE_DIR}/requirements.txt
rsync -avvP ${SOURCE_DIR}/ ${PACKAGE_DIR}
cd ${PACKAGE_DIR}
zip -r ${UPLOAD_DIR}/aws-cloudwatch-log-cleaner-${VERSION}.zip *
