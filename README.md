# Learning gRPC

Mini-project to learn setting up and maintaining a gRPC backend.

1. `chmod +x tools/*`
2. `tools/setup_macos.sh`
3. `tools/start_services.sh`

Setup:
- Leverages [protobuf](https://github.com/protocolbuffers/protobuf) to generate protobufs and services.
  - Uses the protobuf compiler [protoc](https://grpc.io/docs/protoc-installation/) to generate a majority of protobufs.
  - Python servcies are generated using [grpcio-tools](https://pypi.org/project/grpc-tools/).
- Uses [grpc-web](https://github.com/grpc/grpc-web) to generate TypeScript protobufs and services.
  - Opted for this over a combined approach of [ts-proto](https://github.com/stephenh/ts-proto) with a grpc-web using other RPC framework to implement the clients.
  - TypeScript protos are created and used as a seperate TypeScript package.
- NGINX as a gRPC web proxy to translates between HTTP/1.1 (used by the browser) and HTTP/2 (used by gRPC). 
- Lerna for managing interdependent packages -- `app` is reliant on the protos generated in `ts-protos`.