namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Contacts;
#pragma warning disable IDE1006 // Naming Styles

public class CompletedContact
{
    public bool abandoned { get; set; }
    public int abandonSeconds { get; set; }
    public int ACWSeconds { get; set; }
    public int agentId { get; set; }
    public int agentSeconds { get; set; }
    public int? callbackTime { get; set; }
    public int campaignId { get; set; }
    public string campaignName { get; set; } = default!;
    public int confSeconds { get; set; }
    public long contactId { get; set; }
    public DateTimeOffset contactStart { get; set; }
    public DateTimeOffset? dateACWWarehoused { get; set; }
    public DateTimeOffset dateContactWarehoused { get; set; }
    public string dispositionNotes { get; set; } = default!;
    public string firstName { get; set; } = default!;
    public string fromAddr { get; set; } = default!;
    public int holdCount { get; set; }
    public int holdSeconds { get; set; }
    public int inQueueSeconds { get; set; }
    public bool isLogged { get; set; }
    public bool isOutbound { get; set; }
    public bool isRefused { get; set; }
    public bool isShortAbandon { get; set; }
    public bool isTakeover { get; set; }
    public string lastName { get; set; } = default!;
    public DateTimeOffset lastUpdateTime { get; set; }
    public long masterContactId { get; set; }
    public int mediaType { get; set; }
    public string mediaTypeName { get; set; } = default!;
    public int pointOfContactId { get; set; }
    public string pointOfContactName { get; set; } = default!;
    public int postQueueSeconds { get; set; }
    public int preQueueSeconds { get; set; }
    public int? primaryDispositionId { get; set; }
    public string refuseReason { get; set; } = default!;
    public DateTimeOffset? refuseTime { get; set; }
    public int releaseSeconds { get; set; }
    public int routingTime { get; set; }
    public object secondaryDispositionId { get; set; } = default!;
    public int serviceLevelFlag { get; set; }
    public int skillId { get; set; }
    public string skillName { get; set; } = default!;
    public int teamId { get; set; }
    public string teamName { get; set; } = default!;
    public string toAddr { get; set; } = default!;
    public int totalDurationSeconds { get; set; }
    public int transferIndicatorId { get; set; }
    public string transferIndicatorName { get; set; } = default!;
    public bool isAnalyticsProcessed { get; set; }
    public object analyticsProcessedDate { get; set; } = default!;
}
