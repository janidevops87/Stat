using System;
using System.Collections.Generic;
using System.Text;

namespace Statline.Service
{
    /// <summary>
    /// This Statline Services will call this interface to make service processing consistent. 
    /// </summary>
    public interface IAutoProcess
    {

        void Process();
    }
}
