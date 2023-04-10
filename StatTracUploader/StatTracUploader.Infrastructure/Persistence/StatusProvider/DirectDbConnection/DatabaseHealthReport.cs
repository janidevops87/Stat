using Statline.Common.Utilities;
using System;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatusProvider.DirectDbConnection
{
    internal class DatabaseHealthReport
    {
        public readonly static DatabaseHealthReport Healthy =
            new DatabaseHealthReport();

        public static DatabaseHealthReport FromException(Exception ex)
        {
            Check.NotNull(ex, nameof(ex));
            return new DatabaseHealthReport(ex.Message, ex);
        }

        private DatabaseHealthReport()
        {
        }

        public DatabaseHealthReport(
            string errorDescription,
            Exception exception)
        {
            Check.NotEmpty(errorDescription, nameof(errorDescription));
            Check.NotNull(exception, nameof(exception));

            ErrorDescription = errorDescription;
            Exception = exception;
        }

        public bool IsHealthy => Exception is null;
        public string? ErrorDescription { get; }
        public Exception? Exception { get; }

        public override string ToString()
        {
            return IsHealthy ?
                "Is healthy" :
                "Is NOT healthy: " + ErrorDescription;
        }
    }
}