using AutoMapper;
using Statline.Common.Services;
using Statline.StatTrac.App.LowLevel.Referrals.Mapping;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Referrals;
using Statline.StatTrac.Domain.TimeZones;
using System.Globalization;

namespace Statline.StatTrac.App.LowLevel.Referrals;

public class ReferralsApplication
{
    private readonly IReferralRepository referralRepository;
    private readonly ITimeZoneRepository timeZoneRepository;
    private readonly IOrganizationRepository organizationRepository;
    private readonly IMapper mapper;
    private readonly IDateTimeService dateTimeService;

    public ReferralsApplication(
        IReferralRepository referralRepository,
        ITimeZoneRepository timeZoneRepository,
        IOrganizationRepository organizationRepository,
        IMapper mapper,
        IDateTimeService dateTimeService)
    {
        this.referralRepository = Check.NotNull(referralRepository, nameof(referralRepository));
        this.mapper = Check.NotNull(mapper, nameof(mapper));
        this.dateTimeService = Check.NotNull(dateTimeService, nameof(dateTimeService));
        this.timeZoneRepository = Check.NotNull(timeZoneRepository, nameof(timeZoneRepository));
        this.organizationRepository = Check.NotNull(organizationRepository, nameof(organizationRepository)); ;
    }

    public async Task<IEnumerable<ReferralId>> GetReferralsWithCallsInDateRangeAsync(
        DateTimeOffset from,
        DateTimeOffset to)
    {
        return await referralRepository.GetWithCallsInDateRangeAsync(from, to);
    }

    public async Task<ReferralDetails?> GetReferralDetailsByIdAsync(
        ReferralId referralId)
    {
        Check.NotNull(referralId, nameof(referralId));

        return await referralRepository.GetDetailsByIdAsync(referralId);
    }

    // TODO: Review if we still need this functionality.
    public async Task<IEnumerable<ReferralId>> GetUpdatedReferralsAsync(DateTimeOffset sinceTime)
    {
        return await referralRepository.GetUpdatedAsync(sinceTime, dateTimeService.GetCurrent());
    }

    public async Task<IEnumerable<ReferralId>> GetUpdatedReferralsAsync(DateTimeOffset from, DateTimeOffset to)
    {
        return await referralRepository.GetUpdatedAsync(from, to);
    }

    public IAsyncEnumerable<ReferralId> GetDuplicateReferrals(
        DuplicateReferralsFilterCriteria filterCriteria)
    {
        Check.NotNull(filterCriteria, nameof(filterCriteria));
        return referralRepository.GetDuplicateReferrals(filterCriteria);
    }

    public async Task<ReferralId> AddReferralAsync(NewReferralInfo newReferralInfo)
    {
        Check.NotNull(newReferralInfo, nameof(newReferralInfo));
        return await AddNewReferral(newReferralInfo);
    }

    private async Task<ReferralId> AddNewReferral(NewReferralInfo newReferralInfo)
    {
        // Some referral properties contain date/time in
        // organization time zone, and they don't provide the time zone offset.
        // More, referral DB historically stores date and time separately,
        // with time being represented as string with time zone abbreviation at the end,
        // e.g. "14:00 MT". So here we lookup time zone for the given organization
        // and convert incoming DateTime instances to the described format.
        //
        // TODO: It would be nice if eventually these properties would be converted
        // to regular DateTime (or better DateTimeOffset) type (with corresponding data migration).
        // This wouldn't lead to any information loosing as we always can query time zone
        // information.
        var timeZoneAbbreviation = await GetCallerOrganizationTimeZoneAbbreviation(newReferralInfo);

        var referral = mapper.Map<Referral>(newReferralInfo,
            opts => opts.Items.Add(
                ReferralMappingProfile.TimeZoneAbbreviationKey, timeZoneAbbreviation));

        CalculateAgeFromDateOfBirth(referral);

        ApplyNewReferralDefaultValues(referral);

        referral.LastModified = dateTimeService.GetCurrent();

        await referralRepository.AddReferralAsync(referral);

        return new ReferralId(referral.ReferralId);
    }

