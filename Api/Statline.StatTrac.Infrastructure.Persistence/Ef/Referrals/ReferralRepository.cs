using Microsoft.EntityFrameworkCore;
using Statline.Common.Services;
using Statline.StatTrac.Domain.Referrals;
using Statline.StatTrac.Infrastructure.Persistence.Ef.Common;
using System.Globalization;
using System.Linq.Expressions;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Referrals;

public class ReferralRepository : IReferralRepository
{
    private readonly ReferralTransactionalDbContext referralDbContext;
    private readonly IWebReportGroupIdAccessor webReportGroupIdAccessor;
    private readonly IDateTimeService dateTimeService;

    public ReferralRepository(
        ReferralTransactionalDbContext referralDbContext,
        IWebReportGroupIdAccessor webReportGroupIdAccessor,
        IDateTimeService dateTimeService)
    {
        Check.NotNull(referralDbContext, nameof(referralDbContext));
        Check.NotNull(webReportGroupIdAccessor, nameof(webReportGroupIdAccessor));
        Check.NotNull(dateTimeService, nameof(dateTimeService));

        this.referralDbContext = referralDbContext;
        this.webReportGroupIdAccessor = webReportGroupIdAccessor;
        this.dateTimeService = dateTimeService;
    }

    public IAsyncEnumerable<ReferralId> GetDuplicateReferrals(
        DuplicateReferralsFilterCriteria filterCriteria)
    {
        Check.NotNull(filterCriteria, nameof(filterCriteria));

        return filterCriteria.FilterType switch
        {
            DuplicateReferralsFilterType.LastNameOrMedicalRecordNumber =>
                GetDuplicateReferralsByLastNameOrMrn(filterCriteria),
            DuplicateReferralsFilterType.MedicalRecordNumber =>
                GetDuplicateReferralsByMrn(filterCriteria),
            _ => throw new InvalidOperationException("Unknown filter type")
        };
    }

