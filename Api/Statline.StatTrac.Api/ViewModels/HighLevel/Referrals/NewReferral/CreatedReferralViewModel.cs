namespace Statline.StatTrac.Api.ViewModels.HighLevel.Referrals.NewReferral;

public record CreatedReferralViewModel(
    int ReferalId,
    int CallId,
    string? CallNumber);
