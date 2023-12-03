#!/bin/bash

# Directory containing proto files
PROTO_DIR="protos"

# Function to check if a proto file contains a service definition
contains_service() {
    grep -q "^service " "$1"
}

# Find all .proto files and generate Python files in the same directory
find "$PROTO_DIR" -name '*.proto' | while read -r proto_file; do
    protoc --python_out="." --proto_path="." "$proto_file"

    if contains_service "$proto_file"; then
        python -m grpc_tools.protoc --proto_path="." \
                                    --grpc_python_out="." \
                                    "$proto_file"
    fi
done


