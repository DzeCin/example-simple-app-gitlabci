#!/usr/bin/env bash

set -e

npm install
ng build code --prod --output-path=../build
cd .. || exit
docker build --tag=code-frontend .
