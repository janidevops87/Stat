namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.ApiClients.InContactApi.Dto.Contacts;
#pragma warning disable IDE1006 // Naming Styles

public class Contact
{
    public bool abandoned { get; set; }
    public int abandonSeconds { get; set; }
    public float ACWSeconds { get; set; }
    public int agentId { get; set; }
    public int agentSeconds { get; set; }
    public int businessUnitId { get; set; }
    public string? callbackTime { get; set; }
    public int campaignId { get; set; }
    public string campaignName { get; set; } = default!;
    public int confSeconds { get; set; }
    public long contactId { get; set; }
    public DateTimeOffset contactStart { get; set; }
    public DateTimeOffset? dateACWWarehoused { get; set; }
    public DateTimeOffset dateContactWarehoused { get; set; }
    public object dispositionNotes { get; set; } = default!;
    public string firstName { get; set; } = default!;
    public string fromAddr { get; set; } = default!;
    public int holdCount { get; set; }
    public int holdSeconds { get; set; }
    public int inQueueSeconds { get; set; }
    public bool isActive { get; set; }
    public bool isLogged { get; set; }
    public bool isOutbound { get; set; }
    public bool isRefused { get; set; }
    public bool isShortAbandon { get; set; }
    public bool isTakeover { get; set; }
    public bool isWarehoused { get; set; }
    public string lastName { get; set; } = default!;
    public DateTimeOffset lastUpdateTime { get; set; }
    public long masterContactId { get; set; }
    public int mediaSubTypeId { get; set; }
    public object mediaSubTypeName { get; set; } = default!;
    public int mediaType { get; set; }
    public string mediaTypeName { get; set; } = default!;
    public int pointOfContactId { get; set; }
    public string pointOfContactName { get; set; } = default!;
    public int postQueueSeconds { get; set; }
    public int preQueueSeconds { get; set; }
    public int? primaryDispositionId { get; set; }
    public object refuseReason { get; set; } = default!;
    public object refuseTime { get; set; } = default!;
    public int releaseSeconds { get; set; }
    public string routingTime { get; set; } = default!;
    public int? secondaryDispositionId { get; set; }
    public string serviceLevelFlag { get; set; } = default!;
    public int skillId { get; set; }
    public string skillName { get; set; } = default!;
    public string state { get; set; } = default!;
    public int stateId { get; set; }
    public int teamId { get; set; }
    public string teamName { get; set; } = default!;
    public string toAddr { get; set; } = default!;
    public int totalDurationSeconds { get; set; }
    public int transferIndicatorId { get; set; }
    public string transferIndicatorName { get; set; } = default!;
}
