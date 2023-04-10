using System.Threading.Tasks;

namespace Statline.StatTracUploader.App.Uploader.ReferralFileParser
{
    public interface IReferralFileParser
    {
        Task<ReferralFileParserResult> ParseAsync(InputReferralInfo inputReferralInfo);
    }
}