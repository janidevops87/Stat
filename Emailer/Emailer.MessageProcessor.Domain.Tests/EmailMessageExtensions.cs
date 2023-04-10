namespace Emailer.MessageProcessor.Domain.Tests
{
    public static class EmailMessageExtensions
    {
        private static readonly EmailMessageEqualityComparer comparer = new();

        public static bool Equals(this EmailMessage left, EmailMessage right)
        {
            return comparer.Equals(left, right);
        }
    }
}
