﻿using Microsoft.Extensions.DependencyInjection;
using Statline.StatTrac.BusinessVeracity.Common.Application;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Domain;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ReferralSource.StatTracApi;

public static class ServiceCollectionExtensions
{
    public static void AddStatTracApiReferralSource(
        this IServiceCollection services)
    {
        services.AddTransient<IReferralSource<HighRiskReferralDetails>, StatTracApiReferralSource>();
    }
}
