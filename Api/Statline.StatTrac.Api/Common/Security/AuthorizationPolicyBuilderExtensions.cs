namespace Microsoft.AspNetCore.Authorization;

/// <summary>
/// Extensions for creating scope related authorization policies
/// </summary>
public static class AuthorizationPolicyBuilderExtensions
{
    /// <summary>
    /// Adds a policy to check for required scopes.
    /// </summary>
    /// <param name="builder"></param>
    /// <param name="scope">List of any required scopes. The token must contain at least one of the listed scopes.</param>
    /// <returns></returns>
    public static AuthorizationPolicyBuilder RequireScope(this AuthorizationPolicyBuilder builder, params string[] scope)
    {
        return builder.RequireClaim("scope", scope);
    }
}
