using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Referrals;

public enum AppropriateType
{
    Unassigned = DefaultValues.MinusOne,
    Yes = 1,
    Age = 2,
    HighRisk = 3,
    MedRo = 4,
    NotAppropriate = 5,
    PreviousVent = 6,
    NoNeuroInjury = 7
}
