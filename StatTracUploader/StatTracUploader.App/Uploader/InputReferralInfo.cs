using Statline.Common.Utilities;
using System.IO;

namespace Statline.StatTracUploader.App.Uploader
{
    public class InputReferralInfo
    {
        public InputReferralInfo(
            IStreamReference referralFileData,
            string? fileName)
        {
            Check.NotNull(referralFileData, nameof(referralFileData));

            Data = referralFileData;
            FileName = fileName;
        }

        public IStreamReference Data { get; }
        public string? FileName { get; }
    }
}