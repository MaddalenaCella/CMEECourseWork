## CMEE MiniProject

This Project is a model fitting exercise completed in partial fulfillment of the MRes in Computational Methods in Ecology and Evolution. All scripts are stored in the Code subdirectory, all results produced by running the project will be located in the Results subdirectory and all data files used are stored in the Data subdirectory. To run this project ypu just need to run the bash script found in the Code subdirectory. 

## Prerequisites

Before you begin, ensure you:

* have a Linux or Mac machine
* have R version: 3.5.1
* have installed TeX Live 2019/Debian 

It is advised you install the following R packages to successfully run the scripts:
* plyr
* tidyverse
* minpack.lm
* patchwork

This can be done within the R console:
```{r}
install.packages("package_name")
```

## Running the Project
In order to run the Project make sure to be in the Code subdirectory and then run the RunMiniProject.sh script.
To do so, simply write this on your terminal:

```{sh}
sh RunMiniProject.sh
```

## Content of Code subdirectory

In the Code sub-directory you can find all the scripts written for this MiniProject, including the script that runs all the R scripts and compiles the report written in Latex.

The R scripts are the following:

* GrowthData.r: script that produces the tidied datasets;
* FittedData.r: script that fits the models to the data;
* SelectData.r: script that analyses models' performances;
* growth_curves.r: script that analyses model fitting for three bacteria species cultured at different temperatures;
* Tempoverall.r: script that evaluates model performance on the pooled dataset and looks for an effect of temperature on model performance.

The shell scripts are the following:
* RunMiniProject.sh: a shell script that runs the whole project;
* wordcount.sh: a shell script that provides the wordcount for a Latex file.

The Tex and BibTex files are the following:
* CMEEproject.tex: main report;
* CMEEproject.bib: bibliography.

## Content of Data subdirectory

In the Data sub-directory you can find the data necessary to run the scripts and a MetaData file containing all the information regarding the dataset. This folder will become populated by more files as you run the Project. The dataset and MetaData file were downloaded from https://github.com/mhasoba/TheMulQuaBio/tree/master/content/data.

## Content of Results subdirectory

The Results sub-directory contains just a copy of the MiniProject report, but will be populated by the outputs of the scripts once they have run. 

## Contributors

Thanks to [@mhasoba](https://github.com/mhasoba) for teaching me the skills to ba able to perform the Projec, my group (group 4) and PokMan [@ph-u](https://github.com/ph-u) for the incredible help and support.

## Contact

If you want to contact me, you can reach me at <mc2820@ic.ac.uk>.