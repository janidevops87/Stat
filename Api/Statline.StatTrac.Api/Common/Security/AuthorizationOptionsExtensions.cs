using Microsoft.AspNetCore.Authorization;

namespace Statline.StatTrac.Api.Common.Security;

internal static class AuthorizationOptionsExtensions
{
    public static void AddStatTracApiWithWebReportGroupIdPolicies(this AuthorizationOptions options)
    {
        options.AddPolicy(
            AuthorizationPolicies.StatTracApiWithWebReportGroupIdPolicy,
            policy => policy
                .RequireScope("statline.stattrac.api")
                .RequireClaim(ClaimTypes.WebReportGroupIdClaim));
    }

    public static void AddStatTracLowLevelApiPolicies(this AuthorizationOptions options)
    {
        // Only referral APIs need filtering by WebReportGroupId.
        // There is no point to require this claim for other APIs.
        options.AddPolicy(
            AuthorizationPolicies.StatTracLowLevelApiPolicy,
            policy => policy
                .RequireScope("statline.stattrac.api"));
    }

    public static void AddReferralProcessorApiPolicies(this AuthorizationOptions options)
    {
        options.AddPolicy(
            AuthorizationPolicies.ReferralProcessorApiPolicy,
            policy => policy.RequireScope("processor.statline.stattrac.api"));
    }

    public static void AddStatTracHighLevelApiPolicies(this AuthorizationOptions options)
    {
        options.AddPolicy(
            AuthorizationPolicies.StatTracApiReferralCreate,
            policy => policy
                .RequireScope("stattrac.api.referral.create")
                // TODO: This requirement will need to be replaced
                // with a more complex one once we add support for
                // non-service clients (with associated users).
                .RequireClaim(ClaimTypes.DefaultStatEmployeeIdClaim));

        options.AddPolicy(
            AuthorizationPolicies.StatTracApiReferralRead,
            policy => policy
                .RequireScope("stattrac.api.referral.read"));


        options.AddPolicy(
            AuthorizationPolicies.StatTracApiLogEventCreate,
            policy => policy
                .RequireScope("stattrac.api.logevent.create")
                // TODO: This requirement will need to be replaced
                // with a more complex one once we add support for
                // non-service clients (with associated users).
                .RequireClaim(ClaimTypes.DefaultStatEmployeeIdClaim));

        options.AddPolicy(
            AuthorizationPolicies.StatTracApiLogEventRead,
            policy => policy
                .RequireScope("stattrac.api.logevent.read"));

        options.AddPolicy(
            AuthorizationPolicies.StatTracApiPersonCreate,
            policy => policy
                .RequireScope("stattrac.api.person.create")
                // TODO: This requirement will need to be replaced
                // with a more complex one once we add support for
                // non-service clients (with associated users).
                .RequireClaim(ClaimTypes.DefaultStatEmployeeIdClaim));

        options.AddPolicy(
            AuthorizationPolicies.StatTracApiPersonRead,
            policy => policy
                .RequireScope("stattrac.api.person.read"));

        options.AddPolicy(
            AuthorizationPolicies.StatTracApiPhoneCreate,
            policy => policy
                .RequireScope("stattrac.api.phone.create")
                // TODO: This requirement will need to be replaced
                // with a more complex one once we add support for
                // non-service clients (with associated users).
                .RequireClaim(ClaimTypes.DefaultStatEmployeeIdClaim));

        options.AddPolicy(
            AuthorizationPolicies.StatTracApiPhoneRead,
            policy => policy
                .RequireScope("stattrac.api.phone.read"));
    }
}
