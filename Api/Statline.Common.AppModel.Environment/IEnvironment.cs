namespace Statline.Common.AppModel.Environment
{
    /// <summary>
    /// Provides information about the environment 
    /// an application is running in.
    /// </summary>
    /// <remarks>
    /// This interface is analogous to 
    /// "Microsoft.AspNetCore.Hosting.Abstractions.IHostingEnvironment".
    /// The latter, however, is ASP.NET specific and is not provided to
    /// other app types like console. This interface tries to fill that gap.
    /// </remarks>
    public interface IEnvironment
    {
        string EnvironmentName { get; }
    }
}
