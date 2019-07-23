library(gmodels)
library(ggplot2)

### LOAD DATA
# root = '/p200/liujiang_group/yinyao/Dataset/scRNA/Output/SRR604939'
root = 'D:/Codes/DataLists/Output/SRR604939'
filenums = c(1, 4)
d = do.call('merge', 
            c(by = 'row.names', 
              all = FALSE, 
              lapply(filenums, function(filenum) {
                  tmp = read.table(
                      paste(root, filenum, '.dge.txt', sep = ''), 
                      header = T, row.names = 1)
                  colnames(tmp) = paste(filenum, 1:ncol(tmp), sep = '.')
                  tmp = tmp[, colSums(tmp) > 700 & colSums(tmp != 0) > 450]
                  tmp
                  })))
rownames(d) = d$Row.names
d = d[,colnames(d) != 'Row.names']
d = log(sweep(d, 2, colSums(d), '/') * median(colSums(d)) + 1)

### PCA
pca = fast.prcomp(t(d), center = FALSE)
pca.data = data.frame(pca$x[, 1:50])
graph = ggplot(pca.data, aes(x = PC1, y = PC2)) + geom_point()
plot(graph)

