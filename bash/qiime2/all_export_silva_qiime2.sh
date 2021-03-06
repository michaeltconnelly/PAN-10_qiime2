#!/bin/bash
#purpose: Export rooted tree, classfied representative sequences and feature table of ASVs classified against SILVA database
#conda activate qiime2-2019.10

prodir="/Users/mikeconnelly/computing/projects/PAN-10_qiime2"
echo "Export process started for SILVA"

### Export rooted phylogenetic tree and taxonomic classification to .txt files
qiime tools export \
--input-path ${prodir}/outputs/qiime2/qza/all_silva_rooted-tree.qza \
--output-path ${prodir}/outputs/qiime2/export_silva

qiime tools export \
--input-path ${prodir}/outputs/qiime2/qza/all_classification_silva.qza \
--output-path ${prodir}/outputs/qiime2/export_silva

qiime tools export \
--input-path ${prodir}/outputs/qiime2/qza/all_silva_aligned-rep-seqs-no-mtcp.qza \
--output-path ${prodir}/outputs/qiime2/export_silva

### Export filtered feature table to BIOMv2 format file
qiime tools export \
--input-path ${prodir}/outputs/qiime2/qza/all_silva_table-no-mtcp.qza \
--output-path ${prodir}/outputs/qiime2/export_silva
### Convert BIOMv2 format feature table
biom convert \
-i ${prodir}/outputs/qiime2/export_silva/feature-table.biom \
--to-tsv \
-o ${prodir}/outputs/qiime2/export_silva/all_silva_feature-table.tsv

### Export rareified filtered feature table to BIOMv2 format file
qiime tools export \
--input-path ${prodir}/outputs/qiime2/core-metrics-results_silva/rarefied_table.qza \
--output-path ${prodir}/outputs/qiime2/export_silva_rare
### Convert BIOMv2 format feature table
biom convert \
-i ${prodir}/outputs/qiime2/export_silva_rare/feature-table.biom \
--to-tsv \
-o ${prodir}/outputs/qiime2/export_silva/all_silva_rarefied_feature-table.tsv

### Modify formatting of .tsv taxonomy tables
awk -F "\t" '{print $1"\t"$2}' ${prodir}/outputs/qiime2/export_silva/taxonomy.tsv > ${prodir}/outputs/qiime2/export_silva/taxonomy2.tsv
#need to insert literal tab
#sed 's/;/(ctrl + v + tab)/g' ${prodir}/outputs/qiime2/export_silva/taxonomy2.tsv > ${prodir}/outputs/qiime2/export_silva/taxonomy3.tsv
#grep -v "Feature" ${prodir}/outputs/qiime2/export_silva/taxonomy3.tsv > ${prodir}/outputs/qiime2/export_silva/taxonomy4.tsv
#need to open taxonomy4.tsv in Excel and save as tab-deliminted text

### Modify formatting of .tsv feature tables (rareified and unrareified)
sed 's/#OTU ID/ASVID/g' ${prodir}/outputs/qiime2/export_silva/all_silva_feature-table.tsv > ${prodir}/outputs/qiime2/export_silva/feature-table2.tsv
grep -v "Constructed" ${prodir}/outputs/qiime2/export_silva/feature-table2.tsv > ${prodir}/outputs/qiime2/export_silva/feature-table3.tsv
rm ${prodir}/outputs/qiime2/export_silva/all_silva_feature-table.tsv
rm ${prodir}/outputs/qiime2/export_silva/feature-table2.tsv
mv ${prodir}/outputs/qiime2/export_silva/feature-table3.tsv ${prodir}/outputs/qiime2/export_silva/all_silva_feature-table.tsv

sed 's/#OTU ID/ASVID/g' ${prodir}/outputs/qiime2/export_silva/all_silva_rarefied_feature-table.tsv > ${prodir}/outputs/qiime2/export_silva/all_rarefied_feature-table2.tsv
grep -v "Constructed" ${prodir}/outputs/qiime2/export_silva/all_rarefied_feature-table2.tsv > ${prodir}/outputs/qiime2/export_silva/all_rarefied_feature-table3.tsv
rm ${prodir}/outputs/qiime2/export_silva/all_silva_rarefied_feature-table.tsv
rm ${prodir}/outputs/qiime2/export_silva/all_rarefied_feature-table2.tsv
mv ${prodir}/outputs/qiime2/export_silva/all_rarefied_feature-table3.tsv ${prodir}/outputs/qiime2/export_silva/all_silva_rarefied_feature-table.tsv
