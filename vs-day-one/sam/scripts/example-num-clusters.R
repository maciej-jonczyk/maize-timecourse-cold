library(Mfuzz)
data(yeast)

# Data pre-processing
yeastF <- filter.NA(yeast)
yeastF <- fill.NA(yeastF)
yeastF <- standardise(yeastF)
#### parameter selection
yeastFR <- randomise(yeastF)
cl <- mfuzz(yeastFR,c=20,m=1.1)
mfuzz.plot(yeastFR,cl=cl,mfrow=c(4,5)) # shows cluster structures (non-uniform partition)
tmp <- partcoef(yeastFR) # This might take some time.
F <- tmp[[1]];F.n <- tmp[[2]];F.min <- tmp[[3]]
# Which clustering parameters result in a uniform partitio

F > 1.01 * F.min

cl <- mfuzz(yeastFR,c=20,m=1.25) # produces uniform partion
mfuzz.plot(yeastFR,cl=cl,mfrow=c(4,5))
# uniform coloring of temporal profiles indicates uniform partition

cl4 <- mfuzz(yeastFR,c=4,m=1.25) # produces uniform partion
mfuzz.plot(yeastFR,cl=cl4, mfrow=c(2,2))


cl8 <- mfuzz(yeastFR,c=8,m=1.25) # produces uniform partion
mfuzz.plot(yeastFR,cl=cl8, mfrow=c(4,2))
# uniform coloring of temporal profiles indicates uniform partition



## Non uniform partition (too low m value)

cl20nu <- mfuzz(yeastFR,c=20,m=1.15) # produces uniform partion
mfuzz.plot(yeastFR,cl=cl20nu,mfrow=c(4,5))


cl8nu <- mfuzz(yeastFR,c=8,m=1.15) # produces uniform partion
mfuzz.plot(yeastFR,cl=cl8nu,mfrow=c(4,2))


###################### Dmin ###########################
library(Mfuzz)
data(yeast)
# Data pre-processing
yeastF <- filter.NA(yeast)
yeastF <- fill.NA(yeastF)
yeastF <- standardise(yeastF)
#### parameter selection
# For fuzzifier m, we could use mestimate
m1 <- mestimate(yeastF)
m1 # 1.15
# or the function partcoef (see example there)
# For selection of c, either cselection (see example there)
# or
tmp <- Dmin(yeastF,m=m1,crange=seq(4,40,4),repeats=3,visu=TRUE)# Note: This calculation might take some time
# It seems that the decrease for c ~ 20 - 25 24 and thus 20 might be
# a suitable number of cluster