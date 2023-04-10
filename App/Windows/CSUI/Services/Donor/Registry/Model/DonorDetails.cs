using Statline.Common.Utilities;
using System;

namespace Stattrac.Services.Donor.Registry.Model
{
    public class DonorDetails
    {
        /// <summary>
        /// The id of the donor record in the registry store.
        /// </summary>
        public int Id { get; }

        /// <summary>
        /// Contains either driver license or the same 
        /// as <see cref="Id"/>.
        /// </summary>
        // TODO: This property is confusing and should be 
        // refactored to some better structure to represent this
        // information.
        public string RegistryId { get; }

        /// <summary>
        /// The type of the underlying registry where the donor was found.
        /// </summary>
        public DonorRegistryType RegistryType { get; }
        public DonorPerson Person { get; }
        public bool OnRegistry { get; }
        public DateTime? FlagDate { get; }
        public string? Restriction { get; }

        public DonorDetails(
            int id,
            string registryId,
            DonorRegistryType registryType,
            DonorPerson person,
            bool onRegistry,
            DateTime? flagDate,
            string? restriction)
        {
            Check.BiggerOrEqual(id, 0, nameof(id));
            Check.NotEmpty(registryId, nameof(registryId));
            Check.NotNull(person, nameof(person));

            Id = id;
            RegistryId = registryId;
            RegistryType = registryType;
            Person = person;
            OnRegistry = onRegistry;
            FlagDate = flagDate;
            Restriction = restriction;
        }
    }
}