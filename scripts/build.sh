#!/bin/bash
cd $(dirname $0)
cd ..
BASE=$(pwd)

mkdir ${BASE}/target
pip install -t ${BASE}/target -r ${BASE}/source/requirements.txt
cp -r ${BASE}/source/*.py ${BASE}/target
cd ${BASE}/target
zip -r ${BASE}/target.zip *
