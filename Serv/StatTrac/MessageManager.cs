using System;
using System.Collections;
using System.Globalization;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;
using Statline.StatTrac.Data.Tables;
using Statline.StatTrac.Data;
using Statline.StatTrac.Data.Types;
using System.Windows.Forms;
using Statline.Data;
namespace Statline.StatTrac
{
	/// <summary>
	/// This class manages the message, call and Logevent Updates . This class calls the DBLayer
	/// </summary>
	/// <remarks>
	/// <P>Name: MessageManager </P>
	/// <P>Date Created: 4/17/07</P>
	/// <P>Created By: Bret Knoll</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Calls the DBLayer</P>
	/// </remarks>
	public class MessageManager
	{
		#region Call
		/// <summary>
		/// Create Call
		/// </summary>
		/// <param name="messageData"></param>
		public void	CreateCall(MessageData messageData)
		{
			AutoImportDB.AutoImportInitialize(messageData);
		}
		#endregion

		#region Message
		/// <summary>
		/// Create Message
		/// </summary>
		/// <param name="messageData"></param>
		public void CreateMessage(MessageData messageData)
		{
			AutoImportDB.AutoImportCreateMessage(messageData);
		}
		/// <summary>
		/// 
		/// </summary>
		/// <param name="messageData"></param>
		public static void UpdateMessage(MessageData messageData)
		{
			// get db instance
			Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
			
			//create transaction within using
			using(TransactionHelper tHelper = new TransactionHelper(db))
			{
				
				try
				{
					tHelper.StartTransaction();
					//try to update call pass messageData and transaction
					CallDB.UpdateCall(db, messageData, tHelper.DbTransaction);
					//try to update message
					MessageDB.UpdateMessage(db, messageData, tHelper.DbTransaction); 
					//try to upddate logevent
					LogEventDB.UpdateLogEvent(db, messageData, tHelper.DbTransaction);
					
					tHelper.CommittTransaction();
				}
				catch
				{
					tHelper.RollBackTransaction();
					throw;
				}


			}
		}

		#endregion		

		#region LogEvent
		/// <summary>
		/// Create LogEvents
		/// </summary>
		/// <param name="messageData"></param>
 
		public void CreateLogEvent(MessageData messageData)
		{
			AutoImportDB.AutoImportCreateLogEvent(messageData);
		}
		#endregion
	}
}
