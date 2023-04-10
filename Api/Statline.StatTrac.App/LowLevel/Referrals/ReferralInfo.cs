namespace Statline.StatTrac.App.LowLevel.Referrals;

public class ReferralInfo
{
    // Add more properties if needed.
    public int Id { get; set; }
    public int? CallId { get; set; }
    public string? DonorFirstName { get; set; }
    public string? DonorLastName { get; set; }
    public DateTimeOffset? ExtubatedAt { get; set; }
}
