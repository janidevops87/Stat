<%
Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 
 %>
<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="EXPIRES" content="0">
<title>COP Report Column Definitions</title>
<STYLE>
    UL {page-break-before: always}
</STYLE>
</head>

<body bgcolor="#F5EBDD">

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<h2>COP Report Column Definitions</h2>
<A name="FacilityDeaths"><b><font color="#003399" size=+1>Facility Deaths: </font></b></a>
   This is the number of actual deaths that occurred at the facility as recorded by Gift of Life.  This number is not derived from the StatTrac
   database.  Instead, it is directly entered by Gift Of Life personnel after doing a review of actual hospital records.
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<A name="DeathsReported"><b><font color="#003399" size=+1>Deaths Reported: </font></b></A>
   This is the number of death report phone calls we received from that facility where the CTOD field has been completed.  It will not capture those referrals that do not have a CTOD listed in the CTOD field.
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<A name="AllFamilyApproaches"><b><font color="#003399" size=+1>All Family Approaches: </font></b></A>
   This is the total of all families that were approached.  This number includes approaches by anybody as well as "approaches" where the patient was
   found in the donor registry.

   This total includes approaches for all types of referrals - organ, tissue, and eye.
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<A name="TrainedRequestorApproaches"><b><font color="#003399" size=+1>Trained Requestor Approaches: </font></b></A>
   This is the number of approaches done by people who are identified as "Designated Requestors" by having an asterisk after their name.  This number
   also includes "approaches" where the patient was found in the donor registry.

   This total includes approaches for all types of referrals - organ, tissue, and eye.
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<A name="VentedNotifications"><b><font color="#003399" size=+1>Vented Notifications: </font></b></A>
   This is the number of death notification calls from this facility where the patient was currently on a ventilator at the time of the call.  This
   number includes patients who were later ruled out as potential donors for other reasons.
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<A name="EligibleDeaths"><b><font color="#003399" size=+1>Eligible Deaths: </font></b></A>
   This is the count of deaths that met all three UNOS criteria for organ donation:
        Less than or equal to 70 years of age
        Declared brain dead
        No medical conditions that are automatic rule-out's
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<A name="SuitableOrganApproaches"><b><font color="#003399" size=+1>Suitable Organ Approaches: </font></b></A>
   This is the count of deaths that were "eligible" for organ donation (per the above definition) and for which an approach was done.  Note that this
   number includes "approaches" where the patient was found in the donor registry.

   This number does not distinguish between trained and untrained requestors.
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<A name="SuitableOrganConsents"><b><font color="#003399" size=+1>Suitable Organ Consents: </font></b></A>
   This is the count of deaths that were "eligible" for organ donation (per the above definition) and for which consent for organ donation was
   obtained.  Note that this number includes "approaches" where the patient was found in the donor registry - a.k.a. first-person consents.
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<A name="ActualOrganDonors"><b><font color="#003399" size=+1>Actual Organ Donors: </font></b></A>
   This is the count of "eligible" deaths where one or more organs were actually recovered. This would also include recoveries from patient's that are found on the donor registry- a.k.a first-person consents
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<A name="NonUNOSDonors"><b><font color="#003399" size=+1>Non-UNOS Donors: </font></b></A>
   This is the count of deaths from which organs were actually recovered, but which do not meet the strict definition for UNOS eligibility.  Usually,
   they are not eligible because they are older than 70 (although there can be other reasons).
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
&nbsp;
</body>

</html>