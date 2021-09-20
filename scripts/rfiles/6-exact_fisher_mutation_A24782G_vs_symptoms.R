################################################### 6- Exact Fisher tests - Mutation A24782G vs symptoms ###################################################

# 9 genomes have an A24782G mutation (N1074D a.a. substitution) --> uniquely present in haplogroup IIa genomes
# 7 genomes have a G21641T mutation (A27S a.a. substitution) --> found in genomes with haplogroup IIb classification 5 times and twice in haplogroup III
# Since we observed significant enrichment for gastro-intestinal symptoms in haplogroup IIb and headaches in haplogroup IIa, we investigated if there was any significant association between these mutations and clinical features

# In this script (6-), we study the mutation A24782G. In the next script (7-), we will study the mutation G21641T.

# Set working directory:
current_path = ".../scripts/rfiles/" # TO ADAPT!!!
setwd(current_path) 

# Data loading:
data <- read.csv2("../../data/clinical_data.csv", header=TRUE, sep=",", na.strings=c(""))
df <- data.frame(data)

# Remove lines where variant == NA:
df <- df[!is.na(df$Haplotype.group.simplified), ] 

# Subgroups data loading:
subgroups <- read.csv2("../../data/phate_haplotype_clusters.csv", header=TRUE, sep=",", na.strings=c(""))
df_subgroups <- data.frame(subgroups)

# Join df and df_subgroups according to Sample ID column (merge makes a inner join by default):
joined_df <- merge(df, df_subgroups, by.x="Sample.ID", by.y="Sample_ID", sort = TRUE)

# Check presence of another symptom. Make the distinction between sore throat and the other symptoms:
check_other_symptom <- as.character(rep(c(0), length(joined_df$Other.symptom)))
sore_throat <- as.character(rep(c(0), length(joined_df$Other.symptom)))
for (i in 1:length(joined_df$Other.symptom)){
  if (is.na(joined_df$Other.symptom[i])){
    check_other_symptom[i] = NA
    sore_throat[i] = NA
  } else if (joined_df$Other.symptom[i] == "No"){
    check_other_symptom[i] = "No"
    sore_throat[i] = "No"
  } else{
    check_other_symptom[i] = "Yes"
    if (grepl(joined_df$Other.symptom[i], "mal_de_gorge")){
      check_other_symptom[i] = "No"
      sore_throat[i] = "Yes"
    } else{
      check_other_symptom[i] = "Yes"
      sore_throat[i] = "No"
    }
  }
}

# Add column "sore_throat" and "check_other_symptom" to joined_df:
joined_df <- cbind(joined_df, sore_throat, check_other_symptom)

# Variables to test:
variables_to_test <- c("Fever", "Cough", "Fatigue", "Headache", "Myalgia", "Nausea_vomiting_diarrhea", "Dyspnea", "Confusion", "sore_throat", "check_other_symptom", "Co-morbidity", "Deceased")
# Column indexes of variables to test:
col_idx <- c(22:29) # Add columns "Fever" to "Confusion"
col_idx <- c(col_idx, 41, 42, 37, 39)  # Add columns "sore_throat", "check_other_symptom", "Co-morbidity" and "Deceased" 

j = 1 # Index used to find test name

#### Add column mutation_A24782G to joined_df:
# List of the samples with mutation A24782G:
list_samples_A24782G <- c("AD7", "AE6", "AR1", "AR8", "AR9", "AT7", "AT8", "BA1", "BA2")
# Create column vectors:
mutation_A24782G <- as.character(rep(c(0), length(joined_df$Sample.ID)))
for (i in 1:length(joined_df$Sample.ID)){
  if (joined_df$Sample.ID[i] %in% list_samples_A24782G) {
    mutation_A24782G[i] = "Yes"
  }
}
# Add column "mutation_A24782G" to joined_df:
joined_df <- cbind(joined_df, mutation_A24782G)

#### Exact Fisher tests - mutation A24782G vs symptoms:

# Save the results of the statistical tests in a file.txt:
cat("Results exact Fisher tests - mutation A24782G vs symptoms", file = "6-results_exact_fisher_mutation_A24782G.txt")
# add 2 newlines
cat("\n\n", file = "6-results_exact_fisher_mutation_A24782G.txt", append = TRUE)

# For each variable to test:
for (i in col_idx){
  # Create test name:
  test_name <- paste("Check independence Presence of the mutation A24782G /", variables_to_test[j], sep="") 
  # Delete rows where current variable to test == NA:
  reduced_joined_df <- joined_df[!is.na(joined_df[i]), ]
  # Create the contingency table:
  CT <- table(as.factor(reduced_joined_df$mutation_A24782G), as.factor(reduced_joined_df[,i]))
  # Exact Fisher test:
  test <- fisher.test(CT) 
  # Export test outputs:
  cat(test_name, "\n", file = "6-results_exact_fisher_mutation_A24782G.txt", append = TRUE)
  capture.output(CT, file = "6-results_exact_fisher_mutation_A24782G.txt", append = TRUE)
  capture.output(test, file = "6-results_exact_fisher_mutation_A24782G.txt", append = TRUE)
  # Add 2 newlines:
  cat("\n --------------------------------------------------------------------------------- \n", file = "6-results_exact_fisher_mutation_A24782G.txt", append = TRUE)
  # Increment index to find test name
  j = j + 1
}

# End of "6-results_exact_fisher_mutation_A24782G.txt" :
cat("END", file = "6-results_exact_fisher_mutation_A24782G.txt", append = TRUE)

