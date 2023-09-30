#!/bin/bash

sudo ip link set wlp0s20f3 up

sudo iwlist wlp0s20f3 scan | grep ESSID
