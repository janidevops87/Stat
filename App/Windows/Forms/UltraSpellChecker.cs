using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;

namespace Statline.Stattrac.Windows.Forms
{
    public partial class UltraSpellChecker : Infragistics.Win.UltraWinSpellChecker.UltraSpellChecker
    {
        public UltraSpellChecker()
        {
            InitializeComponent();
        }

        public UltraSpellChecker(IContainer container)
        {
            container.Add(this);

            InitializeComponent();
        }
    }
}
