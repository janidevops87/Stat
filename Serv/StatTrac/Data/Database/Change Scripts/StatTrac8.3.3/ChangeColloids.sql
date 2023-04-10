 -- adding TPN crystalloids

PRINT 'ADDING NEW blookdproduct'
INSERT INTO bloodproduct (BloodProductName,BloodProductType)

VALUES ('TPN','crystalloids')


--adding sublocation
PRINT 'ADDING NEW sublocation'
INSERT INTO SubLocation (SubLocationName, Verified, Inactive) 
VALUES ('Clinical Decision Unit', 0, 0)


