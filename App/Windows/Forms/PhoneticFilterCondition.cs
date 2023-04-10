using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.Windows.Forms
{
    /// <summary>
    /// Used to filter ultragrid rows with Soundex or Differene comparer
    /// </summary>
    public class PhoneticFilterCondition : FilterCondition
    {
			#region Constructors
    
            public PhoneticFilterCondition(UltraGridColumn column, FilterComparisionOperator comparisionOperator, object compareValue) : base(column, comparisionOperator, compareValue) { }
			#endregion Constructors

        public override bool MeetsCriteria(UltraGridRow row)
        {
            bool result = false;
            // Get the text in the cell
            string cellText = row.Cells[Column.Key].Value.ToString().ToLower();
            string comparerText = this.CompareValue.ToString().ToLower();

            int difference = Statline.Stattrac.Framework.Phonetic.Difference(comparerText, cellText);

            if (difference >= (int)Difference.High)
                result = true;
            return result;
        }
    }
}
