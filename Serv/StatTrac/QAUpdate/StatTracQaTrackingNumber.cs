using System;
using System.Collections.Generic;
using System.Text;

namespace Statline.StatTrac.QAUpdate
{
    public class StatTracQaTrackingNumber : IQaTrackingNumber
    {
        #region IQaTrackingNumber Members

        public string Next(string trackingNumber)
        {
            return trackingNumber;
        }

        #endregion
    }
}
