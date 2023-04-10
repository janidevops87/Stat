using Statline.Registry.Api.Client;
using Stattrac.Services.Donor.Registry.Model;
using System;
using System.Globalization;

namespace Stattrac.Services.Donor.Registry.RegistryApi
{
    internal static class CommonConverter
    {
        public static int ParseId(string id) => int.Parse(id, CultureInfo.InvariantCulture);
        public static string IdToString(int id) => id.ToString(CultureInfo.InvariantCulture);

        public static DonorRegistryType RegistryNameToRegistryType(string registryName)
        {
            return registryName switch
            {
                RegistryNames.Dmv => DonorRegistryType.Dmv,
                RegistryNames.Web => DonorRegistryType.Web,
                RegistryNames.Dla => DonorRegistryType.Dla,
                _ => throw new ArgumentException(
                    $"Unknown registry registry name '{registryName}'",
                    nameof(registryName))
            };
        }


        public static string RegistryTypeToRegistryName(DonorRegistryType registryType)
        {
            return registryType switch
            {
                DonorRegistryType.Web => RegistryNames.Web,
                DonorRegistryType.Dmv => RegistryNames.Dmv,
                DonorRegistryType.Dla => RegistryNames.Dla,
                _ => throw new ArgumentException(
                    $"Unknown registry type '{registryType}'",
                    nameof(registryType))
            };
        }
    }
}
