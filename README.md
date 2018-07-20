# Make BUSCO HMMs useable in Anvi'o

Simply run the bash script with a URL for one of the BUSCO datasets, e.g.

```bash
./busco_hmms_to_anvio.sh -u https://busco.ezlab.org/datasets/eukaryota_odb9.tar.gz
```
or, if you have already downloaded the dataset, run it like this:
```bash
./busco_hmms_to_anvio.sh -f fungi_odb9.tar.gz
```

Output can be found in the local directory as "DB_name_anvio".

Currently, you will have to edit:
* "kind.txt" and change it to bacteria, if you have downloaded the bacterial dataset
* "noise_cutoff_terms.txt" if you want a value other than '1e-25"
