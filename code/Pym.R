install.packages("openNLP")
install.packages("openNLPdata")
install.packages("rJava")

library(tidyverse)
library(openNLP)
library(openNLPdata)
library(rJava)
library(readr)
library(stringr)


pym <- read_file("raw_data/pym.txt")

#replace the "\n" with an actual spaces
pym <- pym %>% str_replace_all("\n", " ")

#strip out before the title, "Title:"
pym <- pym %>% str_split_1("Title:")
substr(pym[2], 1, 2000) #viewing the head

#strip out the ending after "THE END."
pym <- pym %>% str_split_i("THE END.",1)
str(pym)

#stripping out before the title and changing to character
pym <- as.character(pym[2])

#break up into chapters.
str_count(pym, "CHAPTER") #24 chapters not including the preface

pym_chapters <- str_split_1(pym, "CHAPTER")

pym_chapters[2]
