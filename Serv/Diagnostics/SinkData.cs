/// <summary>
/// These are Categories used record information in a sink. Statline defaults data to the database using the the Enterprise Library Sink
/// </summary>
public enum Category
{
	General,
	Information,
	Error,
	Notify,
    ImportMailError
	
}
/// <summary>
/// Priority used when logging an exception or error
/// </summary>
public enum Priority
{
	Default = 0,
	Minor = 1,
	Major = 2
}
/// <summary>
/// Types of Traces used in application. The default trace is the DBTrace which is used by Statline.Data.DBCommands class
/// </summary>
public enum TraceType
{
	DBTrace,
	Application
}
