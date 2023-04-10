using IdentityServer4.Models;
using Microsoft.AspNetCore.Mvc.Rendering;
using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace Statline.IdentityServer.Features.IdentityServerConfig.Client.ViewModels
{
    public class EditGrantTypesViewModel
    {
        // would allow response_type downgrade attack from code to token
        private static readonly (string value1, string value2)[] invalidCombinations =
        {
            (GrantType.Implicit, GrantType.AuthorizationCode),
            (GrantType.Implicit, GrantType.Hybrid),
            (GrantType.AuthorizationCode, GrantType.Hybrid)
        };

        // TODO: Add string length and allowed values validation 
        // if concerned.
        [Display(Name = "Allowed Grant Types")]
        [CustomValidation(typeof(EditGrantTypesViewModel), nameof(ValidateGrantTypes))]
        public List<string> AllowedGrantTypes { get; set; } = new List<string>();

        public IEnumerable<SelectListItem> AllGrantTypes { get; } = new[]
        {
            new SelectListItem { Value = GrantType.Implicit, Text = "Implicit" },
            new SelectListItem { Value = GrantType.Hybrid, Text = "Hybrid" },
            new SelectListItem { Value = GrantType.AuthorizationCode, Text = "Authorization Code"    },
            new SelectListItem { Value = GrantType.ClientCredentials, Text = "Client Credentials" },
            new SelectListItem { Value = GrantType.ResourceOwnerPassword, Text = "Resource Owner Password"  }
         };

        public static ValidationResult ValidateGrantTypes(
            IEnumerable<string> grantTypes,
            ValidationContext context)
        {
            Check.NotNull(grantTypes, nameof(grantTypes));

            // Grab the model instance
            var viewModel = (EditGrantTypesViewModel)context.ObjectInstance;

            if (!viewModel.HasInvalidCombinations(out var result))
            {
                return result;
            }

            return ValidationResult.Success;
        }

        private bool HasInvalidCombinations(out ValidationResult result)
        {
            foreach (var invalidCombination in invalidCombinations)
            {
                if (ContainsGrantTypeCombination(invalidCombination, AllowedGrantTypes))
                {
                    var message = BuildErrorMessage(invalidCombination);
                    result = new ValidationResult(message);
                    return false;
                }
            }

            result = ValidationResult.Success;
            return true;
        }

        private string BuildErrorMessage((string value1, string value2) invalidCombination)
        {
            var value1Name =
                GetGrantTypeDisplayName(invalidCombination.value1);

            var value2Name =
                GetGrantTypeDisplayName(invalidCombination.value2);

            return $"Combination of grant types {value1Name} and {value2Name} is invalid.";
        }

        private string GetGrantTypeDisplayName(string grantType)
        {
            var listItem = AllGrantTypes.FirstOrDefault(
                x => x.Value.Equals(grantType, StringComparison.OrdinalIgnoreCase));

            return listItem?.Text;
        }

        private static bool ContainsGrantTypeCombination(
            (string value1, string value2) invalidCombination,
            IEnumerable<string> grantTypes) =>
                grantTypes.Contains(invalidCombination.value1, StringComparer.Ordinal) &&
                grantTypes.Contains(invalidCombination.value2, StringComparer.Ordinal);
    }
}
