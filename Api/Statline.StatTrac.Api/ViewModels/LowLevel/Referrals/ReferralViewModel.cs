namespace Statline.StatTrac.Api.ViewModels.LowLevel.Referrals;

public class ReferralViewModel
{
    public int Id { get; set; }
    public int? CallId { get; set; }
    public string? DonorFirstName { get; set; }
    public string? DonorLastName { get; set; }
    public DateTimeOffset? ExtubatedAt { get; set; }
}
