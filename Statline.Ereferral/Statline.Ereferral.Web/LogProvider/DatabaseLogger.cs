using Microsoft.Extensions.Logging;
using System;
using System.Data.SqlClient;

namespace Statline.Ereferral.Web.LogProvider
{
    public class DatabaseLogger : ILogger
    {
        private string _categoryName;
        private string _connString;

        public DatabaseLogger(string categoryName, string connString)
        {
            _categoryName = categoryName;
            _connString = connString;
        }

        public IDisposable BeginScope<TState>(TState state)
        {
            return null;
        }

        public bool IsEnabled(LogLevel logLevel)
        {
            // Log Events from Staline namesapce
            return _categoryName.StartsWith("Statline");
        }

        public void Log<TState>(LogLevel logLevel, EventId eventId, TState state, Exception exception, Func<TState, Exception, string> formatter)
        {
            if (_categoryName.StartsWith("Statline") || logLevel > LogLevel.Information)
            {
                string queryString = $@"INSERT INTO [dbo].[Log] ([CreatedTime],[LogLevel],[EventId],[Category],[Message]) VALUES (@CreatedTime,@LogLevel,@EventId,@Category,@Message)";
                using (SqlConnection connection = new SqlConnection(_connString))
                {
                    using (SqlCommand command = new SqlCommand(queryString, connection))
                    {
                        command.Parameters.Add(new SqlParameter("@CreatedTime", DateTime.UtcNow));
                        command.Parameters.Add(new SqlParameter("@LogLevel", logLevel.ToString()));
                        command.Parameters.Add(new SqlParameter("@EventId", eventId.ToString()));
                        command.Parameters.Add(new SqlParameter("@Category", _categoryName));
                        command.Parameters.Add(new SqlParameter("@Message", formatter(state, exception)));
                        command.Connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
        }
    }
}