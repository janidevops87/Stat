using Statline.Common.Utilities;
using System;

namespace Statline.Common.AppModel.Environment
{
    /// <summary>
    /// Extension methods for <see cref="IEnvironment"/>.
    /// </summary>
    public static class EnvironmentExtensions
    {
        /// <summary>
        /// Checks if the current environment name is "Development".
        /// </summary>
        /// <param name="environment">An instance of <see cref="IEnvironment"/>.</param>
        /// <returns>True if the environment name is "Development", otherwise false.</returns>
        public static bool IsDevelopment(this IEnvironment environment)
        {
            Check.NotNull(environment, nameof(environment));
            return environment.IsEnvironment(EnvironmentName.Development);
        }

        /// <summary>
        /// Checks if the current environment name is "Production".
        /// </summary>
        /// <param name="environment">An instance of <see cref="IEnvironment"/>.</param>
        /// <returns>True if the environment name is "Production", otherwise false.</returns>
        public static bool IsProduction(this IEnvironment environment)
        {
            Check.NotNull(environment, nameof(environment));
            return environment.IsEnvironment(EnvironmentName.Production);
        }


        /// <summary>
        /// Checks if the current environment name is "Test".
        /// </summary>
        /// <param name="environment">An instance of <see cref="IEnvironment"/>.</param>
        /// <returns>True if the environment name is "Test", otherwise false.</returns>
        public static bool IsTest(this IEnvironment environment)
        {
            Check.NotNull(environment, nameof(environment));
            return environment.IsEnvironment(EnvironmentName.Test);
        }

        /// <summary>
        /// Compares the current environment name against the specified value.
        /// </summary>
        /// <param name="environment">An instance of <see cref="IEnvironment"/>.</param>
        /// <param name="environmentName">Environment name to validate against.</param>
        /// <returns>True if the specified name is the same as the current environment, 
        /// otherwise false.</returns>
        public static bool IsEnvironment(
            this IEnvironment environment,
            string environmentName)
        {
            Check.NotNull(environment, nameof(environment));

            return string.Equals(
                environment.EnvironmentName,
                environmentName,
                StringComparison.OrdinalIgnoreCase);
        }

    }
}
