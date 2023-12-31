# Learning gRPC

Mini-project to learn setting up and maintaining a fullstack gRPC web app.

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
- Implemented client and server side logging to a file for the backend and browser console for frontend.
- Good learning was on the difficulty of not using Docker when setting up these multiple services. Not using Docker made it much easier to run into bugs.
  - For instance, it was easy to accidentally open up to many processes, run into hard to detect bugs, and manually have to kill the processes with `pkill -f nginx` or `pkill -f helloworld.py`.
- Most difficult part was configuring NGINX with gRPC web as it was difficult to find good documentation on this crossover. Two good resources of configurations were these two setups: [1](https://gist.github.com/fedej/07d29e86bc29061be1f5bb993adab6ff) and [2](https://github.com/emart-io/cross/blob/main/pwa/nginx.conf).
- Opted to not implement Buf for linting as that feels more of a CI/CD not Infra project but may implement this in the future. 