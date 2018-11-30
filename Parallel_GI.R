#!/usr/bin/env Rscript

#run by calling Rscript --vanilla Parallel_GI.R raw_data.tsv desired_number_simulations(supplied as integer) out.tsv
#if no simulations are desired enter an argument of 0 for simulations

#raw input data should be tab seperated (tsv) file with clones as columns and gene names in rows in format below: 
#Ex. 
#   clone1name  clone2name  clone3name ...
#   genex       geney       genez
#   geney       genex       genex

#output will be written as a .tsv file. If no third argument is provided default output will be out.txt 

#required packages: 
#plyr
#pracma
######

#takes trailing arguments 
user_input=commandArgs(trailingOnly = TRUE)
 
if (length(user_input)< 2){
  stop("Raw data and number of desired replicates must be supplied as arguments", call=FALSE)
} else if (length(user_input)==2){
  #default output file 
  user_input[3]<- "out.tsv"
}
source("scripts/Construct_Pairs.R")
source("scripts/Probability_Sample.R")
source("scripts/Generate_Pairs_Dataframe.R")
source("scripts/Build_Probability_Matrix.R")
source("scripts/Run_sampling_for_Mutual_Information.R")

library("plyr")
library("pracma")

DF<- read.delim(user_input[1], header=TRUE, stringsAsFactors=FALSE)
Results<-  Run_Sampling_for_MI(DF, user_input[2])
write.table(Results, file=user_input[3], sep="\t")

