using Statline.Common.Services;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Enums;
using Statline.StatTrac.Domain.Organizations;
using Statline.StatTrac.Domain.Persons;
using Statline.StatTrac.Domain.Phones;
using Statline.StatTrac.Domain.Referrals.Factory.Criteria;
using Statline.StatTrac.Domain.Services;
using Statline.StatTrac.Domain.SourceCodes;
using Statline.StatTrac.Domain.SubLocations;
using Statline.StatTrac.Domain.TimeZones;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;

namespace Statline.StatTrac.Domain.Referrals.Factory;

public sealed class ReferralFactory
{
    private readonly IDateTimeService dateTimeService;
    private readonly IOrganizationRepository organizationRepository;
    private readonly IPersonRepository personRepository;
    private readonly IEnumRepository<Race> raceRepository;
    private readonly IEnumRepository<CauseOfDeath> causeOfDeathRepository;
    private readonly ISourceCodeRepository sourceCodeRepository;
    private readonly IPhoneRepository phoneRepository;
    private readonly ISubLocationRepository subLocationRepository;
    private readonly TimeZoneLookupService timeZoneLookupService;
    private readonly ICriteriaCalculator criteriaCalculator;

    public ReferralFactory(
        IDateTimeService dateTimeService,
        ITimeZoneRepository timeZoneRepository,
        IOrganizationRepository organizationRepository,
        IPersonRepository personRepository,
        IEnumRepository<Race> raceRepository,
        IEnumRepository<CauseOfDeath> causeOfDeathRepository,
        ISourceCodeRepository sourceCodeRepository,
        IPhoneRepository phoneRepository,
        ISubLocationRepository subLocationRepository,
        ICriteriaCalculator criteriaCalculator)
    {
        this.dateTimeService = Check.NotNull(dateTimeService);
        this.organizationRepository = Check.NotNull(organizationRepository);
        this.personRepository = Check.NotNull(personRepository);
        this.raceRepository = Check.NotNull(raceRepository);
        this.causeOfDeathRepository = Check.NotNull(causeOfDeathRepository);
        this.sourceCodeRepository = Check.NotNull(sourceCodeRepository);
        this.criteriaCalculator = Check.NotNull(criteriaCalculator);
        this.phoneRepository = Check.NotNull(phoneRepository);
        this.subLocationRepository = Check.NotNull(subLocationRepository);

        timeZoneLookupService = new TimeZoneLookupService(
            timeZoneRepository,
            organizationRepository);
    }

