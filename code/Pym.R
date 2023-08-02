#install.packages("openNLP")
#install.packages("openNLPdata")
#install.packages("rJava")
install.packages("openNLPmodels.en")

#loading packages
library(tidyverse)
library(NLP)
library(openNLP)
library(openNLPdata)
library(rJava)
library(readr)
library(stringr)
library(openNLPmodels.en)

av <- available.packages(filters=list())
av[av[, "Package"] == 'openNLPmodels.en', ]

#prepping the text of Arthur Gordon Pym of Nantucket by Edgar Allen Poe.
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

#break up the full text into chapters.
str_count(pym, "CHAPTER") #24 chapters not including the preface
pym_chapters <- str_split_1(pym, "CHAPTER")

#choosing an excerpt to text with / changing to character vector.
pym_excerpt <- as.String("Augustus Barnardthoroughly entered into my state of mind. It is probable, indeed, that our intimate communion, Augustus and mine, had resulted in a partial interchange of character.  About eighteen months after the period of the Ariel's disaster, the firm of Lloyd and Vredenburgh (a house connected in some manner with the Messieurs Enderby, I believe, of Liverpool) were engaged in repairing and fitting out the brig Grampus of Philadelphia for a whaling voyage.")


## Need sentence and word token annotations.
sent_token_annotator <- Maxent_Sent_Token_Annotator()
word_token_annotator <- Maxent_Word_Token_Annotator()

#works
pym_annotate <- annotate(pym_excerpt , list(sent_token_annotator, word_token_annotator))

## Entity recognition for persons.
entity_annotator <- Maxent_Entity_Annotator()
entity_annotator

#using the entity annotator on pym excerpt
pym_ent <- annotate(pym_excerpt, entity_annotator, pym_annotate)

str(pym_ent) #object of 'Annotation' class
pym_ent$features


## Directly:
entity_annotator(s, a2)
## And slice ...
s[entity_annotator(s, a2)]
## Variant with sentence probabilities as features.
annotate(s, Maxent_Entity_Annotator(probs = TRUE), a2)



# Load the POS tagger model
pos_tag_model <- Maxent_POS_Tag_Annotator()
# Load the Sentence model
sent_token_annotator <- Maxent_Sent_Token_Annotator()
word_token_annotator <- Maxent_Word_Token_Annotator()

a2 <- annotate(s, list(sent_token_annotator, word_token_annotator))

# Tokenize the text
tokens <- tokenize("raw_data/pym.txt")
tokens[1:10]

?tokenize()

# Perform POS tagging
tags <- annotate(tokens, pos_tag_model)

# Print the result
print(tags)
