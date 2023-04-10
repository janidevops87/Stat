namespace Emailer.LegacyBridge.Infrastructure.EmailMessageQueue.LegacyQueue
{
    internal class Message
    {
        public AlphaPage Data { get; }
        public int Id => Data.AlphaPageId;

        public Message(AlphaPage queueRow)
        {
            Data = queueRow;
        }
    }
}
