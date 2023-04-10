using System;
using System.Collections.Generic;
using System.Text;
using Statline.Common.AppModel.Environment;
using Microsoft.Extensions.Configuration;

namespace Statline.Common.AppModel.Host
{
    public class AppHostBuilderContext
    {
        public IEnvironment HostingEnvironment { get; internal set; }
        public IConfiguration Configuration { get; internal set; }
    }
}
