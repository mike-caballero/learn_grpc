#!/bin/bash

brew install protobuf@3
# https://github.com/protocolbuffers/protobuf-javascript/issues/127#issuecomment-1204202844
brew link --overwrite protobuf@3
brew install protoc-gen-grpc-web
brew install nginx

# Setup Python virtual environment if it doesn't exist
cd backend
if [ ! -d ".backend" ]; then
  python3 -m venv .backend_venv
fi
source .backend_venv/bin/activate
pip install -r requirements.txt

# Setup JavaScript
cd ../frontend
yarn install

# Setup protos
cd ..
tools/generate_protos.sh