# Exporting data

Now that you have learned how to use **`dplyr`** to extract information from
or summarize your raw data, you may want to export these new data sets to share
them with your collaborators or for archival.

Similar to the `read_csv()` function used for reading CSV files into R, the tidyverse includes a `write_csv()` function that generates CSV files from data frames.

Before using `write_csv()`, we are going to create a new folder, `data_output`,
in our working directory that will store this generated data set. We don't want
to write generated data sets in the same directory as our raw data. It's good
practice to keep them separate. The `data` folder should only contain the raw,
unaltered data, and should be left alone to make sure we don't delete or modify
it. In contrast, our script will generate the contents of the `data_output`
directory, so even if the files it contains are deleted, we can always
re-generate them.

In preparation for our next lesson on plotting, we are going to prepare a
cleaned up version of the data set that doesn't include any missing data.

Let's start by removing observations for which the `species_id` is missing. In
this data set, the missing species are represented by an empty string and not an
`NA`. Let's also remove observations for which `weight` and the
`hindfoot_length` are missing. This data set should also only contain
observations of animals for which the sex has been determined:
  
  
  ```{r, purl=FALSE}
surveys_complete <- surveys %>%
  filter(!is.na(weight),           # remove missing weight
         !is.na(hindfoot_length),  # remove missing hindfoot_length
         !is.na(sex))                # remove missing sex
```

Because we are interested in plotting how species abundances have changed
through time, we are also going to remove observations for rare species (i.e.,
                                                                         that have been observed less than 50 times). We will do this in two steps: first
we are going to create a data set that counts how often each species has been
observed, and filter out the rare species; then, we will extract only the
observations for these more common species:
  
  ```{r, purl=FALSE}
## Extract the most common species_id
species_counts <- surveys_complete %>%
  group_by(species_id) %>%
  tally() %>%
  filter(n >= 50)

## Only keep the most common species
surveys_complete <- surveys_complete %>%
  filter(species_id %in% species_counts$species_id)
```

```{r, eval=FALSE, purl=TRUE, echo=FALSE}
### Create the dataset for exporting:
##  Start by removing observations for which the `species_id`, `weight`,
##  `hindfoot_length`, or `sex` data are missing:
surveys_complete <- surveys %>%
  filter(species_id != "",        # remove missing species_id
         !is.na(weight),                 # remove missing weight
         !is.na(hindfoot_length),        # remove missing hindfoot_length
         sex != "")                      # remove missing sex

##  Now remove rare species in two steps. First, make a list of species which
##  appear at least 50 times in our dataset:
species_counts <- surveys_complete %>%
  group_by(species_id) %>%
  tally() %>%
  filter(n >= 50) %>%
  select(species_id)

##  Second, keep only those species:
surveys_complete <- surveys_complete %>%
  filter(species_id %in% species_counts$species_id)
```

To make sure that everyone has the same data set, check that `surveys_complete`
has `r nrow(surveys_complete)` rows and `r ncol(surveys_complete)` columns by
typing `dim(surveys_complete)`.

Now that our data set is ready, we can save it as a CSV file in our `data_output`
folder.

```{r, purl=FALSE, eval=FALSE}
write_csv(surveys_complete, path = "data_output/surveys_complete.csv")
```

```{r, purl=FALSE, eval=TRUE, echo=FALSE}
if (!file.exists("data_output")) dir.create("data_output")
write_csv(surveys_complete, path = "data_output/surveys_complete.csv")
```
 ## SAVING PLOTS

Saving out plots with `save_plot` can be a good way to preserve or change the aspect ratio. See how changing the aspect ratio changes the output:
  
  
  ```{r, cowplotSave, eval=F, echo=T}

# save_plot can be a nice way to set the aspect_ratio...play with these options
save_plot("figures/plot2by1_11.png", fixed_gridplot, dpi=300,
          ncol = 2, # we're saving a grid plot of 2 columns
          nrow = 2, # and 2 rows
          # each individual subplot should have an aspect ratio of 1.3
          base_aspect_ratio = 1.1
)

```

**Ratio of 1.1**: 
  
  ![ratio1.1](figures/plot2by1_11.png)

**Ratio of 1.5**
  ![ratio1.5](figures/plot2by1_15.png)