    private IAsyncEnumerable<ReferralId> GetDuplicateReferralsByLastNameOrMrn(
        DuplicateReferralsFilterCriteria filterCriteria)
    {
        var referralIds = referralDbContext.Set<ReferralWithIdOnly>()
            .FromSqlInterpolated($@"EXEC GetDuplicateReferral 
                    @ReferralDonorLastName={filterCriteria.ReferralDonorLastName}, 
                    @SourceCodeID={filterCriteria.SourceCodeId}, 
                    @TimeZone={filterCriteria.TimeZone}, 
                    @UserOrganizationID={filterCriteria.CallCoordinatorOrganizationId}, 
                    @MedicalRecordNumber={filterCriteria.MedicalRecordNumber},  
                    @ReferralCallerOrganizationID={filterCriteria.ReferralCallerOrganizationId}, 
                    @CardiacDateNull=0") // This parameter is not used in the sproc, so giving it default value.
            .TagWithCallerName()
            .AsNoTracking()
            .AsAsyncEnumerable()
            .Select(r => new ReferralId(r.ReferralId));

        return referralIds;
    }

    private IAsyncEnumerable<ReferralId> GetDuplicateReferralsByMrn(
        DuplicateReferralsFilterCriteria filterCriteria)
    {
        // Here are the conditions this should handle:
        //
        // ExistingReferral.MRN is NULL, NewReferral.MRN is NULL, Duplicate: No
        // ExistingReferral.MRN is 123,  NewReferral.MRN is NULL, Duplicate: No
        // ExistingReferral.MRN is NULL, NewReferral.MRN is 123,  Duplicate: No
        // ExistingReferral.MRN is 123,  NewReferral.MRN is 123,  Duplicate: Yes
        // ExistingReferral.MRN is 123,  NewReferral.MRN is 456,  Duplicate: No
        // 
        // Note: generated SQL simulates objects comparison, so
        // it will produce (NULL == NULL) == true. But according to the
        // table above, two NULL MRNs should NOT be treated as equal.
        // Using this check we're excluding such case.
        if (filterCriteria.MedicalRecordNumber is null)
        {
            return AsyncEnumerable.Empty<ReferralId>();
        }

        var oldestCallDate =
            dateTimeService.GetCurrent().Subtract(TimeSpan.FromDays(90));

        var query =
            from r in referralDbContext.Referrals.AsQueryable()
            join c in referralDbContext.Calls
            on r.CallId equals c.CallId
            where
                c.CallDateTime > oldestCallDate &&
                c.SourceCodeId == filterCriteria.SourceCodeId &&
                r.ReferralCallerOrganizationId == filterCriteria.ReferralCallerOrganizationId &&
                r.ReferralDonorRecNumber == filterCriteria.MedicalRecordNumber
            select new ReferralId(r.ReferralId);

        return query.TagWithCallerName().AsNoTracking().AsAsyncEnumerable();
    }

    public async Task<IEnumerable<ReferralId>> GetWithCallsInDateRangeAsync(
        DateTimeOffset from,
        DateTimeOffset to)
    {
        var webReportGroupId = webReportGroupIdAccessor.GetWebReportGroupId();

        var defaultTimeZone = referralDbContext.DefaultTimeZone;

        // Some date/time columns in the DB are stored
        // in Mountain Time zone, so we need to adjust to it.
        from = from.ConvertToTimeZone(defaultTimeZone);
        to = to.ConvertToTimeZone(defaultTimeZone);

        var referralIds = await referralDbContext.Set<ReferralWithIdOnly>()
                .FromSqlInterpolated($@"EXEC Api.ReferralList  
                        {webReportGroupId?.Value}, 
                        {from.DateTime}, 
                        {to.DateTime}")
                .TagWithCallerName()
                .AsNoTracking()
                .AsAsyncEnumerable()
                .Select(r => new ReferralId(r.ReferralId))
                .ToListAsync()
                .ConfigureAwait(false);

        return referralIds;
    }

    public async Task<IEnumerable<ReferralId>> GetUpdatedAsync(DateTimeOffset from, DateTimeOffset to)
    {
        var webReportGroupId = webReportGroupIdAccessor.GetWebReportGroupId();

        var defaultTimeZone = referralDbContext.DefaultTimeZone;

        // Some date/time columns in the DB are stored
        // in Mountain Time zone, so we need to adjust to it.
        from = from.ConvertToTimeZone(defaultTimeZone);
        to = to.ConvertToTimeZone(defaultTimeZone);

        var referralIds = await referralDbContext.Set<ReferralWithIdOnly>()
                .FromSqlInterpolated($@"EXEC Api.ReferralListByLastModified
                        {webReportGroupId?.Value}, 
                        {from.DateTime}, 
                        {to.DateTime}")
                .TagWithCallerName()
                .AsNoTracking()
                .AsAsyncEnumerable()
                .Select(r => new ReferralId(r.ReferralId))
                .ToListAsync()
                .ConfigureAwait(false);

        return referralIds;
    }

    public async Task<ReferralDetails?> GetDetailsByIdAsync(ReferralId referralId)
    {
        Check.NotNull(referralId, nameof(referralId));

        var webReportGroupId = webReportGroupIdAccessor.GetWebReportGroupId();

        var referral = await referralDbContext.ReferralDetails
               .FromSqlInterpolated($"EXEC Api.ReferralDetail {webReportGroupId.Value}, {referralId.Value}")
               .TagWithCallerName()
               .AsNoTracking()
               .AsAsyncEnumerable()
               .SingleOrDefaultAsync()
               .ConfigureAwait(false);

        if (referral == null)
        {
            return null;
        }

        var events = await referralDbContext.Set<Domain.Referrals.LogEvent>()
             .FromSqlInterpolated($"EXEC Api.ReferralEvents {webReportGroupId.Value}, {referralId.Value}")
             .TagWithCallerName()
             .AsNoTracking()
             .ToArrayAsync()
             .ConfigureAwait(false);

        referral.ReferralLogEvents.Add(events);

        var secondaryData = await referralDbContext.SecondaryData
             .FromSqlInterpolated($"EXEC Api.ReferralDetailSecondary {webReportGroupId.Value}, {referralId.Value}")
             .TagWithCallerName()
             .AsAsyncEnumerable()
             .SingleOrDefaultAsync()
             .ConfigureAwait(false);

        if (secondaryData != null)
        {
            ReferralMedicationOther[] antibiotics =
                await GetReferralMedicationOther(
                    referralId, ReferralMedicationType.Antibiotic).ConfigureAwait(false);

            ReferralMedicationOther[] steroids =
                await GetReferralMedicationOther(
                    referralId, ReferralMedicationType.Steroid).ConfigureAwait(false);

            ReferralMedication[] medications =
                await GetReferralMedication(referralId).ConfigureAwait(false);

            secondaryData.Antibiotics.Add(antibiotics);
            secondaryData.Steroids.Add(steroids);
            secondaryData.Medications.Add(medications.Select(m => m.Name));

            referral.SecondaryData = secondaryData;
        }


        return referral;
    }

    private async Task<ReferralMedication[]> GetReferralMedication(
       ReferralId referralId)
    {
        return await referralDbContext.Set<ReferralMedication>()
             .FromSqlInterpolated($"EXEC Api.ReferralDetailMedication {referralId.Value}")
             .TagWithCallerName()
             .ToArrayAsync()
             .ConfigureAwait(false);
    }

    private async Task<ReferralMedicationOther[]> GetReferralMedicationOther(
        ReferralId referralId,
        string medicationType)
    {
        return await referralDbContext.Set<ReferralMedicationOther>()
             .FromSqlInterpolated($"EXEC Api.ReferralDetailMedicationOther {referralId.Value}, {medicationType}")
             .TagWithCallerName()
             .ToArrayAsync()
             .ConfigureAwait(false);
    }

    public async Task AddReferralAsync(Referral referral)
    {
        Check.NotNull(referral, nameof(referral));

        var defaultTimeZone = referralDbContext.DefaultTimeZone;

        var createdReferralsList = await referralDbContext.Set<ReferralWithIdOnly>()
            .FromSqlInterpolated($@"EXEC ReferralInsert
				    @CallID = {referral.CallId},
				    @ReferralCallerPhoneID = {referral.ReferralCallerPhoneId},
				    @ReferralCallerExtension = {referral.ReferralCallerExtension},
				    @ReferralCallerOrganizationID = {referral.ReferralCallerOrganizationId},
				    @ReferralCallerSubLocationID = {referral.ReferralCallerSubLocationId},
				    @ReferralCallerSubLocationLevel = {referral.ReferralCallerSubLocationLevel},
				    @ReferralCallerPersonID = {referral.ReferralCallerPersonId},
				    @ReferralDonorName = {referral.ReferralDonorName},
				    @ReferralDonorRecNumber = {referral.ReferralDonorRecNumber},
                    @ReferralDonorRecNumberSearchable = {referral.ReferralDonorRecNumberSearchable},
				    @ReferralDonorAge = {referral.ReferralDonorAge?.ToString(CultureInfo.InvariantCulture)},
				    @ReferralDonorAgeUnit = {referral.ReferralDonorAgeUnit},
				    @ReferralDonorRaceID = {referral.ReferralDonorRaceId},
				    @ReferralDonorGender = {referral.ReferralDonorGender},
				    @ReferralDonorWeight = {referral.ReferralDonorWeight?.ToString("0.0", CultureInfo.InvariantCulture)},
				    @ReferralDonorAdmitDate = {referral.ReferralDonorAdmitDate?.ToDateTime(TimeOnly.MinValue)},
				    @ReferralDonorAdmitTime = {referral.ReferralDonorAdmitTime},
				    @ReferralDonorDeathDate = {referral.ReferralDonorDeathDate?.ToDateTime(TimeOnly.MinValue)},
				    @ReferralDonorDeathTime = {referral.ReferralDonorDeathTime},
				    @ReferralDonorLSADate = {referral.ReferralDonorLsaDate?.ToDateTime(TimeOnly.MinValue)},
				    @ReferralDonorLSATime = {referral.ReferralDonorLsaTime},
				    @ReferralDonorCauseOfDeathID = {referral.ReferralDonorCauseOfDeathId},
				    @ReferralDonorOnVentilator = {referral.ReferralDonorOnVentilator},
				    @ReferralDonorDead = {referral.ReferralDonorDead},
				    @ReferralTypeID = {referral.ReferralTypeId},
				    @ReferralApproachTypeID = {referral.ReferralApproachTypeId},
				    @ReferralApproachedByPersonID = {referral.ReferralApproachedByPersonId},
				    @ReferralApproachNOK = {referral.ReferralApproachNok},
				    @ReferralApproachRelation = {referral.ReferralApproachRelation},
				    @ReferralOrganAppropriateID = {referral.ReferralOrganAppropriateId},
				    @ReferralOrganApproachID = {referral.ReferralOrganApproachId},
				    @ReferralOrganConsentID = {referral.ReferralOrganConsentId},
				    @ReferralOrganConversionID = {referral.ReferralOrganConversionId},
				    @ReferralBoneAppropriateID = {referral.ReferralBoneAppropriateId},
				    @ReferralBoneApproachID = {referral.ReferralBoneApproachId},
				    @ReferralBoneConsentID = {referral.ReferralBoneConsentId},
				    @ReferralBoneConversionID = {referral.ReferralBoneConversionId},
				    @ReferralTissueAppropriateID = {referral.ReferralTissueAppropriateId},
				    @ReferralTissueApproachID = {referral.ReferralTissueApproachId},
				    @ReferralTissueConsentID = {referral.ReferralTissueConsentId},
				    @ReferralTissueConversionID = {referral.ReferralTissueConversionId},
				    @ReferralSkinAppropriateID = {referral.ReferralSkinAppropriateId},
				    @ReferralSkinApproachID = {referral.ReferralSkinApproachId},
				    @ReferralSkinConsentID = {referral.ReferralSkinConsentId},
				    @ReferralSkinConversionID = {referral.ReferralSkinConversionId},
				    @ReferralEyesTransAppropriateID = {referral.ReferralEyesTransAppropriateId},
				    @ReferralEyesTransApproachID = {referral.ReferralEyesTransApproachId},
				    @ReferralEyesTransConsentID = {referral.ReferralEyesTransConsentId},
				    @ReferralEyesTransConversionID = {referral.ReferralEyesTransConversionId},
				    @ReferralEyesRschAppropriateID = {referral.ReferralEyesRschAppropriateId},
				    @ReferralEyesRschApproachID = {referral.ReferralEyesRschApproachId},
				    @ReferralEyesRschConsentID = {referral.ReferralEyesRschConsentId},
				    @ReferralEyesRschConversionID = {referral.ReferralEyesRschConversionId},
				    @ReferralValvesAppropriateID = {referral.ReferralValvesAppropriateId},
				    @ReferralValvesApproachID = {referral.ReferralValvesApproachId},
				    @ReferralValvesConsentID = {referral.ReferralValvesConsentId},
				    @ReferralValvesConversionID = {referral.ReferralValvesConversionId},
				    @ReferralNotesCase = {referral.ReferralNotesCase},
				    @ReferralNotesPrevious = {referral.ReferralNotesPrevious},
				    @ReferralVerifiedOptions = {referral.ReferralVerifiedOptions},
				    @ReferralCoronersCase = {referral.ReferralCoronersCase},
				    @Inactive = {referral.Inactive},
				    @ReferralCallerLevelID = {referral.ReferralCallerLevelId},
				    @LastModified = {referral.LastModified?.ConvertToTimeZone(defaultTimeZone).DateTime},
				    @UnusedField1 = {referral.UnusedField1},
				    @ReferralDonorFirstName = {referral.ReferralDonorFirstName},
				    @ReferralDonorLastName = {referral.ReferralDonorLastName},
				    @ReferralOrganDispositionID = {referral.ReferralOrganDispositionId},
				    @ReferralBoneDispositionID = {referral.ReferralBoneDispositionId},
				    @ReferralTissueDispositionID = {referral.ReferralTissueDispositionId},
				    @ReferralSkinDispositionID = {referral.ReferralSkinDispositionId},
				    @ReferralValvesDispositionID = {referral.ReferralValvesDispositionId},
				    @ReferralEyesDispositionID = {referral.ReferralEyesDispositionId},
				    @ReferralRschDispositionID = {referral.ReferralRschDispositionId},
				    @ReferralAllTissueDispositionID = {referral.ReferralAllTissueDispositionId},
				    @ReferralPronouncingMD = {referral.ReferralPronouncingMd},
				    @UnusedField3 = {referral.UnusedField3},
				    @ReferralNOKPhone = {referral.ReferralNokPhone},
				    @ReferralAttendingMD = {referral.ReferralAttendingMd},
				    @ReferralGeneralConsent = {referral.ReferralGeneralConsent},
				    @ReferralNOKAddress = {referral.ReferralNokAddress},
				    @ReferralCoronerName = {referral.ReferralCoronerName},
				    @ReferralCoronerPhone = {referral.ReferralCoronerPhone},
				    @ReferralCoronerOrganization = {referral.ReferralCoronerOrganization},
				    @ReferralCoronerNote = {referral.ReferralCoronerNote},
				    @ReferralApproachTime = {referral.ReferralApproachTime},
				    @ReferralConsentTime = {referral.ReferralConsentTime},
				    @Unused = {referral.Unused?.ConvertToTimeZone(defaultTimeZone).DateTime},
				    @ReferralDOA = {referral.ReferralDoa},
				    @ReferralDOB = {referral.ReferralDob?.ToDateTime(TimeOnly.MinValue)},
				    @ReferralDonorSSN = {referral.ReferralDonorSsn},
				    @UpdatedFlag = {referral.UpdatedFlag},
				    @ReferralExtubated = {referral.ReferralExtubated?.ConvertToTimeZone(defaultTimeZone).ToString("MM/dd/yy HH:mm", CultureInfo.InvariantCulture)},
				    @DonorRegistryType = {referral.DonorRegistryType},
				    @DonorRegId = {referral.DonorRegId},
				    @DonorDMVId = {referral.DonorDmvId},
				    @DonorDMVTable = {referral.DonorDmvTable},
				    @DonorIntentDone = {referral.DonorIntentDone},
				    @DonorFaxSent = {referral.DonorFaxSent},
				    @DonorDSNID = {referral.DonorDsnId},
				    @ReferralDonorHeartBeat = {referral.ReferralDonorHeartBeat},
				    @ReferralCoronerOrgID = {referral.ReferralCoronerOrgId},
				    @CurrentReferralTypeId = {referral.CurrentReferralTypeId},
				    @ReferralDonorBrainDeathDate = {referral.ReferralDonorBrainDeathDate?.ToDateTime(TimeOnly.MinValue)},
				    @ReferralDonorBrainDeathTime = {referral.ReferralDonorBrainDeathTime},
				    @ReferralPronouncingMDPhone = {referral.ReferralPronouncingMdphone},
				    @ReferralAttendingMDPhone = {referral.ReferralAttendingMdphone},
				    @ReferralDOB_ILB = {referral.ReferralDobIlb},
				    @ReferralDonorSpecificCOD = {referral.ReferralDonorSpecificCod},
				    @ReferralDonorNameMI = {referral.ReferralDonorNameMi},
				    @ReferralNOKID = {referral.ReferralNokId},
				    @ReferralQAReviewComplete = {referral.ReferralQaReviewComplete},
				    @Hiv = {referral.Hiv},
				    @Aids = {referral.Aids},
				    @HepB = {referral.HepB},
				    @HepC = {referral.HepC},
				    @Ivda = {referral.Ivda},
				    @IdentityUnknown = {referral.IdentityUnknown},
				    @AgeEstimated = {referral.AgeEstimated},
				    @WeightEstimated = {referral.WeightEstimated},
				    @PastMedicalHistory = {referral.PastMedicalHistory},
				    @AdmittingDiagnosis = {referral.AdmittingDiagnosis},
				    @LastStatEmployeeID = {referral.LastStatEmployeeId},
				    @AuditLogTypeID = {referral.AuditLogTypeId},
				    @IsERferralCase = {referral.IsERferralCase}")
            .TagWithCallerName()
            .AsNoTracking()
            .ToArrayAsync()
            .ConfigureAwait(false);

        // This resembles how EF assigns ids to entities after insertion to a table.
        referral.ReferralId = createdReferralsList.Single().ReferralId;
    }

    public async Task<TResult?> FindReferralByIdAsync<TResult>(
        ReferralId id,
        Expression<Func<Referral, TResult>> selector) where TResult : notnull
    {
        Check.NotNull(id, nameof(id));
        Check.NotNull(selector, nameof(selector));

        return await referralDbContext.Referrals//.Include(call => call.CallType)
           .TagWithCallerName()
           .AsNoTracking()
           .Where(referral => referral.ReferralId == id.Value)
           .Select(selector)
           .SingleOrDefaultAsync()
           .ConfigureAwait(false);
    }
}