    private void CalculateAgeFromDateOfBirth(Referral referral)
    {
        if (referral.ReferralDob is null ||
            referral.ReferralDonorAge is not null)
        {
            return;
        }

        // TODO: Here we're mixing basically donor death
        // date converted to UTC without accounting time,
        // and date without time and time zone.
        // So strictly saying it's not correct to compare such dates.
        // TO mitigate this, the code should be refactored to use one single
        // DateTimeOffset value for each of such property pairs. Two values
        // of DateTimeOffset can be easily and correctly compared even if they
        // have different time zones.
        var now =
            referral.ReferralDonorDeathDate ??
            dateTimeService.GetCurrentDateUtc();

        var dob = referral.ReferralDob.Value;

        if (dob > now)
        {
            // TODO: Should this be and error?
            return;
        }

        var personAgeCalculationService = new PersonAgeCalculationService(
            CultureInfo.InvariantCulture.Calendar);

        var (age, unit) = personAgeCalculationService.CaculatePersonAge(dob, now);

        referral.ReferralDonorAge = age;
        referral.ReferralDonorAgeUnit = unit.ToString();
    }


    // TODO: Use Referrl.CreteWIthDefultValues() instead. But need to
    // tweak the mapper to not overwrite these with nulls.
    private static void ApplyNewReferralDefaultValues(Referral referral)
    {
        // Some of properties of referral are expected to have
        // default non-null values when values are not provided.
        // So unless client explicitly assigns such property with null
        // it will have default value.
        
        #pragma warning disable format

        referral.ReferralCallerPersonId         ??= DefaultValues.MinusOne;
        referral.ReferralDonorRaceId            ??= DefaultValues.MinusOne;
        referral.ReferralDonorCauseOfDeathId    ??= DefaultValues.MinusOne;
        referral.ReferralTypeId                 ??= ReferralType.Unassigned;
        referral.ReferralApproachTypeId         ??= ApproachType.Unassigned;
        referral.ReferralOrganAppropriateId     ??= AppropriateType.Unassigned;
        referral.ReferralOrganApproachId        ??= DefaultValues.MinusOne;
        referral.ReferralOrganConsentId         ??= DefaultValues.MinusOne;
        referral.ReferralOrganConversionId      ??= DefaultValues.MinusOne;
        referral.ReferralBoneAppropriateId      ??= AppropriateType.Unassigned;
        referral.ReferralBoneApproachId         ??= DefaultValues.MinusOne;
        referral.ReferralBoneConsentId          ??= DefaultValues.MinusOne;
        referral.ReferralBoneConversionId       ??= DefaultValues.MinusOne;
        referral.ReferralTissueAppropriateId    ??= AppropriateType.Unassigned;
        referral.ReferralTissueApproachId       ??= DefaultValues.MinusOne;
        referral.ReferralTissueConsentId        ??= DefaultValues.MinusOne;
        referral.ReferralTissueConversionId     ??= DefaultValues.MinusOne;
        referral.ReferralSkinAppropriateId      ??= AppropriateType.Unassigned;
        referral.ReferralSkinApproachId         ??= DefaultValues.MinusOne;
        referral.ReferralSkinConsentId          ??= DefaultValues.MinusOne;
        referral.ReferralSkinConversionId       ??= DefaultValues.MinusOne;
        referral.ReferralEyesTransAppropriateId ??= AppropriateType.Unassigned;
        referral.ReferralEyesTransApproachId    ??= DefaultValues.MinusOne;
        referral.ReferralEyesTransConsentId     ??= DefaultValues.MinusOne;
        referral.ReferralEyesTransConversionId  ??= DefaultValues.MinusOne;
        referral.ReferralEyesRschAppropriateId  ??= AppropriateType.Unassigned;
        referral.ReferralEyesRschApproachId     ??= DefaultValues.MinusOne;
        referral.ReferralEyesRschConsentId      ??= DefaultValues.MinusOne;
        referral.ReferralEyesRschConversionId   ??= DefaultValues.MinusOne;
        referral.ReferralValvesAppropriateId    ??= AppropriateType.Unassigned;
        referral.ReferralValvesApproachId       ??= DefaultValues.MinusOne;
        referral.ReferralValvesConsentId        ??= DefaultValues.MinusOne;
        referral.ReferralValvesConversionId     ??= DefaultValues.MinusOne;
        referral.ReferralCallerLevelId          ??= DefaultValues.MinusOne;
        referral.ReferralOrganDispositionId     ??= DefaultValues.MinusOne;
        referral.ReferralBoneDispositionId      ??= DefaultValues.MinusOne;
        referral.ReferralTissueDispositionId    ??= DefaultValues.MinusOne;
        referral.ReferralSkinDispositionId      ??= DefaultValues.MinusOne;
        referral.ReferralValvesDispositionId    ??= DefaultValues.MinusOne;
        referral.ReferralEyesDispositionId      ??= DefaultValues.MinusOne;
        referral.ReferralRschDispositionId      ??= DefaultValues.MinusOne;
        referral.ReferralAllTissueDispositionId ??= DefaultValues.MinusOne;
        referral.ReferralPronouncingMd          ??= DefaultValues.MinusOne;
        referral.ReferralGeneralConsent         ??= DefaultValues.MinusOne;
        referral.ReferralDoa                    ??= DefaultValues.Zero;
        referral.DonorRegistryType              ??= DefaultValues.Zero;
        referral.DonorRegId                     ??= DefaultValues.Zero;
        referral.DonorDmvId                     ??= DefaultValues.Zero;
        referral.DonorIntentDone                ??= DefaultValues.Zero;
        referral.DonorFaxSent                   ??= DefaultValues.Zero;
        referral.DonorDsnId                     ??= DefaultValues.Zero;
        referral.ReferralDonorHeartBeat         ??= DefaultValues.MinusOne;
        referral.ReferralCoronerOrgId           ??= DefaultValues.MinusOne;
        referral.CurrentReferralTypeId          ??= ReferralType.Unassigned;
        referral.ReferralDobIlb                 ??= DefaultValues.Zero;
        referral.ReferralPendingCase            ??= DefaultValues.Zero;
        referral.ReferralApproachedByPersonId   ??= DefaultValues.Zero;
        referral.ReferralNokId                  ??= DefaultValues.Zero;
        referral.ReferralAttendingMd            ??= DefaultValues.MinusOne;
        #pragma warning restore format
    }

