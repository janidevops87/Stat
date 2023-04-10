using System;

namespace Statline.StatTracUploader.Domain.Temporary
{
    public record PagingInformation
    {
        public PagingInformation(
            bool? pagedToClient,
            DateTimeOffset? pagedToClientOn,
            DateTimeOffset? rePagedToClientOn,
            string? receivedBy,
            string? pagedBy,
            bool? referralPagedToHospital)
        {
            PagedToClient = pagedToClient;
            PagedToClientOn = pagedToClientOn;
            RePagedToClientOn = rePagedToClientOn;
            ReceivedBy = receivedBy;
            PagedBy = pagedBy;
            ReferralPagedToHospital = referralPagedToHospital;
        }

        public bool? PagedToClient { get; }
        public DateTimeOffset? PagedToClientOn { get; }
        public DateTimeOffset? RePagedToClientOn { get; }
        public string? ReceivedBy { get; }
        public string? PagedBy { get; }
        public bool? ReferralPagedToHospital { get; }
    }
}
