using System;
using System.Collections;
using System.Collections.Specialized;
using System.IO;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

using Statline.Data;
using Statline.Configuration;
using Statline.Security;

namespace Statline.Diagnostics
{
	/// <summary>
	/// Summary description for ErrorProdExceptionPublisher.
	/// This class implement IExceptionPublisher to provide exception hangling functionality
	/// The class will contain both default and customized to current solution functionality
	/// for reporting application exception. 
	/// The default functinality will include a hardcoded database and text file locations.
	/// If the application configurataion does not contain a database or text file location
	/// the defaults will be used. If the database is not accessible this class will write
	/// to the text file. If the error database is supplied then this class will try to write 
	/// the errors to database. If the database is not accessible this class will write to a 
	/// supplied text file.
	/// Configuration Settings
	/// 1. Text File Location
	/// 2. Database String
	/// 
	/// </summary>
    public class ErrorProdExceptionPublisher  //: IExceptionPublisher
	{
		string ErrorDBConnectionString = "ZltYIVJDrm1rWCrlLU8Qfkrpg5x7Krza2ySWQMvDgskup92vHHKoLHiT8tOuErPgpHtVsLIAtaiVsQhADLqlwnb5aC9k/OjbivTd2oeiZVk=//////d57VWZQ7XE819xyoqnbW2A==";

		public ErrorProdExceptionPublisher() {}

        //void IExceptionPublisher.Publish(
        //    Exception exception, 
        //    NameValueCollection AdditionalInfo, 
        //    NameValueCollection ConfigSettings)
        //{
	
        //    int rows = 0;

        //    // Create StringBuilder to maintain publishing information.
        //    StringBuilder strInfo = new StringBuilder();

        //    // Append the exception text
        //    strInfo.AppendFormat("{0}{0}Exception Information{0}{1}", Environment.NewLine, exception.ToString());

        //    // Record the contents of the AdditionalInfo collection.
        //    if (AdditionalInfo != null)
        //    {
        //        // Record General information.
        //        strInfo.AppendFormat("{0}General Information{0}", Environment.NewLine);
        //        strInfo.AppendFormat("{0}Additonal Info:", Environment.NewLine);
        //        foreach (string i in AdditionalInfo)
        //        {
        //            strInfo.AppendFormat("{0}{1}: {2}", Environment.NewLine, i, AdditionalInfo.Get(i));
        //        }
        //    }
        //    // Append the exception text
        //    strInfo.AppendFormat("{0}{0}Exception Information{0}{1}", Environment.NewLine, exception.ToString());


        //    rows = DBSave(DateTime.Now, -1, Environment.MachineName, exception.Source, exception.GetType().ToString(), exception.Message, strInfo.ToString(), ErrorDBConnectionString  );

        //    // if the database fails try to write the text file. 
        //    // Write the entry to the log file.   
        //    if (rows == 0)
        //    {
        //        EventSave(Environment.MachineName, exception.Source, exception.GetType().ToString(), exception.Message, strInfo.ToString() );
        //    }
				


        //}
		
		static int DBSave(
			DateTime exceptionTime, 
			int errorNumber, 
			string machineName, 
			string exceptionSource, 
			string exceptionType, 
			string exceptionMessage, 
			string exceptionDescription,
			string errorDBConnectionString)
		{
			// check for configuration settings
			if(SettingName.ErrorDBConnectionString.ToString() != null &&
				SettingName.ErrorDBConnectionString.ToString().Length > 0)
			{
				errorDBConnectionString = ApplicationSettings.GetSetting( SettingName.ErrorDBConnectionString );
				errorDBConnectionString = EncryptionManager.DecryptWithSalt(errorDBConnectionString);
			}
			else
			{
				//decrypt default string
				errorDBConnectionString = EncryptionManager.DecryptWithSalt(errorDBConnectionString);
			}

			int rows = 0;
			SqlDataAdapter adapter = new SqlDataAdapter( );

			using (SqlConnection connection = new SqlConnection(errorDBConnectionString))
			{
				connection.Open();

				SqlTransaction transaction = connection.BeginTransaction();

				SqlParameter[] parameters = new SqlParameter[]
				{
					SqlUtility.CreateSqlParameter( "vDateTime", exceptionTime.ToString(), 25 ),
					SqlUtility.CreateSqlParameter( "vNumber", errorNumber.ToString(), 4 ),
					SqlUtility.CreateSqlParameter( "vComputer", machineName.ToString(), 50 ),
					SqlUtility.CreateSqlParameter( "vSource", exceptionSource.ToString(), 50 ),
					SqlUtility.CreateSqlParameter( "vLocation", exceptionType.ToString() + " " + exceptionMessage.ToString(), 100 ),
					SqlUtility.CreateSqlParameter( "vDescription", exceptionDescription.ToString(), 8000)
				};

				rows = SqlUtility.ExecuteNonQuery( transaction,
					CommandType.StoredProcedure,
					"[dbo].[spi_error1]",
					parameters
					);
			
				transaction.Commit();

				connection.Close();
				return rows;
			}

		}
	
		static void EventSave (
			string machineName, 
			string exceptionSource, 
			string exceptionType, 
			string exceptionMessage, 
			string exceptionDescription
			)
		{

            Logger.Write(machineName + " " + exceptionSource + " " + exceptionType + " " + exceptionMessage + " " + exceptionDescription);
           
		}
	}
	
}
