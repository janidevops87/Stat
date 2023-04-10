using System;
using System.Collections.Generic;
using System.Text;

namespace Statline.Exchange.Service
{
    public abstract class AbstractProcess
    {
        public abstract bool ProcessMessage(AbstractMessage message);
	
    }
}
