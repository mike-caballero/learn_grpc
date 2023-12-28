import logging
import os
from concurrent.futures import ThreadPoolExecutor

import grpc
from protos.helloworld.helloworld_pb2 import HelloRequest, HelloReply
from protos.helloworld.helloworld_service_pb2_grpc import GreeterServicer, add_GreeterServicer_to_server

logging.basicConfig(level=logging.INFO, filename=f'{os.getcwd()}/runtime/backend_server.log', filemode='a',
                    format='%(asctime)s - %(levelname)s - %(message)s')

class Greeter(GreeterServicer):
    def SayHello(self, request, context):
        logging.info(f"Request: {request}; Context: {context.invocation_metadata()}")
        response = HelloReply(message="Hello World!")
        logging.info(f"Response: {response}")
        return response

def serve():
    server = grpc.server(ThreadPoolExecutor(max_workers=10))
    add_GreeterServicer_to_server(Greeter(), server)
    server.add_insecure_port("[::]:8000")
    server.start()
    logging.info("Server started and listening on port 8000")
    server.wait_for_termination()


if __name__ == "__main__":
    serve()