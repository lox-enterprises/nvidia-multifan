#!/bin/env bash

# command
setfan() {
  nvidia-settings -a [gpu:0]/GPUFanControlState=1 -a [fan:0]/GPUTargetFanSpeed=$1 -a [fan:1]/GPUTargetFanSpeed=$2 -c 0
}

while true; do
    gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)

    # temperature categories, setfan: first value is first fan, second value second fan
    if ((0<=gpu_temp && gpu_temp<=50))
        then
        # fan stop
        nvidia-settings -a [gpu:0]/GPUFanControlState=0 -c 0
    elif ((51<=gpu_temp && gpu_temp<=60))
        then
        setfan 30 30
    elif ((61<=gpu_temp && gpu_temp<=100))
        then
        setfan 35 42
    fi

    # loop every 10 seconds
    sleep 10
done
