/***************************************************************************************************
**	Name: DRDSNRegistryOwner
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/16/2020	Andrey Savin	Initial Script Creation
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM DRDSNRegistryOwner) = 0)
BEGIN
	PRINT 'Loading DRDSNRegistryOwner Data';

	INSERT [DRDSNRegistryOwner]
           ([DRDSNID],
            [RegistryOwnerId])
     VALUES
        (1, 2), -- Colorado Registry DMV_CO
        (2, 2), -- Wyoming Registry DMV_WY
        (11,3), -- Nevada Registry DMV_NV
        (27,5), -- Hawaii Registry DMV_HI
        (8, 6); -- Michigan Registry DMV_MI
END