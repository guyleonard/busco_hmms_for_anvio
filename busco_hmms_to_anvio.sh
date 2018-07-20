#!/bin/bash

# Reset in case getopts has been used previously in the shell.
OPTIND=1

# initialise
input_url=""
input_file=""

main () {
    # Set filename to input from getopts
    filename=$1
    # Untar the file
    untar $filename

    # Split filename on underscore, use first part as library name
    dir_name=(${filename//\_/ })
    dir_name+="_anvio"

    ## Make directory for this set of HMMs
    mkdir $dir_name

    ## Concatenate HMMs to genes.hmm
    cat $(basename ${filename%%.*})/hmms/*.hmm > $dir_name/genes.hmm

    # Gzip genes.hmm.gz
    gzip $dir_name/genes.hmm

    ## Make genes.txt list
    echo "gene      accession       hmmsource" > $dir_name/genes.txt
    for f in $(basename ${filename%%.*})/hmms/*.hmm; do gene=$(basename ${f%.*}); echo "$gene	$gene	Busco.ezlab" >> $dir_name/genes.txt; done

    ## Make kind.txt
    echo "singlecopy:eukarya" > $dir_name/kind.txt

    ## Make reference.txt
    echo "https://busco.ezlab.org/ & http://github.com/guyleonard" > $dir_name/reference.txt

    ## Make target.txt
    echo "AA:GENE" > $dir_name/target.txt

    ## Make noise_cutoff_terms.txt
    echo "-E 1e-25" > $dir_name/noise_cutoff_terms.txt

    ## Tidy up
    rm -r $(basename ${filename%%.*})
	    rm $filename
}

get_tarball () {
    ## Get source HMMs
    echo "Retrieving $1"
    if [-f $1]; then
      rm $1
    else
      wget $1
    fi
}

untar () {
    # Untar/zip
    echo "Untaring $1"
    tar zxf $1
}

show_help () {
    echo "$0 [-u url to tarball] |  [-f location of local file]"
}

while getopts "h?u:f:" opt; do
    case "$opt" in
    h|\?) show_help
          exit 0
          ;;
    u)  input_url=$OPTARG
	get_tarball $input_url
	input_file=${input_url##*/}
        main $input_file
        ;;
    f)  input_file=$OPTARG
	main $input_file
        ;;
    esac
done
