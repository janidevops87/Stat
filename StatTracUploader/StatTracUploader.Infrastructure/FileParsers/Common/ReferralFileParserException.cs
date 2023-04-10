using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.FileParsers.Common
{
    public class ReferralFileParserException : Exception
    {
        public ReferralFileParserException() { }
        public ReferralFileParserException(string message) : base(message) { }
        public ReferralFileParserException(string message, Exception inner) : base(message, inner) { }
    }
}
