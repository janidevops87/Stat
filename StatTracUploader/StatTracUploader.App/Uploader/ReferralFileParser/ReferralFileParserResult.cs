using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using Statline.StatTracUploader.Domain.Temporary;

namespace Statline.StatTracUploader.App.Uploader.ReferralFileParser
{
    public record ReferralFileParserResult
    {
        public Referral? Referral { get; }
        public IReadOnlyList<Exception> Errors { get; }
        public bool IsOk => Errors.Count == 0;

        public ReferralFileParserResult(Referral? referral, IReadOnlyList<Exception> errors)
        {
            Check.NotNull(errors, nameof(errors));

            if (errors.Count == 0)
            {
                Referral = referral ?? throw new ArgumentNullException(nameof(referral));
            }
            else
            {
                Referral = referral;
            }

            Errors = errors;
        }

        public static ReferralFileParserResult Ok(Referral referral)
        {
            return new ReferralFileParserResult(referral, errors: Array.Empty<Exception>());
        }

        public static ReferralFileParserResult Failed(IReadOnlyList<Exception> errors)
        {
            return new ReferralFileParserResult(referral: null, errors);
        }
    }
}
