using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Constant;
using System.Windows.Forms;

namespace Statline.Stattrac.Common
{
    /// <summary>
    /// Used as the interface to map UI environments where references to each other causes a circular reference.
    /// </summary>
    public interface UIMap
    {
        /// <summary>
        /// method used to initialize an environment.
        /// 1. Setup users
        /// 2. Configure Dataconnections
        /// </summary>
        void Initialize();
        /// <summary>
        /// used when the call to the environent requires a popup interface.
        /// </summary>
        /// <param name="appScreenType"></param>
        /// <param name="recordID"></param>
        int Open(AppScreenType appScreenType, int recordID);
        /// <summary>
        /// Used when the call to the environment open a screen in the normal UserControl edit Panel.
        /// </summary>
        /// <param name="appScreenType"></param>
        /// <returns></returns>
        UserControl Create(AppScreenType appScreenType);
        
    }
}
