#!/bin/bash

brew install protobuf@3
# https://github.com/protocolbuffers/protobuf-javascript/issues/127#issuecomment-1204202844
brew link --overwrite protobuf@3
brew install protoc-gen-grpc-web