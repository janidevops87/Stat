using System;
using System.Collections.Generic;
using System.Text;

namespace Statline.Exchange.Service
{
    
    public abstract class AbstractMessage
    {
        private string emailMessage;

        public string EmailMessage
        {
            get { return emailMessage; }
            set { emailMessage = value; }
        }
	
    }
}
