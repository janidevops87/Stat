SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_RegistryLookup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_RegistryLookup]
GO



CREATE PROCEDURE sps_RegistryLookup

	@vSSN			varchar(11) 	= '',
	@vDLN			varchar(9)	= '',
	@vLastName		varchar(20)	= '',
	@vDOB		datetime	= null

AS

IF Not @vSSN =  ''
	SET	@vSSN =  @vSSN + '%'

IF Not @vDLN =  ''
	SET	@vDLN = @vDLN + '%'

IF Not @vLastName =  ''
	SET	@vLastName = @vLastName + '%'

IF 	Not @vSSN =  ''
AND	@vDLN =  ''
AND	@vLastName =  ''
AND	@vDOB Is Null 

	SELECT DISTINCT
		 	First, Middle, Last, Suffix, Addr1, Addr2, City, State, Zip1, Zip2, SSN, License, CONVERT(varchar(10), DOB, 101)  AS DOB
	FROM 		LA_DMV_Registry
	WHERE 	SSN Like @vSSN

IF 	@vSSN =  ''
AND	Not @vDLN =  ''
AND	@vLastName=  ''
AND	@vDOB Is Null 

	SELECT DISTINCT
		 	First, Middle, Last, Suffix, Addr1, Addr2, City, State, Zip1, Zip2, SSN, License, CONVERT(varchar(10), DOB, 101)  AS DOB
	FROM 		LA_DMV_Registry
	WHERE 	License Like @vDLN

IF 	@vSSN =  ''
AND	@vDLN =  ''
AND	Not @vLastName =  ''
AND	@vDOB Is Null 

	SELECT DISTINCT
		 	First, Middle, Last, Suffix, Addr1, Addr2, City, State, Zip1, Zip2, SSN, License, CONVERT(varchar(10), DOB, 101)  AS DOB
	FROM 		LA_DMV_Registry
	WHERE 	Last Like @vLastName

IF 	@vSSN =  ''
AND	@vDLN =  ''
AND	@vLastName =  ''
AND	Not @vDOB Is Null 

	SELECT DISTINCT
		 	First, Middle, Last, Suffix, Addr1, Addr2, City, State, Zip1, Zip2, SSN, License, CONVERT(varchar(10), DOB, 101)  AS DOB
	FROM 		LA_DMV_Registry
	WHERE 	DOB Like @vDOB

IF 	Not @vSSN =  ''
AND	Not @vDLN =  ''
AND	@vLastName =  ''
AND	@vDOB Is Null 

	SELECT DISTINCT
		 	First, Middle, Last, Suffix, Addr1, Addr2, City, State, Zip1, Zip2, SSN, License, CONVERT(varchar(10), DOB, 101)  AS DOB
	FROM 		LA_DMV_Registry
	WHERE 	SSN Like @vSSN
	AND		LICENSE Like @vDLN

IF 	Not @vSSN =  ''
AND	@vDLN =  ''
AND	Not @vLastName =  ''
AND	@vDOB Is Null 

	SELECT DISTINCT
		 	First, Middle, Last, Suffix, Addr1, Addr2, City, State, Zip1, Zip2, SSN, License, CONVERT(varchar(10), DOB, 101)  AS DOB
	FROM 		LA_DMV_Registry
	WHERE 	SSN Like @vSSN
	AND		LAST Like @vLastName

IF 	Not @vSSN =  ''
AND	@vDLN =  ''
AND	@vLastName =  ''
AND	Not @vDOB Is Null 

	SELECT DISTINCT
		 	First, Middle, Last, Suffix, Addr1, Addr2, City, State, Zip1, Zip2, SSN, License, CONVERT(varchar(10), DOB, 101)  AS DOB
	FROM 		LA_DMV_Registry
	WHERE 	SSN Like @vSSN
	AND		DOB =  @vDOB

IF 	@vSSN =  ''
AND	Not @vDLN =  ''
AND	Not @vLastName =  ''
AND	@vDOB Is Null 

	SELECT DISTINCT
		 	First, Middle, Last, Suffix, Addr1, Addr2, City, State, Zip1, Zip2, SSN, License, CONVERT(varchar(10), DOB, 101)  AS DOB
	FROM 		LA_DMV_Registry
	WHERE 	LICENSE Like @vDLN
	AND		LAST Like @vLastName

IF 	@vSSN =  ''
AND	Not @vDLN =  ''
AND	@vLastName =  ''
AND	Not @vDOB Is Null 

	SELECT DISTINCT
		 	First, Middle, Last, Suffix, Addr1, Addr2, City, State, Zip1, Zip2, SSN, License, CONVERT(varchar(10), DOB, 101)  AS DOB
	FROM 		LA_DMV_Registry
	WHERE 	LICENSE Like @vDLN
	AND		DOB =  @vDOB

IF 	@vSSN =  ''
AND	@vDLN =  ''
AND	Not @vLastName =  ''
AND	Not @vDOB Is Null 

	SELECT DISTINCT
		 	First, Middle, Last, Suffix, Addr1, Addr2, City, State, Zip1, Zip2, SSN, License, CONVERT(varchar(10), DOB, 101)  AS DOB
	FROM 		LA_DMV_Registry
	WHERE 	LAST Like @vLastName
	AND		DOB =  @vDOB

IF 	NOT @vSSN =  ''
AND	NOT @vDLN =  ''
AND	Not @vLastName =  ''
AND	Not @vDOB Is Null 

	SELECT DISTINCT
		 	First, Middle, Last, Suffix, Addr1, Addr2, City, State, Zip1, Zip2, SSN, License, CONVERT(varchar(10), DOB, 101)  AS DOB
	FROM 		LA_DMV_Registry
	WHERE 	SSN Like @vSSN
	AND		LICENSE Like @vDLN
	AND		LAST Like @vLastName
	AND		DOB =  @vDOB



















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

