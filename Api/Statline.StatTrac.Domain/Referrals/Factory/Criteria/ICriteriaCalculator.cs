namespace Statline.StatTrac.Domain.Referrals.Factory.Criteria;

public interface ICriteriaCalculator
{
    Task<ReferralCriteria> CalculateCriteriaAsync(
        CriteriaCalculatorInputData inputData);
}
