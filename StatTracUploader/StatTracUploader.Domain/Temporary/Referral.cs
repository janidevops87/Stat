using Statline.StatTracUploader.Domain.Common;
using System;

namespace Statline.StatTracUploader.Domain.Temporary
{
    public class Referral
    {
        public int? Id { get; set; }

        // ReferralNumber contains call ID too.
        // The reason to have this property is that it
        // always has call ID after a referral upload is
        // processed, and thus can always be used to identify
        // the call. ReferralNumber, on the other hand,
        // is non-empty only for referral updates, and basically
        // stores the state of corresponding referral upload field.
        public int? CallId { get; set; }

        public bool IsUpdate { get; init; } = false;

        public string CallerSourceCode { get; set; }
        public DateTimeOffset CallReceivedOn { get; set; }
        public PersonName CoordinatorName { get; set; }

        public CallerInformation CallerInformation { get; set; }


        public bool Heartbeat { get; set; }
        public VentilatorType Vent { get; set; }
        public DateTimeOffset? ExtubationAt { get; set; }

        public ReferralDonorPerson DonorPerson { get; set; }

        public DateTime? DeclaredCardiacTimeOfDeath { get; set; }
        public DateTime? AdmittedOn { get; set; }

        public string? CauseOfDeath { get; set; }
        public string? MedicalHistory { get; set; }

        public PagingInformation? PagingInformation { get; set; }

        public int? ReferralNumer { get; set; }
        public DateTimeOffset? EnteredOn { get; set; }
    }
}