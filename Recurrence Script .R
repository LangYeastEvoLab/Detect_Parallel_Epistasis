#KJF 3/20/18 
#script calculates the probability of any given gene or intergenic region being mutated 
#n times, controlling for gene size. W303_Position_File.txt is required
#Input data should be in the form of a data frame with 2 columns. Ex. 
#Feature  #n 
#ACE2     5
#CTS1     12
#...      ... 


#upon annotating intergenic mutations, ORF position file can be replaced with position file

Calculate_Recurrence_Probability <- function (Observed_Gene_Counts, W303_Position_File){
#first add an empty column to observed counts dataframe to hold lambda
Observed_Gene_Counts$Lambda<-NA 
#calculate genome size 
genome_size<-sum(na.omit(W303_Position_File[, 4]))
Nmutations<- sum(Observed_Gene_Counts$n)
for (i in 1:nrow(Observed_Gene_Counts)){ #iterate through rows of observed data
  for (j in 1:nrow(W303_Position_File)){ #iterate through rows of annotation file 
    if (Observed_Gene_Counts[i, 1] == W303_Position_File[j, 6]){ #find correct gene
       gene_size<- W303_Position_File[j, 4]
       Observed_Gene_Counts[i, 3]<- (gene_size/genome_size)*Nmutations
        break
    }
  }
}
Observed_Gene_Counts$"P{n}"<- ((((Observed_Gene_Counts$Lambda)^(Observed_Gene_Counts$n))/
  (factorial(Observed_Gene_Counts$n)))*exp(-(Observed_Gene_Counts$Lambda)))
Observed_Gene_Counts$"logP{n}"<- log10(Observed_Gene_Counts$`P{n}`)
Result.df<- Observed_Gene_Counts[order(Observed_Gene_Counts$"P{n}"), ]
Result.df$BF.adjusted<- p.adjust(Result.df$"P{n}", method="bonferroni")
Result.df$BH.adjusted<- p.adjust(Result.df$"P{n}", method= "BH")
return(Result.df)
}