#!/bin/bash

readonly PROTO_DIR="protos"
readonly FRONTEND_DIR="frontend"
readonly TS_OUT_PACKAGE="$FRONTEND_DIR/packages/ts-protos"

# Function to check if a proto file contains a service definition
contains_service() {
    grep -q "^service " "$1"
}

# Find all .proto files and generate Python files in the same directory
find "$PROTO_DIR" -name '*.proto' | while read -r proto_file; do
    ts_out_dir=$(dirname "$TS_OUT_PACKAGE/$proto_file")
    mkdir -p "$ts_out_dir"

    protoc --proto_path="." \
        --python_out="." \
        --js_out="import_style=commonjs,binary:$TS_OUT_PACKAGE/" \
        --grpc-web_out="import_style=typescript,mode=grpcweb:$TS_OUT_PACKAGE/" \
        "$proto_file"

    if contains_service "$proto_file"; then
        python -m grpc_tools.protoc --proto_path="." \
                                    --grpc_python_out="." \
                                    "$proto_file"
    fi
done

(cd $TS_OUT_PACKAGE && npx tsc)

(cd $FRONTEND_DIR && yarn install)