##============================================================================##
## Load required libraries
##============================================================================##
library(landscapemetrics)
library(tidyverse)
library(terra)
##============================================================================##

##============================================================================##
## Load the data
##============================================================================##
data <- readRDS("path_to_your_binary_data.rds")
##============================================================================##

##============================================================================##
## Assign names to the data
##============================================================================##
names(data) <- 'Species'
##============================================================================##

##============================================================================##
## Define and apply new projection for equal area
##============================================================================##
new_projection <- "+proj=laea +lat_0=44.3 +lon_0=-3.2 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs"
data <- data %>% terra::project(., new_projection, method = 'near')
##============================================================================##

##============================================================================##
## Calculate landscape metrics
##============================================================================##
metrics <- calculate_lsm(data, 
                         what = c('lsm_c_np', 
                                  'lsm_c_mesh',
                                  'lsm_c_cohesion'), 
                         progress = TRUE, 
                         full_name = TRUE)
##============================================================================##

##============================================================================##
## Save metrics to disk
##============================================================================##
saveRDS(metrics, 'path_to_save_landscape_metrics.rds')
##============================================================================##

##============================================================================##
## Combine metrics into a single data frame
##============================================================================##
names_df <- data.frame(Original_names = names(data),
                       Landscape_names = paste0('A', 1),
                       Species_names = names(data))

combined_metrics <- metrics %>%
  filter(class == 1) %>%
  select(-c(class, id, level, name, type, function_name)) %>%
  pivot_wider(names_from = 'metric', values_from = 'value') %>%
  mutate(Landscape_names = paste0('A', layer)) %>%
  inner_join(names_df, by = c("Landscape_names" = "Landscape_names")) %>%
  select(Taxon = Species_names, everything(), -c(layer, Landscape_names, Original_names)) %>%
  full_join(metrics %>%
              filter(class == 1) %>%
              select(-c(class, id, level, name, type, function_name)) %>%
              pivot_wider(names_from = 'metric', values_from = 'value') %>%
              mutate(Landscape_names = paste0('A', layer)) %>%
              inner_join(names_df, by = c("Landscape_names" = "Landscape_names")) %>%
              select(Taxon = Species_names, everything(), -c(layer, Landscape_names, Original_names)) %>%
              unnest(cols = c(area)) %>%
              group_by(Taxon) %>%
              summarise(mean_area = mean(area, na.rm = TRUE),
                        sd_area = sd(area, na.rm = TRUE),
                        median_area = median(area, na.rm = TRUE),
                        min_area = min(area, na.rm = TRUE),
                        max_area = max(area, na.rm = TRUE),
                        q25_area = quantile(area, probs = 0.25, na.rm = TRUE),
                        q75_area = quantile(area, probs = 0.75, na.rm = TRUE)))

combined_metrics %>% 
  arrange(desc(pland)) %>% 
  as.data.frame()

saveRDS(combined_metrics, 'path_to_save_combined_metrics.rds')
openxlsx::write.xlsx(combined_metrics, 'path_to_save_combined_metrics.xlsx')
##============================================================================##
