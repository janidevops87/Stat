using System;
using System.Collections.Generic;
using System.Text;

namespace Statline.Exchange.Service
{
    public enum StatRespondMessageArrayLocation
    {
        LogEventNumber=0,
        DSN=1,
        CallID=2,
        LogEventTypeID=3

    }
    public enum LogEventType
    {
        PagePending = 6,
        PageResponse = 9, 
        EmailPending = 21,
        EmailResponse = 22
    }
    public class StatRespondMessage : AbstractMessage
    {
        public const string EVENT_DELIMITER = "|";

        private string logEventNumber = "";
        private string dSN = "";
        private string logEventType = "";        
        private bool isAutoRespond = false;
        private string logEventTypeID = "";
        private string cALLID = "";

        public string LogEventNumber
        {
            get { return logEventNumber; }
            set { logEventNumber = value; }
        }
        public string DSN
        {
            get { return dSN; }
            set { dSN = value; }
        }
        public string CALLID
        {
            get { return cALLID; }
            set { cALLID = value; }
        }
        public string LogEventTypeID
        {
            get { return logEventTypeID; }
            set { logEventTypeID = value; }
        }
        public string LogEventType
        {
            get { return logEventType; }
            set { logEventType = value; }
        }
        public bool IsAutoRespond
        {
            get { return isAutoRespond; }
            set { isAutoRespond = value; }
        }

    }
}
