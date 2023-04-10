using Statline.StatTracUploader.Domain.Common;
using System;

namespace Statline.StatTracUploader.Domain.Temporary
{
    public record ReferralDonorPerson
    {
        public PersonName? Name { get; private set; }
        public DateTimeOffset? DateOfBirth { get; }
        public PersonAge? Age { get; private set; }
        public string? Race { get; }
        public PersonGender? Gender { get; }
        public PersonWeight? Weight { get; }
        public string? MedicalRecordNumber { get; }

        public ReferralDonorPerson(
            PersonName? name,
            DateTimeOffset? dateOfBirth,
            PersonAge? age,
            string? race,
            PersonGender? gender,
            PersonWeight? weight,
            string? medicalRecordNumber)
              : this(
                dateOfBirth,
                race,
                gender,
                medicalRecordNumber)
        {
            Age = age;
            Name = name;
            Weight = weight;
        }

        // This is needed due to this bug: https://github.com/dotnet/efcore/issues/12078#issuecomment-391269584
        private ReferralDonorPerson(
            DateTimeOffset? dateOfBirth,
            string? race,
            PersonGender? gender,
            string? medicalRecordNumber)
        {
            DateOfBirth = dateOfBirth;
            Race = race;
            Gender = gender;
            MedicalRecordNumber = medicalRecordNumber;
        }
    }
}
