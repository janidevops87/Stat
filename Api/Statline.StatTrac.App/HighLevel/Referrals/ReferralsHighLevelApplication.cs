using AutoMapper;
using Microsoft.Extensions.Logging;
using Statline.StatTrac.Domain.Calls;
using Statline.StatTrac.Domain.Calls.Factory;
using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Referrals;
using Statline.StatTrac.Domain.Referrals.Factory;
using Statline.StatTrac.Domain.RegistryStatuses;
using Statline.StatTrac.Domain.SourceCodes;
using System.Linq;

namespace Statline.StatTrac.App.HighLevel.Referrals;

public class ReferralsHighLevelApplication
{
    private readonly IReferralRepository referralRepository;
    private readonly ICallRepository callRepository;
    private readonly IRegistryStatusRepository registryStatusRepository;
    private readonly ISourceCodeRepository sourceCodeRepository;
    private readonly ReferralFactory referralFactory;
    private readonly CallFactory callFactory;
    private readonly IMapper mapper;
    private readonly ILogger logger;

    public ReferralsHighLevelApplication(
        IReferralRepository referralRepository,
        ICallRepository callRepository,
        IRegistryStatusRepository registryStatusRepository,
        ISourceCodeRepository sourceCodeRepository,
        IMapper mapper,
        ReferralFactory referralFactory,
        CallFactory callFactory,
        ILogger<ReferralsHighLevelApplication> logger)
    {
        #pragma warning disable format
        this.referralRepository         = Check.NotNull(referralRepository);
        this.callRepository             = Check.NotNull(callRepository);
        this.registryStatusRepository   = Check.NotNull(registryStatusRepository);
        this.sourceCodeRepository       = Check.NotNull(sourceCodeRepository);
        this.mapper                     = Check.NotNull(mapper);
        this.referralFactory            = Check.NotNull(referralFactory);
        this.callFactory                = Check.NotNull(callFactory);
        this.logger                     = Check.NotNull(logger);
        #pragma warning restore format
    }

    public async Task<Dto.NewReferral.CreatedReferralInfo> AddReferralAsync(
        Dto.NewReferral.ReferralInfo newReferralInfo,
        int onBehalfOfEmployeeId)
    {
        await CheckForDuplicates(newReferralInfo);

        var factoryCallInfo = FactoryCallInfoFromReferralInfo(newReferralInfo);
        var factoryReferralInfo = FactoryReferralInfoFromReferralInfo(newReferralInfo);

        (Referral referral, Call call) = await CreateNewReferralAndCallAsync(
            factoryReferralInfo,
            factoryCallInfo,
            onBehalfOfEmployeeId);

        await CreateRegistryStatusForCall(call);

        return new Dto.NewReferral.CreatedReferralInfo(
            referral.ReferralId,
            call.CallId,
            call.CallNumber);
    }

    private async Task CheckForDuplicates(Dto.NewReferral.ReferralInfo newReferralInfo)
    {
        int callerSourceCodeId = await GetSourceCodeIdByNameAsync(
            newReferralInfo.CallInformation.CallerInformation.SourceCode);

        var filterCriteria = new DuplicateReferralsFilterCriteria(
            filterType: DuplicateReferralsFilterType.MedicalRecordNumber,
            sourceCodeId: callerSourceCodeId,
            medicalRecordNumber: newReferralInfo.DonorInformation.MedicalRecordNumber,
            referralCallerOrganizationId: newReferralInfo.CallInformation.CallerInformation.HospitalOrganizationId);

        logger.LogCheckingForDuplicates(filterCriteria);

        var duplicatesExist =
            await referralRepository.GetDuplicateReferrals(filterCriteria).AnyAsync();

        if (duplicatesExist)
        {
            // TODO: More information about duplicates or the source referral?
            throw new InvalidInputDataException("Duplicate referral");
        }
    }

    private async Task<(Referral, Call)> CreateNewReferralAndCallAsync(
        Domain.Referrals.Factory.ReferralInfo newReferralInfo,
        Domain.Calls.Factory.CallInfo newCallInfo,
        int onBehalfOfEmployeeId)
    {
        logger.LogCreatingReferralEntity(newReferralInfo);

        var referral = await referralFactory.CreateFromReferralInfoAsync(
            newReferralInfo,
            onBehalfOfEmployeeId);

        // TODO: Consider moving to factory.
        referral.ReferralApproachTypeId = ApproachType.Unknown;

        logger.LogCreatingCallEntity(newReferralInfo);

        var call = await callFactory.CreateFromCallInfoAsync(newCallInfo, onBehalfOfEmployeeId);

        call.CallTemp = referral.IsIncomplete ? IntegerBoolean.MinusOneTrue : IntegerBoolean.ZeroFalse;

        logger.LogSavingCallEntity(newReferralInfo);

        await callRepository.AddCallAsync(call);

        logger.LogSavedCallEntity(call.CallId, newReferralInfo);

        referral.CallId = call.CallId;

        logger.LogSavingReferralEntity(newReferralInfo);

        await referralRepository.AddReferralAsync(referral);

        logger.LogSavedReferralEntity(referral.ReferralId, newReferralInfo);

        return (referral, call);
    }

    private async Task CreateRegistryStatusForCall(Call call)
    {
        logger.LogCreatingRegistryStatus(call);

        // Registry status is initially created with the call
        // with default status type.
        await registryStatusRepository.AddRegistryStatusAsync(
            new RegistryStatus
            {
                CallId = call.CallId,
                Status = RegistryStatusType.NotChecked,
                LastStatEmployeeId = call.CallSaveLastById
            });
    }

    private Domain.Referrals.Factory.ReferralInfo FactoryReferralInfoFromReferralInfo(
        Dto.NewReferral.ReferralInfo newReferralInfo)
    {
        return mapper.Map<Domain.Referrals.Factory.ReferralInfo>(newReferralInfo);
    }

    private Domain.Calls.Factory.CallInfo FactoryCallInfoFromReferralInfo(
        Dto.NewReferral.ReferralInfo newReferralInfo)
    {
        var callInfo = newReferralInfo.CallInformation;

        return new Domain.Calls.Factory.CallInfo(
            CallTypeId.Referral,
            callInfo.CallReceivedOn,
            callInfo.CoordinatorName,
            callInfo.CallerInformation.SourceCode);
    }

    private async Task<int> GetSourceCodeIdByNameAsync(string sourceCodeName)
    {
        // I know that SourceCode lookup may happen multiple times during
        // referral creation. Still I prefer separation of concerns
        // to some performance win. The better way to improve performance
        // is to wrap the repository with caching decorator.

        int? callerSourceCodeId = await sourceCodeRepository.FindSourceCodeIdByNameAsync(
            sourceCodeName,
            SourceCodeType.Referral);

        return
            callerSourceCodeId ??
            throw new InvalidInputDataException($"Unknown source code '{sourceCodeName}' of Referral type.");
    }
}