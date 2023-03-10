#!/bin/bash
ncat -l -v -k -C -e interpreter.sh 1234

kill $PID


