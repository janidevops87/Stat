using System;

namespace Statline.StatTracUploader.Infrastructure.FileParsers.Excel
{
    internal record RawReferralDonorPerson(
        string? FirstName,
        string? LastName,
        DateTimeOffset? DateOfBirth,
        int? Age,
        string? AgeUnit,
        string? Race,
        string? Gender,
        float? Weight,
        string? MedicalRecordNumber);
}
