#! /usr/bin/env bash

nvidia-smi --query-gpu=utilization.gpu,memory.used --format=csv,noheader,nounits \
	| ts '%H:%M:%S' \
	| tee -a /log/gpu-monitor.log
