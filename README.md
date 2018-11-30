# Detect_Parallel_Epistasis

This code accompanies *Fisher, Kryazhimskiy & Lang, 2019, Philisophical Transactions B.* and was written to detect pairs of genes mutated in the same background more often than expected by chance in experimental evolution datasets.

# Usage 

## Formatting genotype data

Data should be provided in the form of a tab seperated (tsv) file. Each column should contain the names of genes mutated in an individual clone/isolate. An example raw dataset is provided. 
  - No column should contain duplicate gene names, two or more mutations to one gene are treated the same as one.
  - Clones/isolates that are related (derived from the same population) should not be included. Choose just one genotype from those populations. 
  - To reduce noise
    - Mutation datasets should first be filtered for medium to high impact coding sequence mutations (remove synonymous and intergenic mutations).
    - Genes present in the dataset only once (ideally a higher threshold should be imposed) should be removed. 
 
## Running the analysis 

### Dependencies 
R and the following R packages: 
- plyr
- pracma

1) Clone the repository. 

`Git clone https://github.com/LangYeastEvoLab/Detect_Parallel_Epistasis.git` 

2) From the Detect_Parallel_Epistasis directory run Parallel_GI.R as an R script using R --vanilla with raw data and number of simulations as arguments.

Example - using example data provided and 1000 simulations: 

`Rscript --vanilla Parallel_GI.R ~/example_genotype_data.tsv 1000`


## Files generated 

1) *Pairwise_Mutual_Information.tsv* file containing a table with all unique gene pairs, observed mutual information for each pair, and N columns containing simulated mutual information for N simulations. The sum of the observed MI column is the observed I<sub>tot</sub> value. 
2)*Simulated_Total_I_vector.tsv"* file containing a vector of N I<sub>tot</sub> from N simulations. 
3)*MI_distribution.pdf* histogram of the null distribution of N I<sub>tot</sub> values with the observed I<sub>tot</sub> plotted as a red line. 
