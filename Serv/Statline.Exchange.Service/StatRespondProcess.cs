using System;
using Statline.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using System.Diagnostics;
using Statline.StatTrac;
using Statline.Data;

namespace Statline.Exchange.Service
{
    class StatRespondProcess : AbstractProcess
    {
        private StatRespondMessage message;

        public StatRespondMessage Message
        {
            get { return message; }
            set { message = value; }
        }


        public override bool ProcessMessage(AbstractMessage message)
        {
            bool successfull = false;
            int updateResult = 1;
            Message = (StatRespondMessage)message;
            //check if the email was sent from a AutoResponse System. Return if it is.
            if (IsAutoResponse())
                return successfull;
            // parse the email
            successfull = ParseEmail();
            //checked if the email was parse successfully, check the result and return in unsuccessful
            if (!successfull)
                return successfull;
            //the parse was successful, update the event

            var databaseInstance = GetDataBaseInstance();

            using (PrincipalSwitcher.SetCurrentPrincipal(
                () => new PrincipalStub(new IdentityStub(databaseInstance.ToString()))))
            {
                try
                {
                    updateResult = StatTrac.StatRespond.Manager.ProcessPageResponse(databaseInstance, Convert.ToInt32(Message.CALLID), Convert.ToInt32(Message.LogEventTypeID), Convert.ToInt32(Message.LogEventNumber));
                }
                catch (Exception ex)
                {
                    Logger.Write(ex, Category.Error.ToString(), Convert.ToInt32(Priority.Default), 0, TraceEventType.Error);
                    throw;
                }
            }

            if (updateResult < 1)
                successfull = false;
            return successfull;
        }
        private DatabaseInstance GetDataBaseInstance()
        {
            DatabaseInstance instance = DatabaseInstance.Transaction;
            switch (Message.DSN)
            { 
                case "P":
                    instance = DatabaseInstance.Transaction;
                    break;
                case "T":
                    instance = DatabaseInstance.Test;
                    break;
                case "B":
                    instance = DatabaseInstance.Backup;
                    break;
                default:
                    instance = DatabaseInstance.Transaction;
                    break;
            }
            return instance;
        }
        private bool IsAutoResponse()
        {
            bool result = false;
            char[] parseChar = { ',' };
            string[] autoResponseText = ApplicationSettings.GetSetting(SettingName.EmailAutoResponseText).Split(parseChar);
            for (int loopCount = 0; loopCount < autoResponseText.Length; loopCount++)
            {
                if (Message.EmailMessage.Contains(autoResponseText[loopCount]))
                    return Message.IsAutoRespond = true;
            }


            return result;
        }
        private bool ParseEmail()
        {
            bool result = false;
            //does the Search String exist
            //LogEvent: 882|P|7069827|6|
            if (!Message.EmailMessage.Contains(ApplicationSettings.GetSetting(SettingName.ParseStringStart)))
                return result;
            int startParseString = Message.EmailMessage.IndexOf(ApplicationSettings.GetSetting(SettingName.ParseStringStart));
            string parseString = Message.EmailMessage.Substring(startParseString + ApplicationSettings.GetSetting(SettingName.ParseStringStart).Length);
            char[] delimiterChar = { Convert.ToChar(StatRespondMessage.EVENT_DELIMITER)};

            string[] parseStringArray = parseString.Split(delimiterChar, 5);
            if (parseStringArray.Length != 5)
            {
                string errorMessage = "The " + ApplicationSettings.GetSetting(SettingName.ApplicationName) + " cannot determine Email Event Code.";
                Logger.Write(errorMessage, "General");
                return result;
            }

            try
            {
                Message.DSN = parseStringArray[(int)StatRespondMessageArrayLocation.DSN].ToString();
                Message.CALLID = parseStringArray[(int)StatRespondMessageArrayLocation.CallID].ToString();
                Message.LogEventNumber = parseStringArray[(int)StatRespondMessageArrayLocation.LogEventNumber].ToString();
                Message.LogEventTypeID = parseStringArray[(int)StatRespondMessageArrayLocation.LogEventTypeID].ToString();
            }
            catch
            {
                return result;
            }
            try
            {
                int test1 = Convert.ToInt32(Message.CALLID);
                int test2 = Convert.ToInt32(Message.LogEventNumber);
                int test3 = Convert.ToInt32(Message.LogEventTypeID);
            }
            catch
            {
                return result;
            }
            
            result = true;
            return result;
        }
    }
}
