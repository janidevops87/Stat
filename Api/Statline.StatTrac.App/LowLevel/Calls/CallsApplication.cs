using AutoMapper;
using Statline.StatTrac.Domain.Calls;
using Statline.StatTrac.Domain.RegistryStatuses;

namespace Statline.StatTrac.App.LowLevel.Calls;

public class CallsApplication
{
    private readonly ICallRepository callRepository;
    private readonly IRegistryStatusRepository registryStatusRepository;
    private readonly IMapper mapper;

    public CallsApplication(
        ICallRepository callRepository,
        IRegistryStatusRepository registryStatusRepository,
        IMapper mapper)
    {
        this.callRepository = Check.NotNull(callRepository, nameof(callRepository));
        this.mapper = Check.NotNull(mapper, nameof(mapper));
        this.registryStatusRepository = Check.NotNull(registryStatusRepository, nameof(registryStatusRepository));
    }

    public async Task<CallInfo?> FindCallByIdAsync(int callId)
    {
        return await callRepository.FindCallAsync(callId,
            // Use mapper if most of fields are returned.
            // Manual mapping results in returning only needed fields
            // from DB.
            call => new CallInfo
            {
                Id = call.CallId,
                Type = call.CallType!.CallTypeName,
                CallNumber = call.CallNumber,
                DateTime = call.CallDateTime,
                TotalTime = call.CallTotalTime
            });
    }

    public async Task<int> AddCallAsync(NewCallInfo newCall)
    {
        Check.NotNull(newCall, nameof(newCall));

        var call = mapper.Map<Call>(newCall);

        await callRepository.AddCallAsync(call);

        // It feels to me that Registry Status at least logically
        // should belong to Call, since there is one-to-one relationship
        // between them, and a Call always has corresponding Registry Status.
        // On the other hand, Registry Status is too simple entity to be
        // exposed as dedicated application feature (API).
        // Here registry status is initially created with the call
        // with default status type.
        await registryStatusRepository.AddRegistryStatusAsync(
            new RegistryStatus
            {
                CallId = call.CallId,
                Status = RegistryStatusType.NotChecked,
                LastStatEmployeeId = call.CallSaveLastById
            });

        return call.CallId;
    }
}
