using System;
using System.Security.Principal;
using System.Threading;

namespace Statline.Exchange.Service
{
    internal class PrincipalSwitcher : IDisposable
    {
        private readonly IPrincipal oldPrincipal;

        public static PrincipalSwitcher SetCurrentPrincipal(
            // Use the factory instead of passing principal directly
            // because we have a principal which installs itself as current
            // in its constructor, so we have no chance to 
            // read previous principal.
            Func<IPrincipal> principalFactory)
        {
            var switcher = new PrincipalSwitcher(Thread.CurrentPrincipal);
            Thread.CurrentPrincipal = principalFactory();
            return switcher;
        }

        private PrincipalSwitcher(IPrincipal oldPrincipal)
        {
            this.oldPrincipal = oldPrincipal;
        }

        public void Dispose()
        {
            Thread.CurrentPrincipal = oldPrincipal;
        }
    }
}
