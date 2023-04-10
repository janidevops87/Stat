using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Statline.Stattrac.Constant
{
	public enum ListFamilyServiceStatus
	{
		None = 0,
		SecondaryPending = 1,
		AdditionalInformationNeeded = 2,
		ApproachWithAnMeDisclaimer = 3,
		Approach = 4,
		RegisteredDonorApproach = 5,
		Closed = 6,
		Consented = 7,
		CoordToCB = 8,
		CalloutPending = 9,
		Decision = 10,
		DirectApproach = 11,
		InformOfRuleOut = 12,
		LanguageLineApproach = 13,
		LanguageLinePaperwork = 14,
		NoNextOfKinInformation = 15,
		NextOfKinToCallback = 16,
		Paperwork = 17,
		RecoveryOutcome = 18,
		Secondary = 19,
		AwaitingCoronerCallback = 20,
		ScreeningWithProcessor = 21
	}
}
