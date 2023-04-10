using Statline.Common.Utilities;
using System;

namespace Stattrac.Services.Donor.Registry.Model
{
    public sealed class DonorSearchResult
    {
        public DonorSearchResult(
            int id, 
            DonorRegistryInfo registryInfo, 
            DonorPerson person, 
            string? verificationForm, 
            DateTime? donorDate, 
            string? donorDateType, 
            bool onRegistry, 
            bool donorConfirmed)
        {
            Check.BiggerOrEqual(id, 0, nameof(id));
            Check.NotNull(registryInfo, nameof(registryInfo));
            Check.NotNull(person, nameof(person));
            
            Registry = registryInfo;
            Id = id;
            Person = person;
            VerificationForm = verificationForm;
            DonorDate = donorDate;
            DonorDateType = donorDateType;
            OnRegistry = onRegistry;
            DonorConfirmed = donorConfirmed;
        }

        public int Id { get; }
        public DonorRegistryInfo Registry { get; }
        public DonorPerson Person { get; }
        public string? VerificationForm { get; }
        public DateTime? DonorDate { get; }
        public string? DonorDateType { get; }
        public bool OnRegistry { get; }
        public bool DonorConfirmed { get; }

        public override string ToString()
        {
            return
                $"Registry: {{{Registry}}}, Person: {{{Person}}}, DonorDate: {DonorDate}";
        }
    }
}
