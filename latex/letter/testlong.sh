#!/bin/bash
workdir=/tmp/latex-work-$$
rm -rf $workdir
mkdir $workdir
cp data/* $workdir
cd $workdir
name=${thefile%.tex}
cat head.tex >long.tex
for i in {1..100}; do
	cat onepage.tex >> long.tex
done
cat foot.tex >> long.tex
latexmk -lualatex --interaction=nonstopmode long.tex > mylatex.log
pdfseparate long.pdf out%03d.pdf

