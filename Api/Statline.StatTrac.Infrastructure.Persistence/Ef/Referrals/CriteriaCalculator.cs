using Microsoft.EntityFrameworkCore;
using Statline.StatTrac.Domain.Referrals.Factory;
using Statline.StatTrac.Domain.Referrals.Factory.Criteria;

namespace Statline.StatTrac.Infrastructure.Persistence.Ef.Referrals;

public class CriteriaCalculator : ICriteriaCalculator
{
    private readonly ReferralTransactionalDbContext referralDbContext;

    public CriteriaCalculator(
        ReferralTransactionalDbContext referralDbContext)
    {
        this.referralDbContext = Check.NotNull(referralDbContext);
    }

    public async Task<ReferralCriteria> CalculateCriteriaAsync(
        CriteriaCalculatorInputData inputData)
    {
        Check.NotNull(inputData);

        return await referralDbContext.EReferralCalculateCriteria_Organ(
                    inputData.DonorAge?.Value,
                    inputData.DonorAge?.Unit,
                    inputData.DonorGender,
                    (int?)inputData.DonorWeight?.ToKilograms()?.Value,
                    inputData.HighRisk.Hiv,
                    AidsId: null,
                    inputData.HighRisk.HepB,
                    inputData.HighRisk.HepC,
                    Ivdaid: null,
                    inputData.Heartbeat,
                    inputData.Ventilator,
                    inputData.OrganizationId,
                    inputData.SourceCodeId)
            .SingleAsync()
            .ConfigureAwait(false);
    }
}
