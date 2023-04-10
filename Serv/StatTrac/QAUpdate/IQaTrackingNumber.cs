using System;
using System.Collections.Generic;
using System.Text;

namespace Statline.StatTrac.QAUpdate
{
    public interface IQaTrackingNumber
    {
        /// <summary>
        /// Generates or confirms the creation of a new tracking number.
        /// The implemenation should use the passed in trackingNumber to confirm it exists in named system.
        /// If the trackingNumber is an empty string the implementation should create a new tracking number of the names system.
        /// </summary>
        /// <param name="trackingNumber"></param>
        /// <returns></returns>
        string Next(string trackingNumber);
    }
}
