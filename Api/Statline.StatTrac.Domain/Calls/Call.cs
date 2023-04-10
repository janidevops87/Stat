using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Calls;

/// <dev>
/// This entity resembles corresponding DB table. 
/// </dev>
public sealed class Call
{
    // TODO: Make this internal after ensuring mapper works correctly.
    public Call() { }

    public int CallId { get; set; }
    public string? CallNumber { get; set; }
    public int? CallTypeId { get; set; }
    public DateTimeOffset? CallDateTime { get; set; }
    public short? StatEmployeeId { get; set; }
    public TimeSpan? CallTotalTime { get; set; }
    public IntegerBoolean? CallTempExclusive { get; set; }
    public short? Inactive { get; set; }
    public short? CallSeconds { get; set; }
    public DateTimeOffset? LastModified { get; set; }

    // This property maps to "Incomplete" checkbox in
    // StatTrac, but essentially means "RequiresAttention",
    // and probably should be renamed to that. It gets value
    // of True when there is lack of some data fields
    // (incomplete data) OR if the user needs somebody
    // else to review the case.
    // Here is Sara's explanation for the second condition
    // (in the context of StatTrac):
    // "Users do like to mark it incomplete sometimes when they
    // need someone to review the case. Like a new coordinator
    // asking their supervisor to review their work. The incomplete
    // checkbox actually saves the case in the middle window on
    // the dashboard, so it can basically be added to a place
    // for others to review"
    // So even though it maps to "Incomplete" checkbox in StatTrac,
    // it's not only that, as you can see.
    //
    // TODO: The property should be refactored so it can't be freely
    // assigned. It should allow to set it to true (e.g. SetRequiresAttention),
    // but should not allow to reset it to false (e.g. ClearRequiresAttention)
    // if data is still incomplete. This can be done after making Referral
    // inherit Call (and merging all related code).
    public IntegerBoolean? CallTemp { get; set; }
    public int? SourceCodeId { get; set; }
    public int? CallOpenById { get; set; }
    public int? CallTempSavedById { get; set; }
    public decimal? CallExtension { get; set; }
    public short? UpdatedFlag { get; set; }
    public int? CallOpenByWebPersonId { get; set; }
    public short? RecycleNcFlag { get; set; }
    public short? CallActive { get; set; }
    public int? CallSaveLastById { get; set; }
    public AuditLogType? AuditLogTypeId { get; set; }

    public CallType? CallType { get; set; }
}
