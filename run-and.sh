#!/bin/bash

# Flutter run + scrcpy di 2 device Android

DEVICE1="c3f5cf2e"
DEVICE2="R9RY404BV2X"

scrcpy -s $DEVICE1 --window-title="Device 1" &
scrcpy -s $DEVICE2 --window-title="Device 2" &

wait