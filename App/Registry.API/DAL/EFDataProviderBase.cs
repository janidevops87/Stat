using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using Registry.API.DAL.Databases.Referral;
using Registry.API.DAL.Databases.Registry;
using Registry.Common.Attributes;

namespace Registry.API.DAL
{
    public abstract class EFDataProviderBase
    {
        private const string SPReturnParamName = "ret";

        protected RegistryContext RegistryDb => new RegistryContext("RegistryConnection");

        protected ReferralContext ReferralDb => new ReferralContext("ReferralConnection");

        private static SqlParameter GetParameter<T>(string name, T value)
        {
            return value == null ? new SqlParameter(name, DBNull.Value) : new SqlParameter(name, value);
        }

        private static IEnumerable<SqlParameter> ModelToParameters<T>(T model)
        {
            return typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly)
                .Where(x => !x.GetCustomAttributes(typeof(IgnoreProcedureParameterAttibute)).Any())
                .Select(property => GetParameter(property.Name, property.GetValue(model)));
        }

        private static string GetStoredProcExecLine(string sprocName, IEnumerable<SqlParameter> parameters)
        {
            var storedProcParamsList = parameters.Select(x => $"@{x.ParameterName}");
            var storedProcExecLine = $"{sprocName} {string.Join(", ", storedProcParamsList)}";
            return storedProcExecLine;
        }

        private static string GetStoredProcWithReturnExecLine(string sprocName, IList<SqlParameter> parameters)
        {
            var storedProcParamsList = parameters.Select(x => $"@{x.ParameterName}");
            var storedProcExecLine = $"EXEC @{SPReturnParamName} = {sprocName} {string.Join(", ", storedProcParamsList)}";
            parameters.Add(new SqlParameter() { ParameterName = SPReturnParamName, SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Output });

            return storedProcExecLine;
        }

        protected static async Task<IEnumerable<TResult>> ExecuteStoredProcedure<TResult, TModel>(string sprocName, TModel model, DbContext context)
        {
            var parameters = ModelToParameters(model).ToArray();
            var sprocExecuteLine = GetStoredProcExecLine(sprocName, parameters);

            return await context.Database.SqlQuery<TResult>(sprocExecuteLine, parameters).ToListAsync().ConfigureAwait(false); 
        }

        protected static async Task<int> ExecuteStoredProcedure<TModel>(string sprocName, TModel model, DbContext context)
        {
            var parameters = ModelToParameters(model).ToList();
            var sprocExecuteLine = GetStoredProcWithReturnExecLine(sprocName, parameters);

            await context.Database.ExecuteSqlCommandAsync(sprocExecuteLine, parameters.ToArray());

            return (int)parameters.Single(x => x.ParameterName == SPReturnParamName).Value;
        }
    }
}
