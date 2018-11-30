# Detect_Parallel_Epistasis

*This code accompanies Fisher, Kryazhimskiy & Lang, 2019, Philisophical Transactions B. and was written to detect pairs of genes mutated in the same background more often than expected by chance in experimental evolution datasets. Using the approach outlined in the accompanying paper, this script takes a dataset of evolved genotypes and returns a table of observed and simulated mutual information (MI)*





For detecting overrepresented genes, run the Recurrence Script.R with the supplied GFF annotation file or another annotation file in the same format. 

To find overrepresented gene pairs via Mutual Information, source all R scripts except "Recurrence Script.R". Run Run_sampling_for_Mutual_Information.R with inputs: raw data, the output of Construct_Pairs(raw data), and the number of replicate simulations desired. 
