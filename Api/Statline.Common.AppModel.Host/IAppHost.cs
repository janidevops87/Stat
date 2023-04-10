using System;
using System.Threading.Tasks;

namespace Statline.Common.AppModel.Host
{
    public interface IAppHost
    {
        Task RunAppAsync(Func<AppHostContext, Task> runCallback);
    }
}
