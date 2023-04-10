using Statline.StatTrac.Api.ViewModels.Common;
using Statline.StatTrac.Domain.LogEvents;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.Api.ViewModels.HighLevel.LogEvents.NewLogEvent;

public class LogEventViewModel
{
    [Range(1, int.MaxValue)]
    public int CallId { get; set; }
    [Range(Domain.Organizations.OrganizationId.MinValue, int.MaxValue)]
    public int OrganizationId { get; set; }
    public LogEventTypeId Type { get; set; }
    public bool CallbackPending { get; set; }
    public PersonNameViewModel? FromToPersonName { get; set; }
    public string? Description { get; set; }
}
