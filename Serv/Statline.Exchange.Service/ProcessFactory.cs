using System;
using System.Collections.Generic;
using System.Text;
using Statline.Configuration;

namespace Statline.Exchange.Service
{

    /// <summary>
    /// Use ProcessFactory to set new class that implement AbstractProcess. 
    /// This class uses the Application Name to determine what version of the class to create
    /// <remarks>
    /// Created: 4/24/2009
    /// Created By: Bret Knoll
    /// </remarks>
    /// </summary>
    public static class ProcessFactory
    {
        public static AbstractProcess GetProcesObject()
        {
            return GetProcesObject(ApplicationSettings.GetSetting(SettingName.ApplicationName));
        }

        public static AbstractProcess GetProcesObject(string applicationName)
        {
            return GetProcesObject((ApplicationName)Enum.Parse(typeof(ApplicationName), applicationName));
        }
        public static AbstractProcess GetProcesObject(ApplicationName applicationName )
        {
            AbstractProcess abstractProcess = null;
            switch (applicationName)
            {
                case ApplicationName.StatRespond:
                    abstractProcess = new StatRespondProcess();
                    break;
                default:
                    string exceptionString = "AbstractProcess Type is not implemented: " + applicationName;
                    throw new NotImplementedException(exceptionString);

            }
            return abstractProcess;
        }

    }
}
