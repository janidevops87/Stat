using System;
using System.Collections.Generic;
using System.Text;

namespace Statline.StatTrac.QAUpdate
{
    public enum TrackingNumberType
    {
        StatTrac=1
    }
    public static class QaTrackingNumberFactory
    {
        /// <summary>
        /// use the factory to get the Tracking Number Generator.
        /// Call IQaTrackingNumber.Next(trackingNumber) after obtaining the object
        /// </summary>
        /// <param name="trackingNumberType"></param>
        /// <returns>an implemented IQaTrackingNumber based on the enumb passed in</returns>
        public static IQaTrackingNumber GetQATrackingNumber(string trackingNumberType)
        {
            
            return GetQATrackingNumber((TrackingNumberType)Enum.Parse(typeof(TrackingNumberType), trackingNumberType));
        }

        public static IQaTrackingNumber GetQATrackingNumber(TrackingNumberType trackingNumberType)
        {
            IQaTrackingNumber qaTrackingNumber = null;
            switch(trackingNumberType)
            {
                case TrackingNumberType.StatTrac:
                    qaTrackingNumber = new StatTracQaTrackingNumber();
                    break;
                default:
                    string exceptionString = "Tracking Number Type not implemented: " + trackingNumberType;
                    throw new NotImplementedException(exceptionString);

            }
            return qaTrackingNumber;


        }
    }
}
