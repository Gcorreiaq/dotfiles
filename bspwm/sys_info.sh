#!/bin/bash

sys2=$(top -b -n 1 | grep %Cpu | sed 's/[^0-9 .]//g' | awk '{print $4}')
python -c "print(round(100-$sys2,2))"
