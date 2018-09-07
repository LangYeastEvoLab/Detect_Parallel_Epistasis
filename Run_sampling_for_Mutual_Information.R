#Runs sampling for mutual information as the output of each sampling iteration 

#requires Probability_Sample()
  # requires Build_Probability_Matrix.R

Run_Sampling_for_MI<-function(Genes_by_clone_dataframe, Observed_data, replicates){ 
  
    Observed_data->All.pairs
  for (i in 1:replicates){
    permutedpairscount<-Probability_Sample(Genes_by_clone_dataframe)
    permutedpairscount<- permutedpairscount[permutedpairscount$sigma1.sigma2!=0, ]
    P1.1<- permutedpairscount[, 5]
    P0.1<- permutedpairscount[, 6]
    P1.0<- permutedpairscount[, 7]
    P0.0<- permutedpairscount[, 8]
    Psig1<- permutedpairscount[, 9]
    Psig2<- permutedpairscount[, 10]
    I1.1<- P1.1 * log2(P1.1/(Psig1*Psig2))
    I0.1<- P0.1 * log2(P0.1/((1-Psig1)*Psig2))
    I1.0<- P1.0 * log2(P1.0/(Psig1 *(1-Psig2)))
    I0.0<- P0.0 * log2(P0.0/((1-Psig1)*(1-Psig2)))
    I.df<- data.frame(permutedpairscount[1], I1.1, I0.1, I1.0, I0.0)
    I.df$I<- (rowSums(I.df[2:5]))
    I.df<-I.df[c(1, 6)]
    colnames(I.df)[2]<-(sprintf("I_sample_%d", i))
    All.pairs<-merge(All.pairs, I.df, by="sigma1.sigma2", all=TRUE)
  }
  return(All.pairs)
}