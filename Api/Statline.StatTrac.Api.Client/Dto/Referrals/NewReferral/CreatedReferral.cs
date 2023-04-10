namespace Statline.StatTrac.Api.Client.Dto.Referrals.NewReferral;

public record class CreatedReferral(
    int ReferalId,
    int CallId,
    string? CallNumber);
