load(file="../rdata-saved/vsd.eset.ave.std.sam.RDa")

library(Mfuzz)

set.seed(1) # for reproducibility
cl <- mfuzz(vsd.eset.ave.std, c = 14, m = 1.3)

pdf("c14_m1.3_single.pdf")
mfuzz.plot2(vsd.eset.ave.std, cl = cl, mfrow = c(2,1), x11 = FALSE, centre=TRUE, centre.col="black", 
            centre.lwd=2, time.labels = colnames(vsd.eset.ave.std),  cex.axis = 0.6, las = 2)
dev.off()

source("mfuzz.plot2_separate_lines.R")

pdf("c14_m1.3_single.pdf")
mfuzz.plot2mod(vsd.eset.ave.std, cl = cl, mfrow = c(2,1), x11 = FALSE, centre=TRUE, centre.col="black", 
            centre.lwd=2, time.labels = colnames(vsd.eset.ave.std),  cex.axis = 0.6, las = 2)
dev.off()

pdf("c14_m1.3_single_minmem07.pdf")
mfuzz.plot2mod(vsd.eset.ave.std, cl = cl, min.mem = 0.7, mfrow = c(2,1), x11 = FALSE, centre=TRUE, centre.col="black", 
               centre.lwd=2, time.labels = colnames(vsd.eset.ave.std),  cex.axis = 0.6, las = 2)
dev.off()