    public Referral CreateWithDefaultValues()
    {
        // Some of properties of referral are expected to have
        // default non-null values when values are not provided.
        // So unless client later explicitly assigns such property
        // with null it will have default value.
        return new Referral
        {
            #region Default Values
            #pragma warning disable format
            ReferralCallerPersonId         = DefaultValues.MinusOne,
            ReferralDonorRaceId            = DefaultValues.MinusOne,
            ReferralDonorCauseOfDeathId    = DefaultValues.MinusOne,
            ReferralTypeId                 = ReferralType.Unassigned,
            ReferralApproachTypeId         = ApproachType.Unassigned,
            ReferralOrganAppropriateId     = AppropriateType.Unassigned,
            ReferralOrganApproachId        = DefaultValues.MinusOne,
            ReferralOrganConsentId         = DefaultValues.MinusOne,
            ReferralOrganConversionId      = DefaultValues.MinusOne,
            ReferralBoneAppropriateId      = AppropriateType.Unassigned,
            ReferralBoneApproachId         = DefaultValues.MinusOne,
            ReferralBoneConsentId          = DefaultValues.MinusOne,
            ReferralBoneConversionId       = DefaultValues.MinusOne,
            ReferralTissueAppropriateId    = AppropriateType.Unassigned,
            ReferralTissueApproachId       = DefaultValues.MinusOne,
            ReferralTissueConsentId        = DefaultValues.MinusOne,
            ReferralTissueConversionId     = DefaultValues.MinusOne,
            ReferralSkinAppropriateId      = AppropriateType.Unassigned,
            ReferralSkinApproachId         = DefaultValues.MinusOne,
            ReferralSkinConsentId          = DefaultValues.MinusOne,
            ReferralSkinConversionId       = DefaultValues.MinusOne,
            ReferralEyesTransAppropriateId = AppropriateType.Unassigned,
            ReferralEyesTransApproachId    = DefaultValues.MinusOne,
            ReferralEyesTransConsentId     = DefaultValues.MinusOne,
            ReferralEyesTransConversionId  = DefaultValues.MinusOne,
            ReferralEyesRschAppropriateId  = AppropriateType.Unassigned,
            ReferralEyesRschApproachId     = DefaultValues.MinusOne,
            ReferralEyesRschConsentId      = DefaultValues.MinusOne,
            ReferralEyesRschConversionId   = DefaultValues.MinusOne,
            ReferralValvesAppropriateId    = AppropriateType.Unassigned,
            ReferralValvesApproachId       = DefaultValues.MinusOne,
            ReferralValvesConsentId        = DefaultValues.MinusOne,
            ReferralValvesConversionId     = DefaultValues.MinusOne,
            ReferralCallerLevelId          = DefaultValues.MinusOne,
            ReferralOrganDispositionId     = DefaultValues.MinusOne,
            ReferralBoneDispositionId      = DefaultValues.MinusOne,
            ReferralTissueDispositionId    = DefaultValues.MinusOne,
            ReferralSkinDispositionId      = DefaultValues.MinusOne,
            ReferralValvesDispositionId    = DefaultValues.MinusOne,
            ReferralEyesDispositionId      = DefaultValues.MinusOne,
            ReferralRschDispositionId      = DefaultValues.MinusOne,
            ReferralAllTissueDispositionId = DefaultValues.MinusOne,
            ReferralPronouncingMd          = DefaultValues.MinusOne,
            ReferralGeneralConsent         = DefaultValues.MinusOne,
            ReferralDoa                    = DefaultValues.Zero,
            ReferralQaReviewComplete       = DefaultValues.Zero,
            DonorRegistryType              = DefaultValues.Zero,
            DonorRegId                     = DefaultValues.Zero,
            DonorDmvId                     = DefaultValues.Zero,
            DonorIntentDone                = DefaultValues.Zero,
            DonorFaxSent                   = DefaultValues.Zero,
            DonorDsnId                     = DefaultValues.Zero,
            ReferralDonorHeartBeat         = DefaultValues.MinusOne,
            ReferralCoronerOrgId           = DefaultValues.MinusOne,
            CurrentReferralTypeId          = ReferralType.Unassigned,
            ReferralDobIlb                 = DefaultValues.Zero,
            ReferralPendingCase            = DefaultValues.Zero,
            ReferralApproachedByPersonId   = DefaultValues.Zero,
            ReferralNokId                  = DefaultValues.Zero,
            ReferralAttendingMd            = DefaultValues.MinusOne,
            #pragma warning restore format
            #endregion Default Values
        };
    }

    public async Task<Referral> CreateFromReferralInfoAsync(
        ReferralInfo newReferralInfo,
        int onBehalfOfEmployeeId)
    {
        Check.NotNull(newReferralInfo);

        await CheckEmployeeExists(onBehalfOfEmployeeId);

        var rawReferralInfo = await BuildReferralInfoRawAsync(newReferralInfo);

        var referral = CreateFromRawReferralInfo(rawReferralInfo, onBehalfOfEmployeeId);

        return referral;
    }

