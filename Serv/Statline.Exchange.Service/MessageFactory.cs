using System;
using System.Collections.Generic;
using System.Text;
using Statline.Configuration;

namespace Statline.Exchange.Service
{
    /// <summary>
    /// Use MessageFactory to set new class that implement AbstractMessage. 
    /// This class uses the Application Name to determine what version of the class to create
    /// <remarks>
    /// Created: 4/24/2009
    /// Created By: Bret Knoll
    /// </remarks>
    /// </summary>
    public enum ApplicationName
    {
        StatRespond = 1
    }
    public static class MessageFactory
    {
        public static AbstractMessage GetMessageObject()
        {
            return GetMessageObject(ApplicationSettings.GetSetting(SettingName.ApplicationName));

        }
        public static AbstractMessage GetMessageObject(string ApplicationName)
        {
            return GetMessageObject((ApplicationName)Enum.Parse(typeof(ApplicationName), ApplicationName));
        }
        public static AbstractMessage GetMessageObject(ApplicationName applicationName)
        {
            AbstractMessage abstractMessage = null;
            switch (applicationName)
            {
                case ApplicationName.StatRespond:
                    abstractMessage = new StatRespondMessage();
                    break;
                default:
                    string exceptionString = "AbstractMessage Type is not implemented: " + applicationName;
                    throw new NotImplementedException(exceptionString);
            }
            return abstractMessage;
        }
    }
}