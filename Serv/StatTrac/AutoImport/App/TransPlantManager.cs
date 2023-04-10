using System;
using Statline.StatTrac.Data;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.AutoImport
{
	/// <summary>
	/// Summary description for TransPlantManager.
	/// </summary>
	/// <remarks>
	/// <P>Name: TransPlantManager </P>
	/// <P>Date Created: 4/17/07</P>
	/// <P>Created By: Bret Knoll</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Calls the DBLayer</P>
	/// </remarks>
	public class TransPlantManager
	{

		#region TransplantCenter
		/// <summary>
		/// Load Transplant Center DataSet
		/// </summary>
		/// <param name="transplantData"></param>
		/// <param name="TxCode"></param>
		public static void LoadTransplantCenter(ref TransplantCenterData transplantData,string TxCode)
		{
			AutoImportDB.LoadTxCenter(transplantData ,TxCode);
		}

	
		#endregion		

	}
}
