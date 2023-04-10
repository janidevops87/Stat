using System;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Data;
using Statline.StatTrac.Data;
using Statline.StatTrac.Data.Tables;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.StatRespond
{
    public static class Manager
    {

        #region StatRespond
        /// <summary>
        /// CCRST89 Replacement of AutoResponse Application 
        /// </summary>
        /// <remarks> 
        /// <P>Date Created: 4/24/09</P>
        /// <P>Created By: Bret Knoll</P>
        /// <P>Version: 1.0</P>
        /// </remarks>
        /// <param name="instance"></param>
        /// <param name="callId"></param>
        /// <param name="logeEventTypeId"></param>
        /// <param name="logEventNumber"></param>
        /// <returns></returns>
        public static int ClosePageResponse(DatabaseInstance instance, int callId, int logeEventTypeId, int logEventNumber)
        {
            int result = 0;
            try
            {
                result = LogEventDB.ClosePageResponse(instance, callId, logeEventTypeId, logEventNumber);
            }
            catch
            {
                throw;
            }
            return result;
        }

        public static int ProcessPageResponse(DatabaseInstance instance, int callId, int logeEventTypeId, int logEventNumber)
        {
            int result = 0;
            const int PAGERAUTORESPONSESTATEMPLOYEE = 375; // Pager	AutoResponse
            const int LOGEVENTCONTACTCONFIRMED = 1;

            int newLogEventTypeId = 0;
            string description = "";


            // We convert all date/times to Mountain Time (not to UTC, due to historical reasons) 
            // to do correct comparison.
            TimeZoneInfo MountainTimeZone =
                TimeZoneInfo.FindSystemTimeZoneById("Mountain Standard Time");
            DateTime currentMountainDateTime =
                TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, MountainTimeZone);

            //load logEventDataSet by GetLogEventByLogEventAutoResponseCode
            LogEventData logEventDs = new LogEventData();
            try
            {
                LogEventDB.GetLogEventByAutoResponseCode(instance, logEventDs, callId, logEventNumber);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
                throw;
            }
            //check callbackPending is closed out
            if (logEventDs.LogEvent.Count == 0)
                return result;
            // if call back pending is set set LogEventTypeID = 0
            if (logEventDs.LogEvent[ConstHelper.DEFAULTFIRSTRECORD].LogEventCallbackPending == ConstHelper.LOGEVENTCALLBACKPENDINGCLOSED)
                newLogEventTypeId = 0;
            else
                newLogEventTypeId = logeEventTypeId;

            switch ((LogEvent.LogEventType)newLogEventTypeId)
            {
                case(LogEvent.LogEventType.PagePending):
                    newLogEventTypeId = Convert.ToInt32(LogEvent.LogEventType.PageResponse);
                    description = "PAGE RESPONSE";
                    break;
                case(LogEvent.LogEventType.EmailPending):
                    newLogEventTypeId = Convert.ToInt32(LogEvent.LogEventType.EmailResponse);
                    description = "EMAIL RESPONSE";
                    break;
                default:
                    newLogEventTypeId = Convert.ToInt32(LogEvent.LogEventType.UnmatchedResponse);
                    description = "LogEvent: " + logEventNumber + "|*|" + callId + "|" + logeEventTypeId + "|";
                    break;
            }

            //update the existing record
            if (logEventDs.LogEvent[ConstHelper.DEFAULTFIRSTRECORD].LogEventCallbackPending != ConstHelper.LOGEVENTCALLBACKPENDINGCLOSED)
            {
                logEventDs.LogEvent[ConstHelper.DEFAULTFIRSTRECORD].LogEventCallbackPending = ConstHelper.LOGEVENTCALLBACKPENDINGCLOSED;
                logEventDs.LogEvent[ConstHelper.DEFAULTFIRSTRECORD].LastStatEmployeeID = PAGERAUTORESPONSESTATEMPLOYEE;
            }

            LogEventData.LogEventRow newLogEventRow = logEventDs.LogEvent.NewLogEventRow();
            try
            {
                newLogEventRow.CallID = logEventDs.LogEvent[ConstHelper.DEFAULTFIRSTRECORD].CallID;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            try
            {
                newLogEventRow.LogEventTypeID = newLogEventTypeId;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            try
            {
                newLogEventRow.LogEventName = logEventDs.LogEvent[ConstHelper.DEFAULTFIRSTRECORD].LogEventName;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            try
            {
                newLogEventRow.LogEventOrg = logEventDs.LogEvent[ConstHelper.DEFAULTFIRSTRECORD].LogEventOrg;
            }
            catch (Exception ex)
            {
                newLogEventRow.LogEventOrg = string.Empty;
                Logger.Write(ex, "General");
            }
            try
            {
                newLogEventRow.StatEmployeeID = PAGERAUTORESPONSESTATEMPLOYEE;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            try
            {
                newLogEventRow.LogEventDesc = description;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            try
            {
                newLogEventRow.LogEventDateTime = currentMountainDateTime;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            try
            {
                newLogEventRow.LogEventCallbackPending = ConstHelper.LOGEVENTCALLBACKPENDINGCLOSED;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            try
            {
                newLogEventRow.OrganizationID = logEventDs.LogEvent[ConstHelper.DEFAULTFIRSTRECORD].OrganizationID;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            try
            {
                newLogEventRow.ScheduleGroupID = logEventDs.LogEvent[ConstHelper.DEFAULTFIRSTRECORD].ScheduleGroupID;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            try
            {
                newLogEventRow.PersonID = logEventDs.LogEvent[ConstHelper.DEFAULTFIRSTRECORD].PersonID;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            try
            {
                newLogEventRow.PhoneID = logEventDs.LogEvent[ConstHelper.DEFAULTFIRSTRECORD].PhoneID;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            try
            {
                newLogEventRow.LogEventContactConfirmed = LOGEVENTCONTACTCONFIRMED;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            //TRY NOT TO SET THISnewLogEventRow.LogEventCalloutDateTime;
            try
            {
                newLogEventRow.LastStatEmployeeID = PAGERAUTORESPONSESTATEMPLOYEE;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }
            logEventDs.LogEvent.AddLogEventRow(newLogEventRow);
            //create new record
            try
            {
                LogEventDB.UpdateLogEvent(instance, logEventDs);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
                throw;
            }

            result = 1;

            return result;
        }
        #endregion

    }
}
