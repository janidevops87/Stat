namespace Registry.Web.UI.DAL
{
    public class ExceptionMimic
    {
        public string ExceptionType { get; set; }
        public string Message { get; set; }
        public string ExceptionMessage { get; set; }
        public string StackTrace { get; set; }
        public ExceptionMimic InnerException { get; set; }
    }
}