namespace Statline.StatTracUploader.Infrastructure.Persistence.StatTracApi
{
    internal record ReferralExtraInfo(
        int CallerSourceCodeId,
        bool CallerExists,
        int CoordinatorNameEmloyeeId,
        int OrganizationId,
        int? ReferralFacilityUnitId,
        string? ReferralFacilityFloor,
        int? CauseOfDeathId,
        int? DonorRaceId);
}