    private async Task<string?> GetCallerOrganizationTimeZoneAbbreviation(
        NewReferralInfo newReferralInfo)
    {
        if (newReferralInfo.CallerOrganizationId is null)
        {
            return null;
        }

        var organizationWithTimeZoneInfo = await organizationRepository.FindOrganizationByIdAsync(
            new(newReferralInfo.CallerOrganizationId.Value),
            org => new { org.TimeZoneId });

        if (organizationWithTimeZoneInfo is null)
        {
            // TODO: Should be reported to client (e.g. "bad request").
            throw new InvalidOperationException(
                $"New referral for call id '{newReferralInfo.CallId}' references " +
                $"non-existing organization with id '{newReferralInfo.CallerOrganizationId}'.");
        }

        if (organizationWithTimeZoneInfo.TimeZoneId is null)
        {
            return null;
        }

        var timeZoneInfo = await timeZoneRepository.FindTimeZoneAsync(
            organizationWithTimeZoneInfo.TimeZoneId.Value,
            tz => new { tz.TimeZoneAbbreviation });

        if (timeZoneInfo is null)
        {
            // This is an internal error due to invalid
            // reference of time zone in the organization.
            throw new InvalidOperationException(
                $"Organization with id '{newReferralInfo.CallerOrganizationId}' " +
                $"references non-existing time zone " +
                $"with id '{organizationWithTimeZoneInfo.TimeZoneId}'.");
        }

        return timeZoneInfo.TimeZoneAbbreviation;
    }

    public async Task<ReferralInfo?> FindReferralByIdAsync(ReferralId referralId)
    {
        return await referralRepository.FindReferralByIdAsync(referralId,
            // Use mapper if most of fields are returned.
            // Manual mapping results in returning only needed fields
            // from DB.
            referral => new ReferralInfo
            {
                Id = referral.ReferralId,
                CallId = referral.CallId,
                DonorFirstName = referral.ReferralDonorFirstName,
                DonorLastName = referral.ReferralDonorLastName,
                ExtubatedAt = referral.ReferralExtubated
            });
    }
}
