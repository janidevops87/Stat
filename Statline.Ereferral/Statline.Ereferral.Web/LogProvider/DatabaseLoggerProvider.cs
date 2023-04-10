using Microsoft.Extensions.Logging;

namespace Statline.Ereferral.Web.LogProvider
{
    public class DatabaseLoggerProvider : ILoggerProvider
    {
        private string _connString;

        public DatabaseLoggerProvider(string connString)
        {
            _connString = connString;
        }

        public ILogger CreateLogger(string categoryName)
        {
            return new DatabaseLogger(categoryName, _connString);
        }

        public void Dispose()
        {
        }
    }
}