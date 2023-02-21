SELECT dm.primaryId
	, dm.ahcccsId
	, cid.lastName
	, cid.firstName
	, cid.sex
	, cid.dob
	, cid.zipCode
	, da.resCountyName
	, dm.bhhShortname
	, dm.bhhEffectiveDate
	, dm.lineOfBusiness
	, dm.bhc
	, dm.disenrollmentDate


FROM 
globalMembers.dbo.dailyMembershipAllArizonaEnrollments dm
LEFT JOIN globalMembers.dbo.clientIdPlus cid ON dm.primaryId = cid.primaryId
LEFT JOIN globalMembers.dbo.dailyMembershipAllArizonaAddresses da ON dm.primaryId = da.primaryId