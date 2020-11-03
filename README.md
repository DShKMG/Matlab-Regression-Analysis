# Matlab-Regression-Analysis
Dilated Collagen Type II. Describing viscosity via Power and Hershel Bulkley model. Used regressional Analysis to handle the data.

# File definitions
Main - Main file which evaluates the raw capillary pressure against piston displacement as deformation rate and shear stress which will give us the viscosity
GetWholeinExcel - Gets the evaluated data from main and sums them all in an excel file. It contains flow consistency index and flow behavior index as A and B. It lso has gamma       values where those given indexses fits. 
FindBestFits - Finds the best fitted values
ExitPressure - Calculates exit pressure relation from raw data and inteprete it to find whether there is a possible elastisity of the fluid. 

Assistent files :
Those are the files contain functions which is used in Main function. It is similar to header files
Derivator - Gets the numerical derivation of given arrays
round_odd - Rounds up to an odd number. Planned to be used in savitzky golay filter part of the Main file. Savitzky Golay frame length is decided to be manually later

#Notes
The raw data is not presented here due to the couple reasons. Data is owned by an university.
