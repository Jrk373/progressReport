# This is the data folder

It is to be used for all data that is incorporated in the model. 

Do not store data that is only for reference in this folder. 
Reference data that is not used in the model should be saved in 
the "documents" folder.

## Data files in this folder include:
	1.	BCBSAZHCA Membership Roster (anonymized on secure NARBHA server prior to incorporation here)
	2.	allianceCitiesandClinics (a list of the cities and counties where alliance providers are located)
	3.	zipCodeDatabase (A table of zipcodes, cities and counties, and latitude and longitude)

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

**Note:** all dates need to be custom formatted to *yyyy-mm-dd*