    public Referral CreateFromRawReferralInfo(
        RawReferralInfo referralInfo,
        int onBehalfOfEmployeeId)
    {
        Check.NotNull(referralInfo);

        var donorInfo = referralInfo.DonorInformation;
        var donorPerson = donorInfo.DonorPerson;
        var callerInfo = referralInfo.CallInformation.CallerInformation;

        string? timeZoneAbbreviation = callerInfo.HospitalOrganization.TimeZoneAbbreviation;
        string ianaTimeZoneId = callerInfo.HospitalOrganization.IanaTimeZoneId;
        
        var referral = CreateWithDefaultValues();

        #pragma warning disable format
        referral.ReferralDonorFirstName      = donorPerson.Name?.FirstName;
        referral.ReferralDonorLastName       = donorPerson.Name?.LastName;
        referral.ReferralDonorName           = donorPerson.Name?.ToString();
        referral.ReferralDob                 = donorPerson.DateOfBirth;
        referral.ReferralDonorGender         = donorPerson.Gender switch 
        { 
            PersonGender.Female => "F",
            PersonGender.Male => "M",
            _ => null
        };
        referral.ReferralDonorWeight                = donorPerson.Weight?.ToKilograms().Value;
        referral.ReferralDonorRecNumber             = donorInfo.MedicalRecordNumber;
        referral.ReferralDonorRecNumberSearchable   = RemoveMrnInvalidChars(donorInfo.MedicalRecordNumber);
        referral.ReferralDonorRaceId                = donorPerson.RaceId;

        var donorInfoAdmittedOn = donorInfo.AdmittedOn?.ConvertToTimeZone(ianaTimeZoneId);

        referral.ReferralDonorAdmitDate             = donorInfoAdmittedOn?.ToDateOnly();
        referral.ReferralDonorAdmitTime             = donorInfoAdmittedOn?.ToTimeWithTimeZoneString(timeZoneAbbreviation);

        var donorInfoCardiacTimeOfDeath = donorInfo.CardiacTimeOfDeath?.ConvertToTimeZone(ianaTimeZoneId);

        referral.ReferralDonorDeathDate             = donorInfoCardiacTimeOfDeath?.ToDateOnly();
        referral.ReferralDonorDeathTime             = donorInfoCardiacTimeOfDeath?.ToTimeWithTimeZoneString(timeZoneAbbreviation);
        
        referral.ReferralDonorHeartBeat             = (int)donorInfo.Heartbeat;
        referral.ReferralDonorOnVentilator          = donorInfo.Ventilator.ToString();
        referral.ReferralDonorCauseOfDeathId        = donorInfo.CauseOfDeathId;
        referral.ReferralDonorAge                   = donorPerson.Age?.Value;
        referral.ReferralDonorAgeUnit               = donorPerson.Age?.Unit.ToString();
       
        referral.Hiv    = donorInfo.HighRisk.Hiv;
        referral.HepB   = donorInfo.HighRisk.HepB;
        referral.HepC   = donorInfo.HighRisk.HepC;
        
        referral.ReferralCallerExtension        = callerInfo.Extension?.Value;
        referral.ReferralCallerPersonId         = callerInfo.PersonId;
        referral.ReferralCallerPhoneId          = callerInfo.PhoneId;
        referral.ReferralCallerSubLocationId    = callerInfo.SubLocationId;
        referral.ReferralCallerSubLocationLevel = callerInfo.SubLocationLevel;
        referral.ReferralCallerOrganizationId   = callerInfo.HospitalOrganization.Id;

        referral.ReferralExtubated = donorInfo.ExtubationAt;
        referral.ReferralNotesCase = donorInfo.MedicalHistory;

        var criteria = referralInfo.Criteria;

        referral.ReferralOrganAppropriateId         = criteria.OrganAppropriateId;
        referral.ReferralBoneAppropriateId          = criteria.BoneAppropriateId;
        referral.ReferralTissueAppropriateId        = criteria.SoftTissueAppropriateId;
        referral.ReferralSkinAppropriateId          = criteria.SkinAppropriateId;
        referral.ReferralValvesAppropriateId        = criteria.ValvesAppropriateId;
        referral.ReferralEyesTransAppropriateId     = criteria.EyesAppropriateId;
        referral.ReferralEyesRschAppropriateId      = criteria.OtherAppropriateId;
        referral.ReferralTypeId                     = criteria.PreviousReferralTypeId;
        referral.CurrentReferralTypeId              = criteria.CurrentReferralTypeId;

        referral.LastModified       = dateTimeService.GetCurrent();
        referral.LastStatEmployeeId = onBehalfOfEmployeeId;
        #pragma warning restore format

        return referral;

        // TODO: Do we need to call this from duplicates check as well?
        // This was ported from StatTrac.
        static string? RemoveMrnInvalidChars(string? mrnString)
        {
            if (mrnString is not null)
            {
                mrnString = Regex.Replace(mrnString, "[^A-Za-z0-9]", "");
            }

            return mrnString;
        }
    }

