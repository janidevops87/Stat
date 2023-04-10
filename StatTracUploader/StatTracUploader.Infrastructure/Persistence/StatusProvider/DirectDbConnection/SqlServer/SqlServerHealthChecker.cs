// NOTE: This is commented out to remove dependency on SqlServer-related 
// packages while we're not using this code. Still I want to preserve this code
// for now as a sample.

//using Statline.Common.Utilities;
//using System.Data.SqlClient;
//using System.Threading;
//using System.Threading.Tasks;

//namespace Statline.StatTracUploader.Infrastructure.Persistence.StatusProvider.DirectDbConnection.SqlServer
//{
//    internal class SqlServerHealthChecker : IDatabaseHealthChecker
//    {
//        public async Task<DatabaseHealthReport> CheckHealthAsync(
//            string connectionString,
//            CancellationToken cancellationToken)
//        {
//            Check.NotEmpty(connectionString, nameof(connectionString));

//            try
//            {
//                using var connection = new SqlConnection(connectionString);

//                await connection.OpenAsync(cancellationToken).ConfigureAwait(false);

//                // Opening connection may not be enough:
//                // connections are pooled and we may get an already 
//                // open internal connection. If network
//                // drops after an internal connection is open 
//                // and returned to the pool, just opening it again
//                // may not involve network activity and 
//                // we won't know about the problem.
//                var command = new SqlCommand(cmdText: "select 1", connection);

//                await command.ExecuteScalarAsync(cancellationToken).ConfigureAwait(false);
//            }
//            catch (SqlException ex)
//            {
//                return DatabaseHealthReport.FromException(ex);
//            }

//            return DatabaseHealthReport.Healthy;
//        }
//    }
//}
