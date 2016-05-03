#!bin/bash
make
./klx < due.klx > due.ps
ghostscript due.ps
