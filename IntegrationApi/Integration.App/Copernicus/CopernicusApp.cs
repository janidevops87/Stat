using Statline.StatTrac.Api.Client.Dto.Referrals.Common;
using Statline.StatTrac.Api.Client.Dto.Referrals.NewReferral;
using Statline.StatTrac.Api.Client.Dto.LogEvents.NewLogEvent;
using Statline.StatTrac.Api.Client.Dto.LogEvents.Common;
using Statline.StatTrac.Api.Client.Dto.Common;
using Statline.StatTrac.Api.Client;
using Statline.Common.Services;
using Statline.StatTrac.Integration.App.Common;
using Statline.StatTrac.Api.Client.Dto.Persons.NewPerson;
using Statline.StatTrac.Api.Client.Dto.Phones.NewPhone;
using Statline.StatTrac.Api.Client.Dto.Phones.Common;
using Microsoft.Extensions.Logging;

namespace Statline.StatTrac.Integration.App.Copernicus;

public class CopernicusApp
{
    private readonly IStatTracApiClient statTracApiClient;
    private readonly IDateTimeService dateTimeService;
    private readonly ILogger logger;

    public CopernicusApp(
        IStatTracApiClient statTracApiClient,
        IDateTimeService dateTimeService,
        ILogger<CopernicusApp> logger)
    {
        this.statTracApiClient = statTracApiClient;
        this.dateTimeService = dateTimeService;
        this.logger = logger;
    }

    public async Task<int> AddReferralAsync(
        NewReferralInfo referralInfo)
    {
        await EnsureCallerPersonExistsAsync(referralInfo);
        await EnsureCallerPhoneExistsAsync(referralInfo);

        var newReferral = BuildNewReferral(referralInfo);

        logger.LogAddingNewReferral(referralInfo);

        var createdReferral = await statTracApiClient.AddReferralAsync(newReferral);

        logger.LogAddedNewReferral(referralInfo, createdReferral);

        var newLogEvent = BuildNewReferralLogEvent(referralInfo);

        logger.LogAddingNewNoteLogEvent(createdReferral);

        int createdLogEventId = await statTracApiClient.AddReferralLogEventAsync(createdReferral.ReferalId, newLogEvent);

        logger.LogAddedNewNoteLogEvent(createdReferral, createdLogEventId);

        return createdReferral.CallId;
    }

    private async Task EnsureCallerPhoneExistsAsync(NewReferralInfo referralInfo)
    {
        logger.LogCheckingPhoneNumberExists(referralInfo);

        if (!await statTracApiClient.OrganizationPhoneExistsAsync(
           referralInfo.ReferralFacility,
           referralInfo.CallbackPhoneNumber))
        {
            logger.LogAddingPhoneNumber(referralInfo);

            await statTracApiClient.AddOrganizationPhoneAsync(
                referralInfo.ReferralFacility,
                new OrganizationPhone(
                    referralInfo.CallbackPhoneNumber,
                    PhoneType.Work,
                    new HospitalSubLocation
                    {
                        Name = referralInfo.HospitalUnitId,
                        Level = null // Not provided
                    }));
        }
    }

    private async Task EnsureCallerPersonExistsAsync(NewReferralInfo referralInfo)
    {
        var personName = new PersonName
        {
            FirstName = referralInfo.ContactFirstName,
            LastName = referralInfo.ContactLastName
        };

        logger.LogCheckingCallerPersonExists(referralInfo);

        if (!await statTracApiClient.AnyOrganizationPersonWithNameExistsAsync(
            referralInfo.ReferralFacility,
            personName))
        {
            logger.LogAddingCallerPerson(referralInfo);

            await statTracApiClient.AddOrganizationPersonAsync(
                referralInfo.ReferralFacility,
                new Person(personName));
        }
    }

    private static ReferralLogEvent BuildNewReferralLogEvent(
        NewReferralInfo referralInfo)
    {
        return new ReferralLogEvent(
            type: LogEventType.Note,
            callbackPending: false,
            fromToPersonName: null,
            organizationId: null, // Use from referral.
            description: FormatLogEventDescription(referralInfo));
    }

