using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Statline.Common.Services;
using Statline.Common.Utilities;
using Statline.StatTrac.Domain.EReferrals;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

#nullable enable

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.EReferrals;

public class EReferralRepository : IEReferralRepository
{
    private readonly ReferralTransactionalDbContext referralDbContext;
    private readonly IDateTimeService dateTimeService;

    public EReferralRepository(
        ReferralTransactionalDbContext referralDbContext,
        IDateTimeService dateTimeService)
    {
        Check.NotNull(referralDbContext, nameof(referralDbContext));
        Check.NotNull(dateTimeService, nameof(dateTimeService));

        this.referralDbContext = referralDbContext;
        this.dateTimeService = dateTimeService;
    }

    public async Task<List<FacilityInfo>> GetFacilityCodes(string sourceCode)
    {

        var ret = await referralDbContext.FacilityCodes.FromSqlInterpolated(
                $@"SELECT o.FacilityEreferralCode AS FacilityCode, o.OrganizationName AS FacilityName, 
                    o.OrganizationID AS OrganizationId, NULL AS ContactFirstName, NULL AS ContactLastName,
                    NULL AS ContactTitleId, NULL AS TimeZoneId, NULL AS TimeZoneAbbr, NULL AS ObservesDaylightSavings
                    FROM dbo.Organization o
                    LEFT JOIN dbo.SourceCodeOrganization os ON o.OrganizationID = os.OrganizationID
                    LEFT JOIN dbo.SourceCode sc ON sc.SourceCodeID = os.SourceCodeID
                    WHERE sc.SourceCodeName={sourceCode} and sc.SourceCodeType=1 and isnull(o.FacilityEreferralCode,'') != ''
                    ORDER BY o.OrganizationName;")
            .ToListAsync()
            .ConfigureAwait(false);
        return ret;

    }
    public async Task<int> GetSourceCodeId(string sourceCode)
    {
        var ret = await referralDbContext.Set<IntegerHolder>()
            .FromSqlInterpolated(
                $"SELECT SourceCodeId AS Value FROM dbo.SourceCode WHERE SourceCodeName={sourceCode} and SourceCodeType=1")
            .ToListAsync()
            .ConfigureAwait(false);

        if (ret == null || ret.Count == 0)
            return -1;

        return ret[0].Value;
    }

    public async Task<List<HospitalUnit>> GetHospitalUnitList()
    {
        return await referralDbContext.HospitalUnit.FromSqlRaw(
            "SELECT SubLocationId as HospitalUnitId, SubLocationName as HospitalUnitName FROM dbo.SubLocation ORDER BY SubLocationName")
             .ToListAsync()
             .ConfigureAwait(false);
    }
    public async Task<List<ContactTitle>> GetContactTitleList()
    {
        return await referralDbContext.ContactTitle.FromSqlRaw(
            "SELECT PersonTypeID as ContactTitleId, PersonTypeName as ContactTitleName FROM dbo.PersonType ORDER BY PersonTypeName")
            .ToListAsync()
            .ConfigureAwait(false);
    }

    public async Task<FacilityInfo?> GetFacilityInfo(string sourceCode, string facilityCode, string? contactFirstName, string? contactLastName)
    {
        var fNameParam = new SqlParameter("@fname", contactFirstName);
        if (contactFirstName == null)
            fNameParam.Value = DBNull.Value;
        var lNameParam = new SqlParameter("@lname", contactLastName);
        if (contactLastName == null)
            lNameParam.Value = DBNull.Value;

        return await referralDbContext.FacilityInfo
                .FromSqlRaw(@"IF (SELECT Count(1) FROM dbo.Organization WHERE FacilityEreferralCode=@code)=0
	                                BEGIN
	                                  SELECT NULL as OrganizationId, 'No organization with that facility code' AS FacilityCode, 
	                                    NULL as FacilityName, NULL as ContactFirstName, 
		                                NULL as ContactLastName, NULL as ContactTitleId,
                                        NULL as TimeZoneId, NULL as TimeZoneAbbr, NULL as ObservesDaylightSavings;
	                                END
                               ELSE IF (SELECT Count(1) FROM dbo.Organization o 
		                             LEFT JOIN dbo.SourceCodeOrganization os ON o.OrganizationID = os.OrganizationID
		                             LEFT JOIN dbo.SourceCode sc ON sc.SourceCodeID = os.SourceCodeID
		                             WHERE FacilityEreferralCode=@code AND sc.SourceCodeName=@source )=0
	                                BEGIN
	                                  SELECT NULL as OrganizationId, 'No organization with that facility code and source code' as FacilityCode, 
	                                    NULL as FacilityName, NULL as ContactFirstName, 
		                                NULL as ContactLastName, NULL as ContactTitleId, 
                                        NULL as TimeZoneId, NULL as TimeZoneAbbr, NULL as ObservesDaylightSavings;
	                                END
                               ELSE
	                                BEGIN
	                                  SELECT TOP(1) o.OrganizationId, o.FacilityEreferralCode as FacilityCode, o.OrganizationName as FacilityName,
		                                CASE WHEN (@fname is null OR @lname is NULL) THEN NULL ELSE p.PersonFirst END as ContactFirstName,
		                                CASE WHEN (@fname is null OR @lname is NULL) THEN NULL ELSE p.PersonLast END as ContactLastName,
	                                    CASE WHEN (@fname is null OR @lname is NULL) THEN NULL ELSE p.PersonTypeID END as ContactTitleId, 
                                        t.TimeZoneId, t.TimeZoneAbbreviation as TimeZoneAbbr, CAST(t.ObservesDaylightSavings as int) as ObservesDaylightSavings
	                                  FROM dbo.Organization o
	                                  LEFT JOIN dbo.SourceCodeOrganization os ON o.OrganizationID = os.OrganizationID
	                                  LEFT JOIN dbo.SourceCode sc ON sc.SourceCodeID = os.SourceCodeID
	                                  LEFT JOIN dbo.Person p ON p.OrganizationID = o.OrganizationID
                                      LEFT JOIN dbo.TimeZone t ON t.TimeZoneId = o.TimeZoneId
	                                  WHERE o.FacilityEreferralCode=@code AND sc.SourceCodeName=@source AND
	                                  ((@fname is null OR @lname is NULL) or (p.PersonFirst = @fname AND p.PersonLast=@lname))
	                                END",
                    new SqlParameter("@code", facilityCode),
                    new SqlParameter("@source", sourceCode),
                    fNameParam,
                    lNameParam)
                .AsAsyncEnumerable()
                .FirstOrDefaultAsync()
                .ConfigureAwait(false);
    }

    public async Task<bool> IsMedicalRecordDuplicate(string sourceCode, string facilityCode, string medicalRecord)
    {
        var ret = await referralDbContext.Set<IntegerHolder>()
                .FromSqlInterpolated(
                    $@"SELECT Count(1) as Value
                         FROM [dbo].[Call] c
                         INNER JOIN dbo.Referral r ON r.CallId = c.CallId
                         LEFT JOIN dbo.SourceCode sc ON c.SourceCodeID = sc.SourceCodeID
                         LEFT JOIN dbo.Organization o ON r.ReferralCallerOrganizationID = o.OrganizationID
                         LEFT JOIN dbo.SourceCodeOrganization os ON o.OrganizationID = os.OrganizationID
                         WHERE c.CallDateTime > DATEADD(d,-90,GETUTCDATE())
                         AND  o.FacilityEreferralCode={facilityCode} AND sc.SourceCodeName={sourceCode} 
                         AND r.ReferralDonorRecNumber = {medicalRecord}")
                .SingleAsync()
                .ConfigureAwait(false);

        return ret.Value > 0;
    }

    public async Task<HospitalUnitAndFloor?> GetHospitalUnitAndFloor(string sourceCode, string facilityCode, string phone)
    {
        phone = phone.Replace("-", "").Replace(" ", "");

        return await referralDbContext.HospitalUnitAndFloor
                .FromSqlInterpolated(
                    $@"SELECT unit.SubLocationID as HospitalUnitId, 
                        unit.SubLocationName as HospitalUnitName, 
                        op.SubLocationLevel as [Floor]
                        FROM [dbo].Organization o
                        LEFT JOIN dbo.OrganizationPhone op ON o.OrganizationID = op.OrganizationID
                        LEFT JOIN dbo.SourceCodeOrganization os ON o.OrganizationID = os.OrganizationID
                        LEFT JOIN dbo.SourceCode sc ON sc.SourceCodeID = os.SourceCodeID
                        LEFT JOIN dbo.Phone p ON p.PhoneID = op.PhoneID
                        LEFT JOIN dbo.SubLocation unit ON unit.SubLocationID = op.SubLocationID
                        WHERE o.FacilityEreferralCode={facilityCode} AND sc.SourceCodeName={sourceCode} 
                        AND  p.PhoneAreaCode + p.PhonePrefix + p.PhoneNumber = {phone}")
                .FirstOrDefaultAsync()
                .ConfigureAwait(false);
    }

    public async Task<string?> SubmitEreferral(ReferralModel model)
    {
        // NOTE: For raw sql queries nulls are not converted to DBNull automatically.
        // This is why this is done explicitly in all the code below.

        SqlParameter identityUnknown = new SqlParameter("@IdentityUnknown", DBNull.Value);
        if (model.identityUnknown != null)
            identityUnknown.Value = Int32.Parse(model.identityUnknown);

        SqlParameter weightIsEstimate = new SqlParameter("@WeightIsEstimate", DBNull.Value);
        if (model.weightEstimated != null)
            weightIsEstimate.Value = Int32.Parse(model.weightEstimated);

        SqlParameter ageIsEstimate = new SqlParameter("@AgeIsEstimate", DBNull.Value);
        if (model.ageEstimated != null)
            ageIsEstimate.Value = Int32.Parse(model.ageEstimated);

        var output = new SqlParameter()
        {
            ParameterName = "@Ret",
            Value = model.sourceCodeId,
            Direction = ParameterDirection.Output,
            SqlDbType = SqlDbType.VarChar,
            Size = 20
        };

        await referralDbContext.Database.ExecuteSqlRawAsync(
                "dbo.InsertEreferral @CallDateTime, @SourceCodeID, @StatEmployeeID, " +
                "@TimeZoneId, @HeartbeatId, @HeartbeatName,  @CurrentlyOnVentilatorId, " +
                "@CurrentlyOnVentilatorName, @ExtubationDate, @ContactFirstName, @ContactLastName, " +
                "@ContactTitleId, @ContactTitleName, @CallbackPhoneNumber, @Extension, @ReferralFacilityId, " +
                "@ReferralFacilityName, @HospitalUnitId, @HospitalUnitName, @Floor, " +
                "@MedicalRecordNumber, @PatientFirstName, @PatientLastName, " +
                "@IdentityUnknown, @CardiacDeathDateTime, @AdmitDateTime, @DateOfBirth, " +
                "@Age, @AgeUnitId, @AgeUnitName,@AgeIsEstimate, @RaceId, @RaceName, " +
                "@GenderId, @GenderName, @Weight, @WeightUnitId, @WeightUnitName, " +
                "@WeightIsEstimate, @AdmittingDiagnosis, @PastMedicalHistory, @HivId," +
                "@HivName, @AidsId, @AidsName, @HepBId, @HepBName, @HepCId, @HepCName," +
                "@IvdaInLast5YearsId, @IvdaInLast5YearsName, @CauseOfDeathID, @Ret OUTPUT",
                new SqlParameter("@CallDateTime", model.callDateTime ?? dateTimeService.GetCurrent().UtcDateTime) { SqlDbType = SqlDbType.DateTime },
                new SqlParameter("@SourceCodeID", model.sourceCodeId),
                new SqlParameter("@StatEmployeeID", model.statEmployeeId),
                new SqlParameter("@TimeZoneId", model.timeZoneId),
                new SqlParameter("@HeartbeatId", model.heartbeatId),
                new SqlParameter("@HeartbeatName", value: "") { SqlDbType = SqlDbType.VarChar, Size = 20 },
                new SqlParameter("@CurrentlyOnVentilatorId", model.ventilatorId),
                new SqlParameter("@CurrentlyOnVentilatorName", (object)model.ventilatorName ?? DBNull.Value),
                new SqlParameter("@ExtubationDate", (object?)model.extubationDateTime ?? DBNull.Value),
                new SqlParameter("@ContactFirstName", model.contactFirstName),
                new SqlParameter("@ContactLastName", model.contactLastName),
                new SqlParameter("@ContactTitleId", (object?)model.contactTitleId ?? DBNull.Value),
                new SqlParameter("@ContactTitleName", value: "") { SqlDbType = SqlDbType.VarChar, Size = 50 },
                new SqlParameter("@CallbackPhoneNumber", model.callbackPhoneNumber),
                new SqlParameter("@Extension", (object)model.callbackPhoneNumberExtension ?? DBNull.Value) { SqlDbType = SqlDbType.VarChar, Size = 5 },
                new SqlParameter("@ReferralFacilityId", model.organizationId),
                new SqlParameter("@ReferralFacilityName", value: "") { SqlDbType = SqlDbType.VarChar, Size = 80 },
                new SqlParameter("@HospitalUnitId", (object?)model.hospitalUnitId ?? DBNull.Value),
                new SqlParameter("@HospitalUnitName", value: "") { SqlDbType = SqlDbType.VarChar, Size = 50 },
                new SqlParameter("@Floor", (object)model.floor ?? DBNull.Value) { SqlDbType = SqlDbType.VarChar, Size = 4 },
                new SqlParameter("@MedicalRecordNumber", (object)model.medicalRecordNumber ?? DBNull.Value),
                new SqlParameter("@PatientFirstName", (object)model.legalFirstName ?? DBNull.Value) { SqlDbType = SqlDbType.VarChar, Size = 40 },
                new SqlParameter("@PatientLastName", (object)model.legalLastName ?? DBNull.Value) { SqlDbType = SqlDbType.VarChar, Size = 40 },
                identityUnknown,
                new SqlParameter("@CardiacDeathDateTime", (object?)model.cardiacDeathDateTime ?? DBNull.Value),
                new SqlParameter("@AdmitDateTime", (object?)model.admitDateTime ?? DBNull.Value),
                new SqlParameter("@DateOfBirth", (object?)model.dob ?? DBNull.Value),
                new SqlParameter("@Age", (object?)model.age ?? DBNull.Value),
                new SqlParameter("@AgeUnitId", (object?)model.ageUnitId ?? DBNull.Value),
                new SqlParameter("@AgeUnitName", (object)model.ageUnitName ?? DBNull.Value) { SqlDbType = SqlDbType.VarChar, Size = 10 },
                ageIsEstimate,
                new SqlParameter("@RaceId", (object?)model.raceId ?? DBNull.Value),
                new SqlParameter("@RaceName", (object)model.raceName ?? DBNull.Value) { SqlDbType = SqlDbType.VarChar, Size = 50 },
                new SqlParameter("@GenderId", (object?)model.sexId ?? DBNull.Value),
                new SqlParameter("@GenderName", value: "") { SqlDbType = SqlDbType.VarChar, Size = 1 },
                new SqlParameter("@Weight", (object)model.weight ?? DBNull.Value),
                new SqlParameter("@WeightUnitId", (object?)model.weightUnitId ?? DBNull.Value),
                new SqlParameter("@WeightUnitName", (object)model.weightUnitName ?? DBNull.Value) { SqlDbType = SqlDbType.VarChar, Size = 50 },
                weightIsEstimate,
                new SqlParameter("@AdmittingDiagnosis", (object)model.admittingDiagnosis ?? DBNull.Value),
                new SqlParameter("@PastMedicalHistory", (object)model.medicalHistory ?? DBNull.Value),
                new SqlParameter("@HivId", model.hiv),
                new SqlParameter("@HivName", value: "") { SqlDbType = SqlDbType.VarChar, Size = 1 },
                new SqlParameter("@AidsId", model.aids),
                new SqlParameter("@AidsName", value: "") { SqlDbType = SqlDbType.VarChar, Size = 1 },
                new SqlParameter("@HepBId", model.hepB),
                new SqlParameter("@HepBName", value: "") { SqlDbType = SqlDbType.VarChar, Size = 1 },
                new SqlParameter("@HepCId", model.hepC),
                new SqlParameter("@HepCName", value: "") { SqlDbType = SqlDbType.VarChar, Size = 1 },
                new SqlParameter("@IvdaInLast5YearsId", model.ivda),
                new SqlParameter("@IvdaInLast5YearsName", value: "") { SqlDbType = SqlDbType.VarChar, Size = 1 },
                new SqlParameter("@CauseOfDeathID", (object?)model.causeOfDeathId ?? DBNull.Value),
               output).ConfigureAwait(false);

        return output.Value.ToString();
    }
}
