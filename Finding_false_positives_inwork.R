
#Based on having 10,000 simulations. 
##Input needs to be DF as such: 
# gene.pair     simI1     simI2     simI3  ...obsI
# genepair1     I         I         I         I 
# ...           ...       ...       ...       ... 

## The very last row for sum of significant pairs will be the Qobs value. 

Find_False_Positives<- function(I.Val.DF){
  
  #create empty vectors for critical values 
  p.0001_critical_I<-numeric(nrow(I.Val.DF))
  p.0005_critical_I<-numeric(nrow(I.Val.DF))
  p.001_critical_I<-numeric(nrow(I.Val.DF))
  p.005_critical_I<-numeric(nrow(I.Val.DF))
  p.01_critical_I<-numeric(nrow(I.Val.DF))
  p.05_critical_I<-numeric(nrow(I.Val.DF))
  
 # for each row in the simulated data (each gene pair) sort the row (minus the final column, which is the observed)
 # and deterimine the critical value based on the rank 
 
  for (h in 1:nrow(I.Val.DF)){ 
    I.val.vector<- as.numeric(as.vector(I.Val.DF[h, 2:(ncol(I.Val.DF)-1)]))
    I.val.vector<-sort(I.val.vector, decreasing=TRUE)
    I.val.vector[1]-> p.0001_critical_I[h]
    I.val.vector[5]-> p.0005_critical_I[h]
    I.val.vector[10]-> p.001_critical_I[h]
    I.val.vector[50]-> p.005_critical_I[h]
    I.val.vector[100]-> p.01_critical_I[h]
    I.val.vector[500]-> p.05_critical_I[h]
  }  
 #make dataframe of critical values
 Crit.Vals.DF<- cbind(I.Val.DF[1], p.0001_critical_I, p.0005_critical_I, p.001_critical_I, p.005_critical_I, p.01_critical_I, p.05_critical_I)
  
 
 #make empty vectors for the number of false postives. length of vector is number of simulations
  FP_.0001<-numeric(ncol(I.Val.DF)-1)
  FP_.0005<-numeric(ncol(I.Val.DF)-1)
  FP_.001<-numeric(ncol(I.Val.DF)-1)
  FP_.005<-numeric(ncol(I.Val.DF)-1)
  FP_.01<-numeric(ncol(I.Val.DF)-1)
  FP_.05<-numeric(ncol(I.Val.DF)-1)
  SimSet<- seq(1:(ncol(I.Val.DF)-1)) #final value in simset will be observed value 
  FP.DF<- cbind(SimSet, FP_.0001, FP_.0005, FP_.001, FP_.005, FP_.01, FP_.05)
  
  
  
  for (n in 2:ncol(Crit.Vals.DF)){ # for each p.value vector 
    Crit.Vals<- Crit.Vals.DF[, n] # convert df vector to list
    for (o in 2:ncol(I.Val.DF)){ # for each simulation 
      FP<-0                     #start FP at 0
      I.Vals<- I.Val.DF[, o]    # convert simulation I val column into list 
      for (p in 1:nrow(I.Val.DF)){    # for each  I statistic in a simulation 
        if (I.Vals[[p]]>= Crit.Vals[[p]]){  # if the I statistic is GTOET the critical value add one to FP 
          FP<-FP+1
        }
      }
      FP.DF[(o-1), n]<- FP  # assign the row of the simulation and the column of the p value the number of FP 
    }
  }
  
  return(FP.DF)
}