    private PersonAge CalculateAgeFromDateOfBirth(
        DateOnly dateOfBirth,
        DateTimeOffset? dateOfDeath)
    {
        // TODO: Here we're mixing basically donor death
        // date converted to UTC without accounting time,
        // and date without time and time zone.
        // So strictly saying it's not correct to compare such dates.
        // To mitigate this, the code should be refactored to use single
        // DateTimeOffset value for each of such property pairs. Two values
        // of DateTimeOffset can be easily and correctly compared even if they
        // have different time zones.
        var now = 
            dateOfDeath?.ToUniversalTime().ToDateOnly() ?? 
            dateTimeService.GetCurrentDateUtc();

        if (dateOfBirth > now)
        {
            throw new InvalidInputDataException(
                $"Date of birth {dateOfBirth:O} is later than date " +
                $"of death or is in future.");
        }

        var personAgeCalculationService = new PersonAgeCalculationService(
            CultureInfo.InvariantCulture.Calendar);

        return personAgeCalculationService.CaculatePersonAge(dateOfBirth, now);
    }

    private async Task<RawReferralInfo> BuildReferralInfoRawAsync(ReferralInfo referralInfo)
    {
        var callInfo = await BuildRawCallInfoAsync(referralInfo.CallInformation);
        var donorInfo = await BuildRawDonorInfoAsync(referralInfo.DonorInformation);
        var criteria = await BuildReferralCriteriaAsync(callInfo, donorInfo);

        return new RawReferralInfo(callInfo, donorInfo, criteria);
    }

    private async Task<ReferralCriteria> BuildReferralCriteriaAsync(RawCallInfo callInfo, RawDonorInfo donorInfo)
    {
        var criteria = await criteriaCalculator.CalculateCriteriaAsync(
            new CriteriaCalculatorInputData(
                donorInfo.DonorPerson.Age,
                donorInfo.DonorPerson.Gender,
                donorInfo.DonorPerson.Weight,
                donorInfo.HighRisk,
                donorInfo.Heartbeat,
                donorInfo.Ventilator,
                callInfo.CallerInformation.HospitalOrganization.Id,
                callInfo.CallerInformation.SourceCodeId));

        return criteria;
    }

    private async Task<RawDonorInfo> BuildRawDonorInfoAsync(DonorInfo donorInfo)
    {
        var donorPersonInfoRaw = await BuildRawDonorPersonInfoAsync(donorInfo);

        if (donorInfo.CauseOfDeathId is not null)
        {
            await CheckCauseOfDeathExistsAsync(donorInfo.CauseOfDeathId.Value);
        }

        return new RawDonorInfo
        (
            donorPersonInfoRaw,
            donorInfo.CardiacTimeOfDeath,
            donorInfo.AdmittedOn,
            donorInfo.CauseOfDeathId,
            donorInfo.MedicalHistory,
            donorInfo.ExtubationAt,
            donorInfo.Heartbeat,
            donorInfo.Ventilator,
            donorInfo.MedicalRecordNumber,
            donorInfo.HighRisk
        );
    }

    private async Task<RawDonorPersonInfo> BuildRawDonorPersonInfoAsync(DonorInfo donorInfo)
    {
        var donorPersonInfo = donorInfo.DonorPerson;

        if (donorPersonInfo.RaceId is not null)
        {
            await CheckRaceExistsAsync(donorPersonInfo.RaceId.Value);
        }

        var donorAge = donorPersonInfo.Age;

        if (donorAge is null &&
            donorPersonInfo.DateOfBirth is not null)
        {
            donorAge = CalculateAgeFromDateOfBirth(
                donorPersonInfo.DateOfBirth.Value,
                donorInfo.CardiacTimeOfDeath);
        }

        return new RawDonorPersonInfo(
            donorPersonInfo.Name,
            donorPersonInfo.DateOfBirth,
            donorAge,
            donorPersonInfo.RaceId,
            donorPersonInfo.Gender,
            donorPersonInfo.Weight);
    }

