using Statline.StatTracUploader.Domain.Main.Referrals;
using Statline.StatTracUploader.Domain.Temporary;
using System.Globalization;

namespace Statline.StatTracUploader.App.Processor
{
    internal static class ReferralConversionExtensions
    {
        public static Domain.Main.Referrals.Referral ToMainReferral(
            this Domain.Temporary.Referral tempReferral,
            ReferralExtraInfo referralExtraInfo)
        {
            var donorPerson = tempReferral.DonorPerson;
            var callerInfo = tempReferral.CallerInformation;

            return new Domain.Main.Referrals.Referral
            {
                DonorFirstName = donorPerson.Name?.FirstName,
                DonorLastName = donorPerson.Name?.LastName,
                Dob = donorPerson.DateOfBirth,
                DonorAge = donorPerson.Age?.Value,
                DonorAgeUnit = donorPerson.Age?.Unit.ToString(),
                DonorRaceId = referralExtraInfo.DonorRaceId,
                DonorGender = donorPerson.Gender == PersonGender.Female ? "F" : "M",
                DonorWeight = donorPerson.Weight?.ToKilograms().Value,
                DonorRecNumber = donorPerson.MedicalRecordNumber,
                DonorAdmitDateTime = tempReferral.AdmittedOn,
                DonorDeathDateTime = tempReferral.DeclaredCardiacTimeOfDeath,
                DonorCauseOfDeathId = referralExtraInfo.CauseOfDeathId,
                DonorHeartBeat = tempReferral.Heartbeat ? HeartbeatId.Yes : HeartbeatId.No,
                DonorOnVentilator = tempReferral.Vent.ToString(),

                CallerPersonId = referralExtraInfo.CallerPersonId,
                CallerPhoneId = referralExtraInfo.CallerPhoneId,
                CallerExtension = callerInfo.Extension?.Value,
                CallerSubLocationId = referralExtraInfo.ReferralFacilityUnitId,
                CallerSubLocationLevel = referralExtraInfo.ReferralFacilityFloor,
                CallerOrganizationId = referralExtraInfo.OrganizationId,

                ExtubatedAt = tempReferral.ExtubationAt,

                NotesCase = tempReferral.MedicalHistory,

                // tempReferral.EnteredOn - ignore
            };
           
        }
    }
}
