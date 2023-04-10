using Statline.StatTracUploader.Domain.Main.Persons;

namespace Statline.StatTracUploader.App.Processor
{
    internal record ReferralExtraInfo(
        int CallerSourceCodeId,
        int? CallerPersonId,
        int CallerPhoneId,
        StatEmployee CoordinatorEmployee,
        int OrganizationId,
        string? OrganizationName,
        int? ReferralFacilityUnitId,
        string? ReferralFacilityFloor,
        int? CauseOfDeathId,
        int? DonorRaceId);
}