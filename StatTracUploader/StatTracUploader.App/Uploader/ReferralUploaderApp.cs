using Statline.Common.Services;
using Statline.Common.Utilities;
using Statline.StatTracUploader.App.Uploader.ReferralFileParser;
using Statline.StatTracUploader.Domain.Temporary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.App.Uploader
{
    public class ReferralUploaderApp
    {
        private readonly IReferralFileParser referralFileParser;
        private readonly IReferralUploadRepository tempReferralRepository;
        private readonly IDateTimeService dateTimeService;

        public ReferralUploaderApp(
            IReferralFileParser referralFileParser,
            IReferralUploadRepository tempReferralRepository,
            IDateTimeService dateTimeService)
        {
            this.referralFileParser = Check.NotNull(referralFileParser, nameof(referralFileParser));
            this.tempReferralRepository = Check.NotNull(tempReferralRepository, nameof(tempReferralRepository));
            this.dateTimeService = Check.NotNull(dateTimeService, nameof(dateTimeService));
        }

        public async Task<UploadReferralResult> UploadReferralAsync(InputReferralInfo referralFileInfo)
        {
            // TODO: Consider adding handling for possible exception
            // which are not converted to parse result errors.
            var result = await referralFileParser.ParseAsync(referralFileInfo);

            if (result.IsOk)
            {
                var referralUpload = new ReferralUpload(
                    result.Referral!,
                    addedToSystemOn:
                    dateTimeService.GetCurrent(),
                    referralFileInfo.FileName);

                tempReferralRepository.AddReferralUpload(referralUpload);

                await tempReferralRepository.SaveChangesAsync();
            }

            // This contains only errors the user
            // can possibly work around.
            return new UploadReferralResult(result.Errors);
        }

        public IAsyncEnumerable<UploadedReferralInfo> GetUploadedReferrals()
        {
            DateTimeOffset addedSince = dateTimeService.GetCurrent() - TimeSpan.FromHours(24);

            var referrals = tempReferralRepository.QueryReferralUploads(r =>
                    r.AddedToSystemOn >= addedSince ||
                    r.ProcessingStatus.Status == ProcessingStatus.Pending);

            return referrals.Select(r => r.ToUploadedReferralInfo());
        }
    }
}
