#data
## This is the data folder

It is to be used for all data that is incorporated in the model. 

Do not store workbooks, data, etc. that is only for reference in this folder. 
Reference data that is not used in the model should be saved in 
the "documents" folder.

<<<<<<< HEAD
***Updated: 3/1/23***
=======
*** As of 2/28/23, process needs to be reannotated according "VBP_Import" R script. 
This allows us to skip many risky steps of processing in excel.***

## Data files in this folder include:
	1.	data_anon_glblmbrs_yyyy-mm-dd_globalMembersRoster
	2.	data_confidential_glblmbrs_yyyy-mm-dd_globalMembersRoster #gitignore
	3.	data_anon_vbpbhh_yyyy-mm-dd_allProvidersCombined
	4.	data_confidential_yyyy-mm-dd_allProvidersCombined #gitignore
	5.	DATA_
>>>>>>> fccb0280c37fd4cb1b1395cf8edd3ccb2d76961a

# VBP Report Data
## Import HC VBP Reports
### Methodology
#### Procedure

##### VBP Reports
###### Source Code: ./source/VBP_Import.R
	1.	Reciept from and saving of VBP Reports from BCBSAZ
		A.	The original files for each provider are downloaded from BCBSAZ and stored in thier original form in the Alliance intranet here:
			1.	.\ACO\Data and Reports\BCBS-HCA Reports\VBP Reports\Quality
		B.	The files are renamed using the following naming convention:
			1. 	vbpbhh_report_YYYY-MM-DD_[TIN]_[Provider_Name]_HCA_BHH_VBP_Quality
		C. 	The raw data can be accessed through the "Manage Data Model" function of excel
		D.	These reports have the following date variables to consider
			** From Data Model ***"Detail"*** sheet**
			1.	Cap Period = BCBSAZ Capitated Eligibility as of date
			2. 	Report Period = The date for which the report is processed
				a. 	In other words, the report is *released* on Dec X, for the period ending Nov 1
			3.	Data Period = Report includes claims Adjudicated through this date
				a.	Typically 30-45 days prior to the "Report as of" date, or
				b.	A "30 day claims lag"
			4. 	Measurement End Date = The end of the measurement year
				a. 	Measurement year is January to December
			** From ***"Pivot Summary"*** sheet**
			5.	Report as of date = The actual date on which the report is released
	2.	Loading data to the model
		A. 	The 8 VBP reports, 1 report per provider for the given month, are loaded
			1. 	Data from the *"detail"* sheet of the VBP report is extracted from each excel workbook
			2. 	The 8 new data froms are merged using rbind() to form the *"Master_VBP_Rep_Comb"* data frome, which now contains the member level VBP report data from the *"Detail"* sheet of each provider
	3.	Data is transformed and saved as the primary VBP Reporting table, *"VBP_Rep_Comb"*
		A. 	"RandomID" is assigned to each row, and identifying information is removed
		B. 	"Numerator is modified to count "0" in HDO Numerators as "1" because HDO is reverse coded per HEDIS, and subsequently BCBAZ. We think it is more meaningful to say "93% compliant" consistent with other measures, than "7% Non-Compliant."
	4. 	*"VBP_Rep_Comb"* is exported as a CSV file to:
		A.	./ACO/Data and Reports/BCBS-HCA Reports/VBP Reports
		B. 	With the naming convention:
			/data_original_vbpbhh_YYYY-MM-DD_allProvidersCombined.csv"

###### Aggregation
  1.  The Percent Compliant value for each provider, for each month is extracted from the respective monthly report, and aggregated into one table

