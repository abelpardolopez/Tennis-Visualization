# Summary  
In this visualization are represented statics about tennis matches, playing surfaces, tennis player ranking, their probability of win and the evolution of the surfaces they are playing. The two que questions are:
- Is ATP / WTA ranking is it a good predictor of the probability of win?  any differences between men and women?  
- Which percentage of matches are in each surface type? any differences between men and women?  

 
# Design  
 1. The data have been download from [tennis-data.co.uk](http://tennis-data.co.uk/alldata.php). Downloading have been done in R.  
 2. There are plenty of data, data cleaning and ordered has been done in R. It has been eliminated lots of columns. And it has been filtered matches of 5 sets for men, trying to avoid errors in comparison due to the differences in the number of sets.  
 3. Some preliminary analyses and visualization have been done also in R, before the interactive visualization.  
 4. The first visualization was at the beginning without bars. But it was difficult to understand the increase in variability with higher rank.  
 5. The second visualization were lines, but it was difficult to compare the data.  
 6. It was not esasy to read the number of matches by category. It has been added the number of matches.  
 
 
# Feedback  
  
     1. Why are more variability for probability graph when the rank is higher? --> It has been added the bars to show the total number of matches.  
     2. Too much ranking, and small graphic --> It has been reduced the maximum ranking, and it has been taken into account the complete window of the broser.
     3. The lines of number of matches for each surfaces cannot be compared easily --> Changed to stacked bars.  
     4. The number of matches for women and men are very different previous to 2007 --> There was no data of women before 2007, to have a fair comparison it has been removed.  
     5. It cannot be seen clearly the values of the bars --> It has been added the number in thousands in the bars.    
     6. The names are not clear enough --> It has been put complete names not acronyms.
   
# Resources  
  
- [Error loading local data](https://stackoverflow.com/questions/10752055/cross-origin-requests-are-only-supported-for-http-error-when-loading-a-local)
- [Run Local Server](https://stackoverflow.com/questions/18586921/how-to-launch-html-using-chrome-at-allow-file-access-from-files-mode)
- [Read More than one file to ds3](https://stackoverflow.com/questions/21842384/importing-data-from-multiple-csv-files-in-d3)
- [Simple Example](http://dimplejs.org/examples_viewer.html?id=bars_vertical_grouped)
- [D3 Doubts](http://www.d3noob.org/2012/12/getting-data.html)
- [D3](https://d3js.org/)
- [Dimple](http://dimplejs.org)
- [Dimple Documentation](https://github.com/PMSI-AlignAlytics/dimple/wiki)
- [Multi-line series example](https://stackoverflow.com/questions/22914933/dimple-js-multi-series-line-charts)
- [Horizontal lines](http://dimplejs.org/examples_viewer.html?id=lines_horizontal_stacked)
- [Tennis Data](http://tennis-data.co.uk/alldata.php)
- [Bar Labels](http://dimplejs.org/advanced_examples_viewer.html?id=advanced_bar_labels)  

# Files and Data  
Data downloaded have been stored in data folder. The final data it is stored in the same folder than the html file. 
Preprocessing and previsualization have been done in following R files:  
  
 - download_read_tennis_data.R  
 - clean_tennis_v01.R
 - analyses_tennis_v01.Rmd; and html for just visualization to see the preliminary data exploration.
  
  
The final data files are:   
   
- probability_win_by_rank_sex_v2.csv   
- matches_by_surface_and_sex_v2.csv for the second visualizaton   

The previous versions of the visualization were saved in [Github](https://github.com/abelpardolopez/Tennis-Visualization) under the file: tennis_visualization.html
  

