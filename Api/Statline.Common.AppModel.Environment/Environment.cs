using Statline.Common.Utilities;

namespace Statline.Common.AppModel.Environment
{
    public class Environment : IEnvironment
    {
        public static readonly string EnvironmentNameKey = "Environment";

        private readonly IEnvironmentVariableSource environmentVariableSource;

        public Environment(IEnvironmentVariableSource environmentVariableSource)
        {
            Check.NotNull(environmentVariableSource, nameof(environmentVariableSource));
            this.environmentVariableSource = environmentVariableSource;
        }

        public string EnvironmentName
        {
            get
            {
                return
                    environmentVariableSource.GetValue(EnvironmentNameKey) ??
                    AppModel.Environment.EnvironmentName.Production;
            }
        }
    }
}
