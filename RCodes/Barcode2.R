setwd('D:/Codes/DataLists/')

data = read.table('barcode01.out', sep = '\t', stringsAsFactors = FALSE)

data = data[rev(order(data$V4)),]
data$V2 = sapply(data$V2, function(x){strsplit(x, '[.]')[[1]][1]})
acc = read.table('D:/Codes/ClassCodes/SequencingHomework/analysis/2.txt', stringsAsFactors = FALSE)
org = read.table('D:/Codes/ClassCodes/SequencingHomework/analysis/orgs.txt', sep = '\t', stringsAsFactors = FALSE)
new = cbind(acc, org)
colnames(new) = c('V2', 'org')
newdata = merge(new, data, by = 'V2', no.dups = TRUE)

maxscore = data.frame()
for (a in unique(acc$V1)){
  line = newdata[newdata$V2 == a,]
  line = line[line$V12 == max(line$V12),]
  maxscore = rbind(maxscore, line)
} 
maxscore = maxscore[rev(order(maxscore$V12)),]

qmaxscore = maxscore[maxscore$V12 > 100,]
library(dplyr)
summ = arrange(summarize(group_by(qmaxscore, org), n = n()), n)
summ

