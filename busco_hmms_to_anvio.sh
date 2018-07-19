#!/bin/env bash

## Get source HMMs
wget https://busco.ezlab.org/datasets/eukaryota_odb9.tar.gz
# Untar/zip 
tar zxvf eukaryota_odb9.tar.gz

## Make directory for this set of HMMs
mkdir euk_odb9 && cd euk_odb9

## Concatenate HMMs to genes.hmm
cat ../eukaryota_odb9/hmms/*.hmm >genes.hmm
# Gzip genes.hmm.gz
gzip genes.hmm

## Make genes.txt list
echo "gene      accession       hmmsource" > genes.txt
for f in ../eukaryota_odb9/hmms/*.hmm; do gene=$(basename ${f%.*}); echo "$gene   $gene   Busco.ezlab" >> genes.txt; done

## Make kind.txt
echo "singlecopy:eukarya" > kind.txt

## Make reference.txt
echo "https://busco.ezlab.org/ & http://github.com/guyleonard" > reference.txt

## Make target.txt
echo "AA:GENE" > target.txt

## Make noise_cutoff_terms.txt
echo "-E 1e-25" >noise_cutoff_terms.txt

## Tidy up
cd ../
rm -r eukaryota_odb9
rm eukaryota_odb9.tar.gz
