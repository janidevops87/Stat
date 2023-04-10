using Microsoft.Data.SqlClient;
using Statline.StatTrac.App.Heartbeat;

namespace Statline.StatTrac.Api.Infrastructure.Heartbeat;

public class SqlServerHealthChecker : ISqlServerHealthChecker
{
    public async Task<SqlServerHealthReport> CheckHealthAsync(
        string connectionString)
    {
        Check.NotEmpty(connectionString, nameof(connectionString));

        try
        {
            using (var connection = new SqlConnection(connectionString))
            {
                await connection.OpenAsync().ConfigureAwait(false);

                // Opening connection may not be enough:
                // connections are pooled and we may get an already 
                // open internal connection. If network
                // drops after an internal connection is open 
                // and returned to the pool, just opening it again
                // may not involve network activity and 
                // we won't know about the problem.
                var query = "select 1";
                var command = new SqlCommand(query, connection);

                await command.ExecuteScalarAsync().ConfigureAwait(false);
            }
        }
        catch (SqlException ex)
        {
            return SqlServerHealthReport.FromException(ex);
        }

        return SqlServerHealthReport.Healthy;
    }
}
