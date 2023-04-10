using Statline.StatTrac.Domain.Referrals;

namespace Statline.StatTrac.App.HighLevel.Referrals.Dto.NewReferral;

public record class CreatedReferralInfo(
    ReferralId ReferalId, 
    int CallId,
    string? CallNumber);
