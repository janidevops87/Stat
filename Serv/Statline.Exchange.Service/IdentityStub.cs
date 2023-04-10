using Statline.Framework;
using System;
using System.Diagnostics;

namespace Statline.Exchange.Service
{
    internal class IdentityStub : BaseIdentity
    {
        public IdentityStub(
            string databaseInstance)
            : base(authenticationType: "Anonymous",
                  isAuthenticated: false,
                  name: "Anonymous",
                  databaseInstance)
        {
        }

        protected override string Title => "Stub Identity";
        protected override string AppDomainName => AppDomain.CurrentDomain.FriendlyName;
        protected override string ProcessName => Process.GetCurrentProcess().ProcessName;

#pragma warning disable CS0618 // Type or member is obsolete
        protected override string Win32ThreadId => AppDomain.GetCurrentThreadId().ToString();
#pragma warning restore CS0618 // Type or member is obsolete

        protected override void AddLogProperties(BaseLogger baseLogger)
        {
            // I don't know what to put here, leaving it blank.
        }
    }
}
