using Microsoft.AspNetCore.Identity;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using System;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.IdentityServer.Common.Security
{
    public static class UserManagerExtensions
    {
        public static async Task<int> GetWebReportGroupIdAsync(
            this UserManager<User> userManager,
            User user)
        {
            Check.NotNull(userManager, nameof(userManager));
            Check.NotNull(user, nameof(user));

            string value = (await userManager.GetWebReportGroupIdClaimAsync(user))?.Value;

            if (value == null)
            {
                return default;
            }

            return Convert.ToInt32(value);
        }

        public static async Task SetWebReportGroupIdAsync(
            this UserManager<User> userManager,
            User user,
            int webReportGroupId)
        {
            Check.NotNull(userManager, nameof(userManager));
            Check.NotNull(user, nameof(user));

            // We have to query the claim first since 
            // ReplaceClaimAsync looks up by type AND by value
            // (probably because generally there can be many claims
            // of same type).
            var oldClaim = await userManager.GetWebReportGroupIdClaimAsync(user);

            var newClaim = new System.Security.Claims.Claim(
                StatlineClaimTypes.WebReportGroupIdClaim,
                webReportGroupId.ToString(CultureInfo.InvariantCulture));

            await userManager.ReplaceClaimAsync(user, oldClaim, newClaim);
        }

        private static async Task<System.Security.Claims.Claim> GetWebReportGroupIdClaimAsync(
            this UserManager<User> userManager,
            User user)
        {
            var claims = await userManager.GetClaimsAsync(user);

            return claims.FirstOrDefault(
                c => c.Type == StatlineClaimTypes.WebReportGroupIdClaim);
        }
    }
}
