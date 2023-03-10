#!/bin/bash
thefile="$1"
workdir=/tmp/latex-work-$$
rm -rf $workdir
mkdir $workdir
cp data/* $workdir
cd $workdir
[ "$thefile" = "" ] && { thefile=simple.tex; }
sed -i 's/och /ooch /g' $thefile
name=${thefile%.tex}
pdflatex --interaction=nonstopmode "$thefile" > mylatex.log
cat $name.pdf

