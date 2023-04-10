using Statline.Common.Utilities;
using System;

namespace Stattrac.Services.Donor.Registry.Model
{
    public sealed class DonorPerson
    {
        public DonorPerson(
            DonorName name, 
            DonorAddress address, 
            DateTime? dateOfBirth, 
            string? sid, 
            string? ssn)
        {
            Check.NotNull(name, nameof(name));
            Check.NotNull(address, nameof(address));

            Name = name;
            Address = address;
            DateOfBirth = dateOfBirth;
            Sid = sid;
            Ssn = ssn;
        }

        public DonorName Name { get; }
        public DonorAddress Address { get; }
        public DateTime? DateOfBirth { get; }
        public string? Sid { get; }
        public string? Ssn { get; }

        public override string ToString()
        {
            return $"{Name}, {DateOfBirth}, {Address}";
        }
    }
}
