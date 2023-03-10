#!/bin/bash
workdir=/tmp/latex-work-$$
rm -rf $workdir
mkdir $workdir
cp data/* $workdir
cd $workdir
cat headsimple.tex >long.tex
for i in {1..100}; do
	cat onepagesimple.tex >> long.tex
done
cat footsimple.tex >> long.tex
latexmk -pdf --interaction=nonstopmode long.tex > mylatex.log
pdfseparate long.pdf out%03d.pdf

