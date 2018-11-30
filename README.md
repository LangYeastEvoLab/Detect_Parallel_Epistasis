# Detect_Parallel_Epistasis

This code accompanies *Fisher, Kryazhimskiy & Lang, 2019, Philisophical Transactions B.* and was written to detect pairs of genes mutated in the same background more often than expected by chance in experimental evolution datasets.
---

# Usage 

## Data formatting

Data should be provided in the form of a tab seperated (tsv) file. Each column should contain the genes categories mutated in an individual clone/isolate. An example raw dataset is provided. 
  - No column should contain duplicate gene names, two or more mutations to one gene are treated the same as one.
  - Clones/isolates that are related (derived from the same population) should not be included. Choose just one genotype from those populations. 
  - To reduce noise
    - Mutation datasets should first be filtered for medium to high impact coding sequence mutations (remove synonymous and intergenic mutations).
    - Genes present in the dataset only once (ideally a higher threshold should be imposed) should be removed. 
 



For detecting overrepresented genes, run the Recurrence Script.R with the supplied GFF annotation file or another annotation file in the same format. 

To find overrepresented gene pairs via Mutual Information, source all R scripts except "Recurrence Script.R". Run Run_sampling_for_Mutual_Information.R with inputs: raw data, the output of Construct_Pairs(raw data), and the number of replicate simulations desired. 
