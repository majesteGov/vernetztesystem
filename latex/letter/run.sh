#!/bin/bash
thefile="$1"
[ "$thefile" = "" ] && { thefile=first.tex; }
cd data
latexmk --interaction=nonstopmode "$thefile"
