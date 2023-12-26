import grpc
from protos.helloworld.helloworld_pb2 import HelloRequest
from protos.helloworld.helloworld_service_pb2_grpc import GreeterStub

def run():
    # Assuming the server is running on localhost and port 8000
    channel = grpc.insecure_channel('localhost:8000')
    stub = GreeterStub(channel)

    # Create a HelloRequest object
    request = HelloRequest(name='Test')
    
    # Send the request to the server and get the response
    response = stub.SayHello(request)
    print("Greeter client received: " + response.message)

if __name__ == '__main__':
    run()
