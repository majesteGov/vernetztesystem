#!/bin/bash
thefile="$1"
workdir=/tmp/latex-work-$$
rm -rf $workdir
mkdir $workdir
cp data/* $workdir
cd $workdir
[ "$thefile" = "" ] && { thefile=first.tex; }
sed -i 's/och /ooch /g' $thefile
name=${thefile%.tex}
latexmk --interaction=nonstopmode "$thefile" > mylatex.log
cat $name.pdf

