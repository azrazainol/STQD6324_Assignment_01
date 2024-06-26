humour_csv <- read.csv("data/humour_data.csv")

# Load required libraries
library(tm)

# 1. Create humor lexicon from dataset
humor_lexicon <- setNames(humour_csv$Rating, humour_csv$Word)

# 2. Tokenize text in corpus object
# Assuming 'corpus_obj' is your corpus object
corpus_tokens <- lapply(regshow1$content, function(text) {
  tolower(unlist(strsplit(text, "\\W+")))
})

# 3. Assign humor ratings to tokens
corpus_humor_ratings <- lapply(corpus_tokens, function(tokens) {
  ratings <- sapply(tokens, function(token) {
    if (token %in% names(humor_lexicon)) {
      return(humor_lexicon[token])
    } else {
      return(NA)  # Token not found in humor lexicon
    }
  })
  return(ratings)
})

# 4. Calculate overall humor level for each line
line_humor_levels <- sapply(corpus_humor_ratings, function(ratings) {
  if (all(is.na(ratings))) {
    return(NA)  # No humor ratings found for line
  } else {
    return(mean(ratings, na.rm = TRUE))
  }
})

# Display humor levels for each line
line_humor_levels

# Calculate mean humor level
mean_humor_level <- mean(line_humor_levels, na.rm = TRUE)
cat("Mean Humor Level:", mean_humor_level, "\n")

# Create histogram for humor levels
hist(line_humor_levels, main = "Humor Levels in Corpus", xlab = "Humor Level", ylab = "Frequency")
