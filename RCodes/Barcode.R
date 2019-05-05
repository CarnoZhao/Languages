setwd('D:/Codes/DataLists/')
d = read.table('barcode01.out', sep = '\t')
colnames(d) = c('qaccver', 'saccver', 'pident', 'length', 'mismatch', 'gapopen','qstart', 'qend', 'sstart', 'send', 'evalue', 'bitscore')


library(dplyr)

