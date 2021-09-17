# Description of data files

File | Description
------------ | -------------
MN908947.ref.fasta.gz | SARS-CoV-2 reference genome (Wuhan-1)
all_medaka_variants_gt20_trim.vcf.gz | List of all filtered variants (supported by >20 reads)
hcov_global.fasta.gz | GISAID global data (downloaded 2021/09/16)
hcov_global.tsv | GISAID global metadata (downloaded 2021/09/16)
medaka.fa.gz | Medaka-generated consensus genomes (c.f. ARTIC bioinformatics pipeline)
medaka_fixed.fa.gz | Medaka-generated and corrected with less abundant variant frequencies (see ../scripts/fix_medaka_fastas.sh) 
medaka_fixed_gt80pc.fa.gz | Medaka subset used for phylogenetic inference and lineage assignment
nanopolish.fa.gz | Nanopore-generated consensus genomes (c.f. ARTIC bioinformatics pipeline)
negCtrls.fa.gz | Medaka-generated consensus genomes for negative controls (largely NNNNs)
pangolin.tgz.gz | Pangolineages for the above-mentioned fastas
phate_processed.tar | One-hot encoded clinical and variants data used to compute PHATE embeddings
verdun_genomes.tsv | Metadata used to add to auspice webviewer to highlight verdun genomes
verdun+globaldata.json.gz | Nextstrain phylogentic data comparing verdun genomes to a global of GISAID data (generates tree in auspice.us)
