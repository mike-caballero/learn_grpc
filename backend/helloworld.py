from concurrent.futures import ThreadPoolExecutor
import logging

import grpc
from protos.helloworld.helloworld_pb2 import HelloRequest, HelloReply
from protos.helloworld.helloworld_pb2_grpc import Greeter as GreeterServicer


class Greeter(GreeterServicer):
    def SayHello(self, request, context):
        return HelloReply(message="Hello, %s!" % request.name)


def serve():
    port = "50051"
    server = grpc.server(ThreadPoolExecutor(max_workers=10))
    helloworld_pb2_grpc.add_GreeterServicer_to_server(Greeter(), server)
    server.add_insecure_port("[::]:" + port)
    server.start()
    print("Server started, listening on " + port)
    server.wait_for_termination()


if __name__ == "__main__":
    serve()