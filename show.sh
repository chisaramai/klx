#!bin/bash
make clean
make
./klx < due.klx > due.ps
ghostscript due.ps
