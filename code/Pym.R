install.packages("openNLP")
install.packages("openNLPdata")
install.packages("rJava")

library(tidyverse)
library(NLP)
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

pym_excerpt <- as.character("Augustus thoroughly entered into my state of mind. It is probable, indeed, that our intimate communion had resulted in a partial interchange of character.  About eighteen months after the period of the Ariel's disaster, the firm of Lloyd and Vredenburgh (a house connected in some manner with the Messieurs Enderby, I believe, of Liverpool) were engaged in repairing and fitting out the brig Grampus for a whaling voyage.")


# Load the POS tagger model
pos_tag_model <- Maxent_POS_Tag_Annotator()

# Tokenize the text
tokens <- tokenize("raw_data/pym.txt")
tokens[1:10]

# Perform POS tagging
tags <- annotate(tokens, pos_tag_model)

# Print the result
print(tags)
