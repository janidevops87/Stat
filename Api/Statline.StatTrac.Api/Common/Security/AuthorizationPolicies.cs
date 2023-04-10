namespace Statline.StatTrac.Api.Common.Security;

public static class AuthorizationPolicies
{
    public const string ReferralProcessorApiPolicy = "ReferralProcessorApiPolicy";
    public const string StatTracLowLevelApiPolicy = "StatTracLowLevelApiPolicy";
    public const string StatTracApiWithWebReportGroupIdPolicy = "StatTracApiWithWebReportGroupIdPolicy";

    public const string StatTracApiReferralCreate = "StatTracApiReferralCreatePolicy";
    public const string StatTracApiReferralRead = "StatTracApiReferralReadPolicy";

    public const string StatTracApiLogEventCreate = "StatTracApiLogEventCreatePolicy";
    public const string StatTracApiLogEventRead = "StatTracApiLogEventReadPolicy";

    public const string StatTracApiPersonCreate = "StatTracApiPersonCreatePolicy";
    public const string StatTracApiPersonRead = "StatTracApiPersonReadPolicy";

    public const string StatTracApiPhoneCreate = "StatTracApiPhoneCreatePolicy";
    public const string StatTracApiPhoneRead = "StatTracApiPhoneReadPolicy";
}
