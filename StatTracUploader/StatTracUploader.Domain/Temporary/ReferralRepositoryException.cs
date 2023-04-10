using System;

namespace Statline.StatTracUploader.Domain.Temporary
{
    /// <summary>
    /// Represents expected errors from repository, e.g. data validation, conflicts etc.
    /// Does not include infrastructure and implementation-dependent errors.
    /// </summary>
    public class ReferralRepositoryException : Exception
    {
        public ReferralRepositoryException() { }
        public ReferralRepositoryException(string message) : base(message) { }
        public ReferralRepositoryException(string message, Exception inner) : base(message, inner) { }
    }
}
