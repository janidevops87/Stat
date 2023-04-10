using Statline.Common.Notification;
using Statline.StatTrac.BusinessVeracity.Common.Application;
using Statline.StatTrac.BusinessVeracity.Common.Application.CallInformation;
using Statline.StatTrac.BusinessVeracity.Common.Domain;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Application;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Domain;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Calls;
using Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ApiClients.VoxJarApi.Dto.Users;
using System.Dynamic;

namespace Statline.StatTrac.BusinessVeracity.QAProcessor.Infrastructure.ReferralOutput.VoxJar;

public class VoxJarReferralOutput : IReferralOutput<HighRiskReferralMetadata>
{
    private readonly IVoxJarApiClient voxJarApiClient;
    private readonly VoxJarReferralOutputOptions options;
    private readonly INotificationService notificationService;
    private readonly ILogger logger;

    public VoxJarReferralOutput(
         IVoxJarApiClient voxJarApiClient,
         IOptions<VoxJarReferralOutputOptions> options,
         INotificationService notificationService,
         ILogger<VoxJarReferralOutput> logger)
    {
        this.voxJarApiClient = Check.NotNull(voxJarApiClient, nameof(voxJarApiClient));
        this.options = Check.NotNull(options, nameof(options)).Value;
        this.notificationService = Check.NotNull(notificationService, nameof(notificationService));
        this.logger = Check.NotNull(logger, nameof(logger));
    }

    public async Task PublishAsync(
        IAsyncEnumerable<HighRiskReferralMetadata> referrals,
        ApplicationRunContext runContext)
    {
        Check.NotNull(referrals, nameof(referrals));

        var voxJarMetadata = referrals.Select(BuildVoxJarMetadata);
        
        await voxJarMetadata.ForEachAwaitAsync(UploadReferralDetailsToVoxJar).ConfigureAwait(false);
    }

    private async Task UploadReferralDetailsToVoxJar(
        MetadataContainer metadata)
    {
        try
        {
            await voxJarApiClient.UploadUsersAsync(metadata.Users).ConfigureAwait(false);
            await voxJarApiClient.UploadCallsAsync(metadata.Calls).ConfigureAwait(false);
        }
        catch (Exception ex)
        {
            // Though it's undesired catch all exceptions,
            // this is a special case. We have a requirement to send notifications on
            // any VoxJar upload errors (next line does that). To avoid
            // program crash the error is skipped, allowing to move forward.
            // Note however that in many cases next referrals and next runs will likely
            // fail again and again if the error is not transient.

            await notificationService.NotifyFailedUploadingToVoxJarAsync(metadata.ReferralId, metadata.CallId, ex).ConfigureAwait(false);

            logger.LogError(ex, "Failed to upload referral details with id '{ReferralId}' VoxJar", metadata.ReferralId);
        }
    }

    private MetadataContainer BuildVoxJarMetadata(HighRiskReferralMetadata referralMetadata)
    {
        string companyId = options.VoxJarCompanyId;

        AgentMetadataContainer agentMetadata =
            BuildAgentMetadata(referralMetadata.Agent, companyId);

        CustomerMetadataContainer customerMetadata =
            BuildCustomerMetadata(referralMetadata.Contact, options.VoxJarCompanyId);

        CallMetadataContainer callMetadata =
            BuildCallMetadata(
                referralMetadata.Referral,
                referralMetadata.HighRiskLogEvent,
                referralMetadata.Contact,
                referralMetadata.ContactPrimaryDispositionName,
                referralMetadata.ContactSecondaryDispositionName,
                referralMetadata.Agent,
                referralMetadata.AudioData,
                referralMetadata.AudioPath);

        var callsMetadata = new[]
        {
            callMetadata
        };

        var users = new UserMetadataContainer[] {
                customerMetadata,
                agentMetadata
            };

        return (callsMetadata, users, referralMetadata.Referral.ReferralId, referralMetadata.Referral.CallId);
    }

    private static CallMetadataContainer BuildCallMetadata(
        HighRiskReferralDetails referralDetails,
        ReferralLogEvent referralLogEvent,
        Contact contact,
        string? contactPrimaryDispositionName,
        string? contactSecondaryDispositionName,
        Agent agent,
        string audioData,
        string audioPath)
    {
        var metadata = new ExpandoObject();

        referralDetails.PopulateMetadata(metadata);
        referralLogEvent.PopulateMetadata(metadata);
        contact.PopulateMetadata(contactSecondaryDispositionName, audioPath, metadata);

        var callMetadata = new CallMetadataContainer
        {
            identifier = contact.MasterContactId,
            timestamp = contact.ContactStart,
            participants = new[]
            {
                    new ParticipantMetadata
                    {
                        channel = 0,
                        customers = new []{ contact.IsOutbound ? contact.FromAddr : contact.ToAddr},
                        agents = new[]{ agent.GetIdForMetadata() }
                    }
            },
            direction = contact.IsOutbound ? "OUTBOUND" : "INBOUND",
            disposition = contactPrimaryDispositionName,
            asset = new AssetMetadata
            {
                data = audioData,
                requiresSpeechRecognition = true
            },
            language = "en",
            metadata = metadata
        };

        return callMetadata;
    }

    private static AgentMetadataContainer BuildAgentMetadata(Agent agent, string comapnyId)
    {
        var agentMetadata = new AgentMetadataContainer
        {
            id = agent.GetIdForMetadata(),
            name = agent.FirstName + " " + agent.LastName,
            companyIds = new[] { comapnyId },
            metadata = agent.ToMetadataDictionary()
        };

        return agentMetadata;
    }

    private static CustomerMetadataContainer BuildCustomerMetadata(Contact contact, string comapnyId)
    {
        return new CustomerMetadataContainer
        {
            id = contact.IsOutbound ? contact.FromAddr : contact.ToAddr,
            role = "GUEST",
            companyIds = new[] { comapnyId },
        };
    }
}
