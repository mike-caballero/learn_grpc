#!/bin/bash

readonly PROTO_DIR="protos"
readonly TS_OUT_DIR="frontend/ts-protos"

# Function to check if a proto file contains a service definition
contains_service() {
    grep -q "^service " "$1"
}

mkdir -p "$TS_OUT_DIR"

# Find all .proto files and generate Python files in the same directory
find "$PROTO_DIR" -name '*.proto' | while read -r proto_file; do
    ts_out_path="$TS_OUT_DIR/$(dirname "$proto_file")"
    mkdir -p "$ts_out_path"

    protoc --proto_path="." \
        --python_out="." \
        --js_out="import_style=commonjs,binary:$ts_out_path" \
        --grpc-web_out="import_style=typescript,mode=grpcwebtext:$ts_out_path" \
        "$proto_file"

    if contains_service "$proto_file"; then
        python -m grpc_tools.protoc --proto_path="." \
                                    --grpc_python_out="." \
                                    "$proto_file"
    fi
done