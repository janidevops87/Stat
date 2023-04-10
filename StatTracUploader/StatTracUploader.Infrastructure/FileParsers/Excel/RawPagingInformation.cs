using System;

namespace Statline.StatTracUploader.Infrastructure.FileParsers.Excel
{
    internal record RawPagingInformation(
        bool? PagedToClient,
        DateTimeOffset? PagedToClientOn,
        DateTimeOffset? RePagedToClientOn,
        string? ReceivedBy,
        string? PagedBy,
        bool? ReferralPagedToHospital);
}
