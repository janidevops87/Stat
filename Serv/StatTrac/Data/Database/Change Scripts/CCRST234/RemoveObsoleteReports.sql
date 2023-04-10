-- Change script that removes obsolete reports that include "/reg" in their ReportDisplayName

DELETE
FROM Report
WHERE ReportDisplayName = 'z-old 1.1 - Referral Compliance (w/Reg)';

DELETE
FROM Report
WHERE ReportDisplayName = 'z-old 3.1 - Approach Summary (All Types - w/Reg)';

DELETE
FROM Report
WHERE ReportDisplayName = 'z-old Reason Summary (w/Reg)';

DELETE
FROM Report
WHERE ReportDisplayName = 'z-old 5.1-Recovered Donor Sum. (All Types - w/Reg)';

DELETE
FROM Report
WHERE ReportDisplayName = 'z-old Age Demographics (w/Reg)';

DELETE
FROM Report
WHERE ReportDisplayName = 'z-old Race Demographics (w/Reg)';

DELETE
FROM Report
WHERE ReportDisplayName = 'z-old 4.5 - Consent Summary (All Types - w/Reg)';

DELETE
FROM Report
WHERE ReportDisplayName = 'z-old 4.6 - Consent Summary (Organs - w/Reg)';

DELETE
FROM Report
WHERE ReportDisplayName = 'z-old 4.7 - Consent Summary (Tissues - w/Reg)';

DELETE
FROM Report
WHERE ReportDisplayName = 'z-old 4.8 - Consent Summary (Eyes - w/Reg)';

DELETE
FROM Report
WHERE ReportDisplayName = 'z-old 4.9 - Consent Summary (By Type - w/Reg)';


-- SELECT * FROM Report WHERE ReportDisplayName LIKE '%/reg%' 