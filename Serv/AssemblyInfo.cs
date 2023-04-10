using System;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Resources;
using System.Security;
using System.Security.Permissions;

[assembly: AssemblyTitle("Statline.dll")]
[assembly: AssemblyDescription("Statline.dll")]
[assembly: AssemblyDefaultAlias("Statline.dll")]

[assembly: AssemblyVersion("1.0")]
[assembly: SatelliteContractVersion("1.0")]
[assembly: AssemblyInformationalVersion("1.0")]

#if DEBUG
[assembly: AssemblyConfiguration("Debug.")]
#else
[assembly: AssemblyConfiguration("Production.")]
#endif

[assembly: AssemblyCompany("Statline LLC")]
[assembly: CLSCompliant(true)]
[assembly: ComVisible(false)]
[assembly: NeutralResourcesLanguage("")]
[assembly: AssemblyProduct("Statline LLC (C) Database Information")]
//[assembly: AllowPartiallyTrustedCallers]
//[assembly: AssemblyKeyFile("")]
[assembly : AssemblyKeyFile("")]
[assembly: AssemblyDelaySign(false)]
[assembly: AssemblyTrademark("Statline are either registered trademarks of Statline LLC in the U.S.")]
[assembly: AssemblyCopyright("Copyright (C) Statline LLC 2006. All rights reserved.")]
//[assembly: SecurityPermission(SecurityAction.RequestMinimum, SkipVerification=true)]