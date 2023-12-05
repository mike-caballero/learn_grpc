from concurrent.futures import ThreadPoolExecutor

import grpc
from protos.helloworld.helloworld_pb2 import HelloRequest, HelloReply
from protos.helloworld.helloworld_service_pb2_grpc import GreeterServicer, add_GreeterServicer_to_server


class Greeter(GreeterServicer):
    def SayHello(self, request, context):
        return HelloReply(message="Hello World!")


def serve():
    server = grpc.server(ThreadPoolExecutor(max_workers=10))
    add_GreeterServicer_to_server(Greeter(), server)
    server.add_insecure_port("[::]:8000")
    server.start()
    server.wait_for_termination()


if __name__ == "__main__":
    serve()