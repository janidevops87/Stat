namespace Registry.Common.Constants
{
    public static class Routes
    {
        //In a code review, Bret said this file may not be needed at all because routes are inbound and we are making outbound calls.
        public const string RouteEnrollment = "enrollment";
        public const string RouteRemoval = "removal";
        public const string RouteEnrollmentSignature = "enrollment/signature";
        public const string RouteRemovalSignature = "removal/signature";
    }
}
