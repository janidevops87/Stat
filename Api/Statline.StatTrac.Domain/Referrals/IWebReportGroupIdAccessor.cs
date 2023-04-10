namespace Statline.StatTrac.Domain.Referrals;

/// <summary>
/// The goal of this interface to make a web report group ID
/// available to repositories implicitly, without passing it with every query.
/// </summary>
/// <remarks>
/// Because web report group ID will always be fixed for a particular user, 
/// it can be specified as a global query filter in the repository. Such
/// global filter will exclude the need to add such a filter to every query,
/// and also will help to avoid security holes when somebody forgets to add such
/// filter to a new query. This interface will also reduce number of parameters
/// in query methods (but the price is clarity, of course).
/// </remarks>
public interface IWebReportGroupIdAccessor
{
    WebReportGroupId? GetWebReportGroupId();
}
