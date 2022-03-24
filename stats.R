library(tidyverse)
library(stringr)

# price vs. review count

price_rev <- d %>% 
  mutate(price_num_pln = parse_double(str_remove(price, " PLN"), 
                                      locale = locale(decimal_mark = ",")),
         review_count_num = str_remove_all(review_count, "[)(]"),
         review_count_num = str_replace(review_count_num, "null", "0"),
         review_count_num = parse_integer(review_count_num)) %>% 
  select(price_num_pln, review_count_num)

summary(price_rev)

price_rev %>% 
  ggplot(aes(review_count_num, price_num_pln)) +
  geom_point(size = 3, alpha = 0.1) + 
  geom_smooth()
  
price_rev %>% 
  ggplot(aes(review_count_num > 100, price_num_pln)) +
  geom_boxplot() + 
  coord_flip()
