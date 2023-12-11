#!/bin/bash

start_services() {
    (cd backend && python helloworld.py) &
    BACKEND_PID=$!

    (cd frontend && yarn start) &
    FRONTEND_PID=$!

    nginx &
    NGINX_PID=$!
}

stop_services() {
    kill $BACKEND_PID

    kill $FRONTEND_PID

    nginx -s stop
}

trap stop_services SIGINT

start_services

wait