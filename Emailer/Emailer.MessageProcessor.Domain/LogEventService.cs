#pragma warning disable CA1822 // Mark members as static

namespace Emailer.MessageProcessor.Domain
{
    /// <summary>
    /// Provides processing of Log Events 
    /// in an email message.
    /// </summary>
    public class LogEventService
    {
        private const string LogEventMarker = "LogEvent: ";

        /// <summary>
        /// Looks email body for a Log Event and 
        /// if found adds the Log Event text at the begining
        /// of the subject and body.
        /// </summary>
        /// <param name="messageBuilder">The message to process.</param>
        // TODO: Invent a more descriptive name so its clear 
        // where the Log Event comes from.
        public void AddLogEventToSubjectAndBody(EmailMessageBuilder messageBuilder)
        {
            var logEventText = GetLogEventText(messageBuilder.Body);

            string newSubject = AddLogEventToSubject(messageBuilder.Subject, logEventText);
            string newBody = AddLogEventToStartOfBody(messageBuilder.Body, logEventText);

            messageBuilder.SetSubject(newSubject);
            messageBuilder.SetBody(newBody);
        }

        public void MoveLogEventAndAddSubjectToStartOfBody(EmailMessageBuilder messageBuilder)
        {
            var logEventText = GetLogEventText(messageBuilder.Body);

            if (string.IsNullOrEmpty(logEventText))
            {
                return;
            }

            string body = messageBuilder.Body;

            var bodyWithoutLogEvent = body.Substring(0, body.Length - logEventText.Length);
            string newBody = $"{logEventText} {messageBuilder.Subject} {bodyWithoutLogEvent}";
            messageBuilder.SetBody(newBody);
        }

        public int GetLogEventLength(EmailMessage message)
        {
            int logEventStart = message.Body.IndexOf(LogEventMarker);

            if (logEventStart == -1)
            {
                return 0;
            }

            return message.Body.Length - logEventStart;
        }

        /// <summary>
        /// This method appends the Log Event to the Subject and returns the 
        /// result as a string provided the Log Event does not already exist.
        /// </summary>
        private static string AddLogEventToSubject(string subject, string? logEventText)
        {
            if (!subject.Contains(LogEventMarker))
            {
                return PrependStringWithLogEvent(subject, logEventText);
            }

            return subject;
        }

        /// <summary>
        /// This method adds the Log Event to the first part of email body and returns the 
        /// result as a string provided the Log Event exists.
        /// </summary>
        private static string AddLogEventToStartOfBody(string emailBody, string? logEventText)
        {
            return PrependStringWithLogEvent(emailBody, logEventText);
        }

        private static string PrependStringWithLogEvent(string text, string? logEventText)
        {
            if (string.IsNullOrEmpty(logEventText))
            {
                return text;
            }

            if (string.IsNullOrEmpty(text))
            {
                return logEventText;
            }

            return $"{logEventText} {text}";
        }

        /// <summary>
        /// This method returns the Log Event text from the email body.
        /// If Log Event does not exist it returns null.
        /// </summary>
        private static string? GetLogEventText(string emailBody)
        {
            int logEventStart = emailBody.IndexOf(LogEventMarker);

            if (logEventStart >= 0)
            {
                return emailBody[logEventStart..];
            }

            return null;
        }
    }
}
