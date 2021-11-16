#raw murders dataset read line by line
filename <- system.file("extdata/murders.csv", package = "dslabs")
filename
lines <- readLines(filename)
head(lines)
#split at commas 
library(tidyverse)
x <- str_split(lines, ",")
head(x)
col_names <-x[[1]]
col_names
x <- x[-1]
head(x)
#extract first element of each list entry 
map(x, function(y) y[1]) %>% head()
#extract columns 1-5 as characters
dat <- data.frame(parse_guess(map_chr(x,1)), 
                  parse_guess(map_chr(x,2)), 
                  parse_guess(map_chr(x,3)), 
                  parse_guess(map_chr(x,4)), 
                  parse_guess(map_chr(x,5))) %>% 
  setNames(col_names) 
head(dat)
#more efficient code for the same thing
dat1 <- x %>% transpose() %>% 
  map(~parse_guess(unlist(.))) %>% 
  setNames(col_names) %>% 
  as.data.frame()
head(dat1)

#the simplify argument returns a matrix
x <- str_split(lines, ", ", simplify = T)
x
col_names <- x[1,]
x %>% as_data_frame() %>% setNames(col_names) %>% 
  mutate_all(parse_guess)
#case study
