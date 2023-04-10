using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Models
{
    public record UploadReferralResultModel(
        string FileName,
        IReadOnlyList<string> Errors)
    {
        public bool IsOk => Errors?.Count == 0;

        public static UploadReferralResultModel Ok(string fileName)
        {
            return new UploadReferralResultModel(fileName, Errors: Array.Empty<string>());
        }

        public static UploadReferralResultModel Failed(string fileName, IReadOnlyList<string> errors)
        {
            return new UploadReferralResultModel(fileName, errors);
        }
    }
}
