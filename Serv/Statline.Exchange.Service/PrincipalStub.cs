using Statline.Framework;
using System;

namespace Statline.Exchange.Service
{
    internal class PrincipalStub : BasePrincipal
    {
        public PrincipalStub(BaseIdentity identity) 
            : base(identity, Array.Empty<string>())
        {
        }
    }
}