    private static string FormatLogEventDescription(NewReferralInfo referralInfo)
    {
        return
            $"• Past Medical History: {referralInfo.MedicalHistory}" + Environment.NewLine +
            $"• Hospital Unit: {referralInfo.HospitalUnitId}";
    }

    private Referral BuildNewReferral(NewReferralInfo referralInfo)
    {
        return new Referral(
            new Call(
                new Caller(
                    phoneNumber: referralInfo.CallbackPhoneNumber,
                    phoneExtension: referralInfo.CallbackPhoneNumberExtension,
                    hospitalOrganizationId: referralInfo.ReferralFacility,
                    sourceCode: referralInfo.Sourcecode,
                    callerName: new PersonName
                    {
                        FirstName = referralInfo.ContactFirstName,
                        LastName = referralInfo.ContactLastName
                    }),
                    callReceivedOn: dateTimeService.GetCurrent(),
                    coordinatorName: null),
            new Donor(
                new DonorPerson
                {
                    Name = new PersonName
                    {
                        FirstName = referralInfo.LegalFirstName,
                        LastName = referralInfo.LegalLastName
                    },
                    DateOfBirth = referralInfo.Dob,
                    Age = GetPersonAge(referralInfo),
                    Gender = referralInfo.SexId switch
                    {
                        PersonGender.M => Api.Client.Dto.Referrals.Common.PersonGender.Male,
                        PersonGender.F => Api.Client.Dto.Referrals.Common.PersonGender.Female,
                        _ => null,
                    },
                    RaceId = referralInfo.RaceId,
                    Weight = GetPersonWeight(referralInfo)
                },
                medicalRecordNumber: referralInfo.MedicalRecordNumber,
                cardiacTimeOfDeath: referralInfo.CardiacDeathDateTime,
                admittedOn: referralInfo.AdmitDateTime,
                causeOfDeathId: referralInfo.CauseOfDeathId,
                medicalHistory: null,
                extubationAt: referralInfo.ExtubationDateTime,
                heartbeat: referralInfo.HeartbeatId,
                ventilator: referralInfo.VentilatorId,
                highRisk: new DonorHighRisk(
                    hiv: MapHighRiskValue(referralInfo.Hiv),
                    hepB: MapHighRiskValue(referralInfo.HepB),
                    hepC: MapHighRiskValue(referralInfo.HepC))));

        static Api.Client.Dto.Referrals.Common.DonorHighRiskValue MapHighRiskValue(
            DonorHighRiskValue? highRiskValue) => highRiskValue switch
            {
                DonorHighRiskValue.Yes => Api.Client.Dto.Referrals.Common.DonorHighRiskValue.Yes,
                DonorHighRiskValue.No => Api.Client.Dto.Referrals.Common.DonorHighRiskValue.No,
                _ => Api.Client.Dto.Referrals.Common.DonorHighRiskValue.Unknown
            };
    }

    private static PersonWeight? GetPersonWeight(NewReferralInfo referralInfo)
    {
        if (referralInfo.Weight is null)
        {
            return null;
        }

        if (referralInfo.WeightUnitId is null)
        {
            // This is an internal error (not visible to user) as
            // upper level code should guard against this case.
            throw new InvalidOperationException("Weight Unit is not specified while Weight is specified.");
        }

        return new PersonWeight(
            referralInfo.Weight.Value,
            (Api.Client.Dto.Referrals.Common.WeightUnit)referralInfo.WeightUnitId.Value);
    }

    private static PersonAge? GetPersonAge(NewReferralInfo referralInfo)
    {
        if (referralInfo.Age is null)
        {
            return null;
        }

        if (referralInfo.AgeUnitId is null)
        {
            // This is an internal error (not visible to user) as
            // upper level code should guard against this case.
            throw new InvalidOperationException("Age Unit is not specified while Age is specified.");
        }

        return new PersonAge(referralInfo.Age.Value, referralInfo.AgeUnitId.Value);
    }
}
