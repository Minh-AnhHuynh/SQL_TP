# SQL in R
librarian::shelf(tidyverse, snakecase)

# Load data
polymorphisme <- read.delim("./02_data/polymorphisme.csv")

# Creat allele_uid
allele_filter <- polymorphisme %>%
  select(symbole_allele, nom_allele, site_uid) %>%
  distinct() %>%
  rowid_to_column(var = "allele_uid")

# Add allele_uid
polymorphisme <- left_join(allele_filter, polymorphisme)

# Get unique language_name primary key
langue <- c(polymorphisme$langue_primaire, polymorphisme$langue_secondaire)
langue <- as.data.frame(unique(langue))

# Remove empty values with dplyr syntax
nom_langue <- langue %>%
  na_if("") %>%
  na.omit()

# Base R
df <- df[!(df$start_pc == ""), ]

# Primary Key of nom_langue and pop_uid
pop_uid <-
  nom_langue <-
  # Obtain a unique list of value, unnest from a column
  # Base R code
  filter_role_locus <- strsplit(filter_role_locus$role_locus, split = ",")
unlist(filter_role_locus)
str(polymorphisme)


# Doesn't work... yet ?
filter_role_locus <-
  filter_role_locus %>%
  mutate(role_locus = strsplit(as.character(role_locus), ",")) %>%
  unnest(role_locus)





# frequence :
c(0.001:1.000)

locus_uid

site_uid
SI000 ### L

nom_allele
char

# PostgreSQL --------------------------------------------------------------

# https://db.rstudio.com/databases/postgresql/#using-the-rpostgres-package

librarian::shelf(DBI, RPostgres)
# Connect to the default postgres database
con <- dbConnect(RPostgres::Postgres(dbname = ))
