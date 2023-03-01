# data
## This is the data folder

It is to be used for all data that is incorporated in the model. 

Do not store workbooks, data, etc. that is only for reference in this folder. 
Reference data that is not used in the model should be saved in 
the "documents" folder.

*** As of 2/28/23, process needs to be reannotated according "VBP_Import" R script. 
This allows us to skip many risky steps of processing in excel.***

## Data files in this folder include:
	1.	data_anon_glblmbrs_yyyy-mm-dd_globalMembersRoster
	2.	data_confidential_glblmbrs_yyyy-mm-dd_globalMembersRoster #gitignore
	3.	data_anon_vbpbhh_yyyy-mm-dd_allProvidersCombined
	4.	data_confidential_yyyy-mm-dd_allProvidersCombined #gitignore
	5.	DATA_

	1.	BCBSAZHCA Membership Roster (anonymized on secure NARBHA server prior to incorporation here)
	2.	allianceCitiesandClinics (a list of the cities and counties where alliance providers are located)
	3.	zipCodeDatabase (A table of zipcodes, cities and counties, and latitude and longitude)
	4. 	VBP bhh report combined (a combined table of all alliance providers' vbp reports)

The data is produced in 2 forms:
1. anon = all identifying information for bhh and members is anonomized
2. confidential = all identifying informaiton for members is anonomized	

The confidential form is ignored by git

The original data is stored here:
.\\OneDrive - The NARBHA Institute\ACO\Data and Reports\Alliance Progress Reports\

# Processes

## VBP Quality Reports

1. Receive from Yolanda Usury at HCA to Blue Inter-departmental SharePoint folder
2. Copy directly to Narbha Alliance SharePoint *Data and Reports* Folder
3. Access member level data by managing the data model in excel. Copy all data from the *detail* tab, and paste into new tab in MASTER HCA VBP Reports Combined excel file.
4. Naming convention for provider tables in master file: "vbp_[health home short name]_yyyymmdd"
5. Query bhh tables into combined worksheet, Then Append queries for all tables into one table *vbp_bhh_allProv*. 
6. Create a randomID using last 2 character of first name, last name, and shcaid.
7. Remove unneeded columns, including all phi
8. export to csv as *data_anon_vbpbhh_yyyy-mm-dd_allProviders*

**Note:** all dates need to be custom formatted to *yyyy-mm-dd* **