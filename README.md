Check out [Assessing the completion of eukaryotic bins with anvi'o](http://merenlab.org/2018/05/05/eukaryotic-single-copy-core-genes/) on why you may want to do this...

# Making BUSCO HMMs useable in Anvi'o
Clone the repo or download the script directly.

Then, simply run the bash script with a URL for one of the BUSCO datasets, e.g.

```bash
bash ./busco_hmms_to_anvio.sh -u https://busco.ezlab.org/datasets/eukaryota_odb9.tar.gz
```
or, if you have already downloaded the dataset, run it like this:
```bash
bash ./busco_hmms_to_anvio.sh -f fungi_odb9.tar.gz
```
The output can then be found in the local directory as "dbname_anvio", e.g. 'eukaryota_anvio".

## NB
Currently, you will have to edit:
* "kind.txt" and change it to bacteria, if you have downloaded the bacterial dataset
* "noise_cutoff_terms.txt" if you want a value other than '1e-25"
