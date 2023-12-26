#!/bin/bash

start_services() {
    (python backend/helloworld.py) &
    BACKEND_PID=$!

    nginx -c $PWD/nginx.conf -p $PWD

    (cd frontend/packages/app && yarn start) &
    FRONTEND_PID=$!
}

stop_services() {
    kill $BACKEND_PID

    kill $FRONTEND_PID

    kill -TERM `cat $PWD/runtime/nginx.pid`
}

trap stop_services SIGINT

start_services

wait