    private async Task<RawCallInfo> BuildRawCallInfoAsync(CallInfo callInfo)
    {
        var callerInfo = await BuildRawCallerInfoAsync(callInfo.CallerInformation);

        return new RawCallInfo(callerInfo);
    }

    private async Task<RawCallerInfo> BuildRawCallerInfoAsync(CallerInfo callerInfo)
    {
        await organizationRepository.ValidateOrganizationIdAsync(
            callerInfo.HospitalOrganizationId);

        PhoneId callerPhoneId = await GetCallerPhoneIdAsync(
            callerInfo.HospitalOrganizationId,
            callerInfo.PhoneNumber);

        PersonId? callerPersonId = await personRepository.FindPersonIdByNameAsync(
            callerInfo.CallerName,
            callerInfo.HospitalOrganizationId);

        var subLocationLookupService = new SubLocationLookupService(subLocationRepository, phoneRepository);

        var subLocation = await subLocationLookupService.FindSubLocationByOrganizationPhoneAsync(
            callerInfo.HospitalOrganizationId,
            callerInfo.PhoneNumber);

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
        var hospitalTimeZone =
            await timeZoneLookupService.GetOrganizationTimeZoneAsync(callerInfo.HospitalOrganizationId);

        int callerSourceCodeId = await GetSourceCodeIdByNameAsync(callerInfo.SourceCode);

        return new RawCallerInfo(
            callerPhoneId,
            callerInfo.PhoneExtension,
            callerPersonId,
            subLocation?.Id,
            subLocation?.Level,
            callerSourceCodeId,
            new RawOrganizationInfo(
                callerInfo.HospitalOrganizationId,
                hospitalTimeZone.TimeZoneAbbreviation,
                hospitalTimeZone.IanaTimeZoneId));
    }

    private async Task<PhoneId> GetCallerPhoneIdAsync(
       OrganizationId organizationId,
       PhoneNumber phoneNumber)
    {
        var phoneIds = await phoneRepository.GetFilteredOrganizationPhoneIds(
            organizationId,
            new PhoneFilterCriteria { PhoneNumber = phoneNumber })
            .ToArrayAsync();

        return phoneIds.Length switch
        {
            0 => throw new InvalidInputDataException($"Phone number '{phoneNumber}' wasn't found."),

            // I don't think duplicate phones are really possible for same organization.
            _ => phoneIds.First()
        };
    }

    private async Task CheckCauseOfDeathExistsAsync(int causeOfDeathId)
    {
        var causeOfDeathExists = await causeOfDeathRepository.CauseOfDeathWithIdExistsAsync(causeOfDeathId);

        if (!causeOfDeathExists)
        {
            throw new InvalidInputDataException(
                $"Cause of death with id '{causeOfDeathId}' doesn't exist.");
        }
    }

    private async Task CheckRaceExistsAsync(int raceId)
    {
        var raceExists = await raceRepository.RaceWithIdExistsAsync(raceId);

        if (!raceExists)
        {
            throw new InvalidInputDataException(
                $"Race with id '{raceId}' doesn't exist.");
        }
    }

    private async Task CheckEmployeeExists(int employeeId)
    {
        var employeeExists = await personRepository.EmployeeWithIdExistsAsync(employeeId);

        if (!employeeExists)
        {
            throw new InvalidInputDataException($"Employee with id '{employeeId}' wasn't found.");
        }
    }

    private async Task<int> GetSourceCodeIdByNameAsync(string sourceCodeName)
    {
        int? callerSourceCodeId = await sourceCodeRepository.FindSourceCodeIdByNameAsync(
            sourceCodeName,
            SourceCodeType.Referral);

        return
            callerSourceCodeId ??
            throw new InvalidInputDataException($"Unknown source code '{sourceCodeName}' of Referral type.");
    }
}