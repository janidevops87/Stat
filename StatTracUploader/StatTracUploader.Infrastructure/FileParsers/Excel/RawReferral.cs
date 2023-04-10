using System;

namespace Statline.StatTracUploader.Infrastructure.FileParsers.Excel
{
    internal record RawReferral
    (
        RawCallerInformation CallerInformation,
        RawReferralDonorPerson DonorPerson,
        RawPagingInformation PagingInformation,

        bool IsUpdate,
        string CallerSourceCode,
        DateTimeOffset CallReceivedOn,
        string CoordinatorFirstName,
        string CoordinatorLastName,
        bool Heartbeat,
        string Vent,
        DateTimeOffset? ExtubationAt,
        DateTime? DeclaredCardiacTimeOfDeath,
        DateTime? AdmittedOn,
        string? CauseOfDeath,
        string? MedicalHistory,
        int? ReferralNumer,
        DateTimeOffset? EnteredOn
    );
}