# Compute adjacencies and topological overlap for one line

# example execution:
# OMP_NUM_THREADS=23 MKL_NUM_THREADS=23 OPENBLAS_NUM_THREADS=23 Rscript TOMs_powers1line.R --line a554 --tiss leaf --pow 13

# load required packages

###### allow read options from command-line ########
library(optparse)

option_list <- list(
  make_option(c("-l", "--line"), type="character", default=NULL, help="Linia wsobna"),
  make_option(c("-t", "--tissue"), type="character", default=NULL, help="Tkanka"),
  make_option(c("-p", "--power"), type="integer", default=NULL, help="Potęga")
)

opt <- parse_args(OptionParser(option_list=option_list))

####################################################


library(WGCNA)

# The following setting is important, do not omit.
options(stringsAsFactors = FALSE)
# Allow multi-threading within WGCNA.
# Caution: skip this line if you run RStudio or other third-party R environments.
# See note above.
nThreads <- enableWGCNAThreads()
message("WGCNA threads:", nThreads)
# opcjonalnie wymuś liczby wątków BLAS/OpenMP:
if (requireNamespace("RhpcBLASctl", quietly = TRUE)) {
  RhpcBLASctl::blas_set_num_threads(23)
  RhpcBLASctl::omp_set_num_threads(23)
}
message("OMP_NUM_THREADS=", Sys.getenv("OMP_NUM_THREADS"))

# calculate adjacencies for selected powers

# clean environment and load data
  
  in_file = paste0("../rdata-saved/", opt$tissue, "-", opt$line, "-before-adj.RDa")
  
  load(in_file)
  
  # out file name
  out_file_name = paste0('../rdata-saved/power', opt$power, opt$tissue, "-", opt$line, '.RDa')
  
  # Network construction starts by calculating the adjacencies in the individual sets, using the choosen soft thresholding power:
  
  # Calculate adjacencies
  adj = adjacency(datExpr, 
                    type = 'signed hybrid', 
                    power = opt$power, 
                    corFnc = 'bicor',
                    corOptions = list(maxPOutliers = 0.05))

  # We now turn the adjacencies into Topological Overlap Matrix (TOM) 
  # [@doi:10.1126/science.1073374, @zhangGeneralFrameworkWeighted2005]
  # Calculation of topological overlap
  
  # Calculate TOMs
  TOM = TOMsimilarity(adj)
  
  save(TOM, adj, file = out_file_name)
  
  gc()
