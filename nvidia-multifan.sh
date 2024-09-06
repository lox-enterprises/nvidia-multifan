#!/bin/env bash

# command
setfan() {
  sudo /usr/bin/nvidia-settings -a "*:1[gpu:0]/GPUFanControlState=1" -a "*:1[fan-0]/GPUTargetFanSpeed=$1" -a "*:1[fan-1]/GPUTargetFanSpeed=$2"
}

while true; do
    gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)

    # temperature categories
    if ((0<=gpu_temp && gpu_temp<=50))
        then
        # set fan control back to GPU to allow for fan stop
        sudo /usr/bin/nvidia-settings -a "*:1[gpu:0]/GPUFanControlState=0"
    elif ((51<=gpu_temp && gpu_temp<=60))
        then
        # setfan [speed first fan] [speed second fan]
        setfan 30 30
    elif ((61<=gpu_temp && gpu_temp<=100))
        then
        setfan 35 42
    fi

    # loop every 10 seconds
    sleep 10
done
