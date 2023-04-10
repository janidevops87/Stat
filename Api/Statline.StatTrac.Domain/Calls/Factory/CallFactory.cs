using Statline.StatTrac.Domain.Common;
using Statline.StatTrac.Domain.Persons;
using Statline.StatTrac.Domain.SourceCodes;
using System.Linq;

namespace Statline.StatTrac.Domain.Calls.Factory;

public sealed class CallFactory
{
    private readonly ISourceCodeRepository sourceCodeRepository;
    private readonly IPersonRepository personRepository;

    public CallFactory(
        ISourceCodeRepository sourceCodeRepository,
        IPersonRepository personRepository)
    {
        this.sourceCodeRepository = Check.NotNull(sourceCodeRepository);
        this.personRepository = Check.NotNull(personRepository);
    }

    public Call CreateWithDefaultValues()
    {
        // Some of properties of call are expected to have
        // default non-null values when values are not provided.
        // So unless client later explicitly assigns such property
        // with null it will have default value.
        return new Call
        {
            #pragma warning disable format
            CallTotalTime     = TimeSpan.Zero,
            CallSeconds       = DefaultValues.Zero,
            CallTemp          = IntegerBoolean.ZeroFalse,
            CallTempExclusive = IntegerBoolean.ZeroFalse,
            CallOpenById      = DefaultValues.MinusOne,
            RecycleNcFlag     = DefaultValues.MinusOne,
            CallActive        = DefaultValues.MinusOne,
            #pragma warning restore format
        };
    }

    public Call CreateFromRawCallInfo(RawCallInfo callInfo, int onBehalfOfEmployeeId)
    {
        Check.NotNull(callInfo);

        var call = CreateWithDefaultValues();

        call.CallTypeId = (int)callInfo.CallTypeId;
        call.CallDateTime = callInfo.CallReceivedOn;
        call.StatEmployeeId = (short?)callInfo.CoordinatorEmployeeId;
        call.SourceCodeId = callInfo.CallerSourceCodeId;
        call.CallSaveLastById = onBehalfOfEmployeeId;

        return call;
    }

    public async Task<Call> CreateFromCallInfoAsync(CallInfo callInfo, int onBehalfOfEmployeeId)
    {
        await personRepository.ValidateEmployeeIdAsync(onBehalfOfEmployeeId);

        var rawCallInfo = await BuildRawCallInfoAsync(
            callInfo,
            defaultCoordinatorEmployeeId: onBehalfOfEmployeeId);

        var call = CreateFromRawCallInfo(rawCallInfo, onBehalfOfEmployeeId);

        return call;
    }

    private async Task<RawCallInfo> BuildRawCallInfoAsync(
        CallInfo callInfo,
        int defaultCoordinatorEmployeeId)
    {
        int callerSourceCodeId = await GetSourceCodeIdByNameAsync(callInfo.CallerSourceCode);

        int coordinatorEmployeeId = callInfo.CoordinatorName is null ?
            defaultCoordinatorEmployeeId :
            await GetSingleEmployeeIdOrDefaultAsync(
                callInfo.CoordinatorName,
                defaultCoordinatorEmployeeId);

        return new RawCallInfo
        {
            CallTypeId = callInfo.CallTypeId,
            CallerSourceCodeId = callerSourceCodeId,
            CallReceivedOn = callInfo.CallReceivedOn,
            CoordinatorEmployeeId = coordinatorEmployeeId,
        };
    }

    private async Task<int> GetSourceCodeIdByNameAsync(string sourceCodeName)
    {
        int? callerSourceCodeId = await sourceCodeRepository.FindSourceCodeIdByNameAsync(
            sourceCodeName,
            SourceCodeType.Referral);

        return
            callerSourceCodeId ??
            throw new InvalidInputDataException($"Unknown source code '{sourceCodeName}' of Referral type.");
    }

    private async Task<int> GetSingleEmployeeIdOrDefaultAsync(
        PersonName employeeName,
        int defaultEployeeId)
    {
        var candidateEmployees = await FindEmployeesAsync(employeeName);

        return candidateEmployees.Count switch
        {
            1 => candidateEmployees.First(),
            _ => defaultEployeeId
        };
    }

    private async Task<IReadOnlyCollection<int>> FindEmployeesAsync(PersonName personName)
    {
        return await personRepository.GetFilteredEmployeePersons(
            new EmployeeFilterCriteria(
                    personName.FirstName,
                    personName.LastName,
                    ActiveStateFilter.ActiveOnly),
            person => person.StatEmployee!.StatEmployeeId)
            .ToArrayAsync();
    }
}
