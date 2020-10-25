library(tidyverse)
library(readr)

covid_df = read_csv("C:\\Users\\12172\\Desktop\\Course\\Resume_projects\\Rprojects_Covid Testing_Resume\\tested_worldwide.csv")
diemnsion_covid_data  = dim(covid_df)
  
diemnsion_covid_data
##all the columns in our data
col_names = colnames(covid_df)
glimpse(covid_df)
col_names

covid_df
#removing inconsistent data column
covid_df_all_states = covid_df %>%
  filter(Province_State == "All States") %>%
  select(-Province_State)
covid_df_all_states

#extracting daily based data from the dataset
covid_df_all_states_daily = covid_df_all_states %>%
select( Date,Country_Region,active,hospitalizedCurr,daily_tested, positive)


##summarising data columns by country_region
group_daily_data = covid_df_all_states_daily %>%
  group_by(Country_Region) %>%
  summarize(tested = sum(daily_tested, na.rm=TRUE),positive = sum(positive, na.rm=TRUE), 
            active = sum(active,na.rm=TRUE), hospitalized = sum(hospitalizedCurr,na.rm=TRUE)) %>%
arrange (desc(tested))
group_daily_data

covid_df_top_10 = head(group_daily_data, 10)
covid_df_top_10

##selecting columns 

country  = covid_df_top_10 $Country_Region
tested_cases  = covid_df_top_10 $ tested
positive_cases = covid_df_top_10 $positive
active_cases = covid_df_top_10 $active
hospitalized_cases = covid_df_top_10 $hospitalized

## naming variable by country 
names(positive_cases) = country
names(tested_cases) = country
names(active_cases) = country
names(hospitalized_cases) = country

#checking cases by country 
positive_cases
tested_cases
active_cases
hospitalized_cases

#stats of positive cases:
positive_cases
sum(positive_cases)
mean(positive_cases)
(positive_cases/sum(positive_cases))*100

df_pos = (positive_cases/sum(positive_cases))*100
sort(df_pos/100, decreasing = TRUE)
#order_by(desc(df_pos_cases))
top5_positive_cases = c("United_States" = 0.85, "Italy" = 0.066,"Canada" = 0.0257,"Russia" = 0.068, "Australia" = 0.039)
top5_positive_cases



## creating Vectors : Ratio", "tested", "positive", "active", "hospitalized"
United_States <- c(0.85, 93067489, 544591282, 0, 0)
Italy =  c(0.066, 10571655, 41931402, 8726025, 1909253)
Canada =  c(0.0257, 6687492, 16319165, 352261, 0)
Russia =  c(0.068, 11319603, 10669646, 7621860, 0)
Australia = c(0.039, 7127767, 2344289,382152, 34941)


# Creating the matrix covid_mat
covid_matrix <- rbind(United_States,Italy, Canada,Russia,Australia)

# Naming columns
colnames(covid_matrix) = c("Ratio", "tested", "positive", "active", "hospitalized")
covid_matrix

##Analysis 

Problem = "Top 5 countries with highest number of positive cases versus the number of tests?"
Solution = c("Positive tested cases:" = top5_positive_cases)

datasets = list(
  original = covid_df,
  allstates = covid_df_all_states,
  daily = covid_df_all_states_daily,
  top_10 = covid_df_top_10)

datasets

measures = list(covid_matrix)
measures

vectors = list(col_names,country)
vectors

List_of_columns = list("dataframe" = datasets, "matrix" = measures, "vector" = vectors)
List_of_columns

covid_analysis_list = list(Problem, Solution, List_of_columns)
covid_analysis_list[[1]]
sort(covid_analysis_list[[2]], decreasing = TRUE)


## ploting the graph 
## ratio vs tested by country 
df = as.data.frame(covid_matrix)
colnames(df)


max_y = max(df$Ratio)
min_y = min(df$Ratio)

plot_colors = c("blue","red","forestgreen")
#plot.window(xlim=c(0,1), ylim=c(10,20))

plot(df$Ratio, type="o", col=plot_colors[3], ylim=c(0,max_y), axes=TRUE, ann= FALSE, 
     xlab = "Country", ylab = "Ratio")


range = sort(df$Ratio)
x =list(sort(range))

axis( 1, at = 1:5, labels = c("United_States","Italy", "Canada","Russia","Australia"))

box()

#axis(2, las = 1,at =0.005:max_y, labels = c(range))
title(main="Covid", col.main="red", font.main=4)

title(xlab= "Country", col.lab=rgb(0,0.5,0))
title(ylab= "Ratio", col.lab=rgb(0,0.5,0))

legend(4, max_y, names(df), cex=0.7, col=plot_colors,pch=21:23, lty=1:3)
