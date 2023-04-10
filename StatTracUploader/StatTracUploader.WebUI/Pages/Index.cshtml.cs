using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using Statline.StatTracUploader.App.Uploader;
using Statline.StatTracUploader.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger logger;
        private readonly ReferralUploaderApp referralUploaderApp;

        public IndexModel(
            ILogger<IndexModel> logger,
            ReferralUploaderApp referralUploaderApp)
        {
            this.logger = logger;
            this.referralUploaderApp = referralUploaderApp;
        }

        public void OnGet()
        {

        }

        public IReadOnlyList<UploadReferralResultModel> UploadResults { get; set; } = Array.Empty<UploadReferralResultModel>();

        [BindProperty]
        public IEnumerable<IFormFile> UploadedFiles { get; set; } = Enumerable.Empty<IFormFile>();

        public async Task OnPostAsync()
        {
            if (!UploadedFiles.Any())
            {
                ModelState.AddModelError(nameof(UploadedFiles), "No files selected");
                return;
            }

            var uploadResults = new List<UploadReferralResultModel>();

            foreach (var file in UploadedFiles)
            {
                logger.LogInformation("Processing uploaded file '{FileName}'", file.FileName);

                var result = await referralUploaderApp.UploadReferralAsync(
                    new InputReferralInfo(
                        new GenericStreamReference(() => file.OpenReadStream()),
                        file.FileName));


                if (result.IsOk)
                {
                    logger.LogInformation("Successfully processed uploaded file '{FileName}'", file.FileName);
                    uploadResults.Add(UploadReferralResultModel.Ok(file.FileName));
                }
                else
                {
                    logger.LogInformation("Failed to process uploaded file '{FileName}'", file.FileName);
                    uploadResults.Add(UploadReferralResultModel.Failed(
                            file.FileName,
                            result.Errors.Select(ex => ex.Message).ToArray()));
                }
            }

            UploadResults = uploadResults;
        }
    }
}
