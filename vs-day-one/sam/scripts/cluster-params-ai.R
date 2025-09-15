3.1 Choose c (cluster count)

Elbow method on within‑cluster sum of squares (WCSS)

wcss <- sapply(15:40, function(k){
  cl <- mfuzz(vsd.eset.ave.std, c=k, m=1.9)   # temporary m
  sum(cl$withinerror)
})
plot(15:40, wcss, type='b', xlab='Number of clusters (c)', ylab='WCSS')

Look for the point where the curve flattens.


3.2 Choose m (fuzziness)

Typical values: 1.25 – 2.0. Larger m yields softer memberships (more overlap).

Test a few values and inspect the membership distribution:
  
  m_vals <- seq(1.25, 2.0, by=0.05)
for (m_i in m_vals) {
  cl <- mfuzz(vsd.eset.ave.std, c=22, m=m_i)
  hist(apply(cl$membership, 1, max), main=paste("m =", m_i),
       xlab="Maximum membership per gene")
}

Pick an m where most genes have a clear dominant cluster (peak near 1) but you still retain biologically plausible overlap.