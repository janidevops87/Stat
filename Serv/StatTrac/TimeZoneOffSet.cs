using System;
using System.Collections.Generic;
using System.Text;


namespace Statline.StatTrac
{
    public static class TimeZoneOffSet
    {
        /// <summary>
        /// Returns the number of hours a timeZone is off from MountainTime.
        /// The value returned will convert a time from the given timeZone to MountainTime.
        /// To calculate MT from PT, if dt = '12/1/09 01:00 PT' use dt.AddHours(TimeZoneOffSet.MountainTimeZoneOffSet('PT', dt))
        /// To calulate PT from MT, if dt = '12/1/09 00:00 MT' use dt.AddHours(-TimeZoneOffSet.MountainTimeZoneOffSet('PT', dt))
        /// </summary>
        /// <param name="timeZone"></param>
        /// <param name="activtyDate"></param>
        /// <returns></returns>
        public static double MountainTimeZoneOffSet(string timeZone, DateTime activtyDate)
        {
            double offSet = 0;
            
            switch (timeZone.ToLower())
            {
                case "at": 
                    offSet =  3;
                    break;
                case "as":
                    offSet = 3;
                    break;
                case "et": 
                    offSet = 2;
                    break;
                case "es": 
                    offSet = 2;
                    break;
                case "ct": 
                    offSet = 1;
                    break;
                case "cs": 
                    offSet = 1;
                    break;
                case "mt": 
                    offSet = 0;
                    break;
                case "ms": 
                    offSet = 0;
                    break;
                case "pt": 
                    offSet = -1;
                    break;
                case "ps": 
                    offSet = -1;
                    break;
                case "kt": 
                    offSet = -2;
                    break;
                case "ks": 
                    offSet = -2;
                    break;
                case "ht": 
                    offSet = -3;
                    break;
                case "hs": 
                    offSet = -3;
                    break;
                case "st": 
                    offSet = -4;
                    break;
                case "ss": 
                    offSet = -4;
                    break;
                 
                default:
                    offSet = 0;
                    break;
            }
            // if the time zone is a non day light saving timezone then determine difference
            // ccarroll 05/06/2009 - added convert to lower case (timeZone). Changed offSet decrement to -1.
            if (timeZone.ToLower().Contains("s"))
            {
                if (activtyDate.IsDaylightSavingTime())
                    offSet = offSet -1;
            }
            return offSet;
        }
    }
}
