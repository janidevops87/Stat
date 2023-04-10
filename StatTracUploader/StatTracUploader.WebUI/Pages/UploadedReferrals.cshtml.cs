using AutoMapper;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Statline.StatTracUploader.App.Uploader;
using Statline.StatTracUploader.Models;
using Statline.StatTracUploader.WebUI.Common;
using Statline.StatTracUploader.WebUI.Models;
using System.Collections.Generic;
using System.Linq;

namespace Statline.StatTracUploader.Pages
{
    public class UploadedReferralsModel : PageModel
    {
        private readonly IOptionsMonitor<ApplicationUIOptions> options;
        private readonly ILogger logger;
        private readonly ReferralUploaderApp referralUploaderApp;
        private readonly IMapper mapper;

        public UploadedReferralsModel(
            IOptionsMonitor<ApplicationUIOptions> options,
            ILogger<IndexModel> logger,
            ReferralUploaderApp referralUploaderApp,
            IMapper mapper)
        {
            this.options = options;
            this.logger = logger;
            this.referralUploaderApp = referralUploaderApp;
            this.mapper = mapper;
        }

        public IAsyncEnumerable<UploadedReferralModel> UploadedReferrals { get; private set; } = AsyncEnumerable.Empty<UploadedReferralModel>();

        public void OnGet()
        {
            var uploadedReferralInfos = referralUploaderApp.GetUploadedReferrals();

            var timeZone = options.CurrentValue.GetTimeZone();

            UploadedReferrals = uploadedReferralInfos.Select(
                info => mapper.Map<UploadedReferralModel>(info,
                opts => opts.Items.Add(ModelMappingProfile.TimeZoneInfoKey, timeZone)));
        }
    }
}
