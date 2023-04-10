using Statline.Common.Utilities;
using System;

namespace Statline.StatTracUploader.Domain.Temporary
{
    /// <summary>
    /// This is a container/root entity, holding some
    /// system information and a reference to referral entity.
    /// </summary>
    public class ReferralUpload
    {
        public ReferralUpload(
            Referral referral,
            DateTimeOffset addedToSystemOn,
            string? sourceFileName)
            : this(addedToSystemOn, sourceFileName)
        {
            Referral = Check.NotNull(referral, nameof(referral));
        }

        // This is needed due to this bug: https://github.com/dotnet/efcore/issues/12078#issuecomment-391269584
        private ReferralUpload(
            DateTimeOffset addedToSystemOn,
            string? sourceFileName)
            
        {
            AddedToSystemOn = addedToSystemOn;
            SourceFileName = sourceFileName;
        }

        public Guid Id { get; private set; }
        public Referral Referral { get; private set; } = null!;
        public DateTimeOffset AddedToSystemOn { get; }
        public string? SourceFileName { get; }
        public ReferralProcessingStatus ProcessingStatus { get; set; } = ReferralProcessingStatus.Pending();
    }
}
