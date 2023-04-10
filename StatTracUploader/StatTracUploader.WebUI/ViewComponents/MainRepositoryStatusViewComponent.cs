using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Statline.Common.Utilities;
using Statline.StatTracUploader.App.Processor;
using Statline.StatTracUploader.WebUI.Common;
using System;

namespace Statline.StatTracUploader.WebUI.ViewComponents
{
    public class MainRepositoryStatusViewComponent : ViewComponent
    {
        private readonly IMainRepositoryStatusProvider mainRepositoryStatusProvider;
        private readonly IOptionsMonitor<ApplicationUIOptions> options;

        public MainRepositoryStatusViewComponent(
            IMainRepositoryStatusProvider mainRepositoryStatusProvider,
            IOptionsMonitor<ApplicationUIOptions> options)
        {
            Check.NotNull(mainRepositoryStatusProvider, nameof(mainRepositoryStatusProvider));
            Check.NotNull(options, nameof(options));
            this.mainRepositoryStatusProvider = mainRepositoryStatusProvider;
            this.options = options;
        }

        public IViewComponentResult Invoke()
        {
            var status = mainRepositoryStatusProvider.GetRepositoryStatus();
            
            var timeZone = options.CurrentValue.GetTimeZone();

            var statusViewModel = status with 
            {
                LastCheckAt = status.LastCheckAt.ConvertToTimeZone(timeZone),
                NextCheckAt = status.NextCheckAt.ConvertToTimeZone(timeZone),
            };

            return View(statusViewModel);
        }
    }
}
