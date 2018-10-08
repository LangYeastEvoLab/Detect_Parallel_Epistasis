# Detect_Parallel_Epistasis

These scripts accompany Fisher, Kryazhimskiy & Lang (2018). 

These scripts are intended to analyze datasets of mutated genes in experimental evolution studies. Raw datasets should be formatted as tables wherein column names are clone/sample names and rows contain mutated gene names. Missing data must be supplied as NA values to make all genotype vectors equal length. 

For detecting overrepresented genes, run the Recurrence Script.R with the supplied GFF annotation file or another annotation file in the same format. 

To find overrepresented gene pairs via Mutual Information, source all R scripts except "Recurrence Script.R". Run ** with inputs: raw data, the output of Construct_Pairs(raw data), and the number of replicate simulations desired. 
