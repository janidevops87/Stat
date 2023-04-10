using System;
using System.Collections.Generic;

namespace Statline.StatTracUploader.App.Uploader
{
    public record UploadReferralResult(IReadOnlyList<Exception> Errors)
    {
        public bool IsOk => Errors?.Count == 0;
    }
}
