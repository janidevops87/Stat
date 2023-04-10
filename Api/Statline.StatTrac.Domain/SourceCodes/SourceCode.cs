namespace Statline.StatTrac.Domain.SourceCodes;

public class SourceCode
{
    public int SourceCodeId { get; set; }
    public string? SourceCodeName { get; set; }
    public string? SourceCodeDescription { get; set; }
    public DateTime? LastModified { get; set; }
    public SourceCodeType? SourceCodeType { get; set; }
    public string? SourceCodeDefaultAlert { get; set; }
    public string? SourceCodeLineCheckInstruc { get; set; }
    public int? SourceCodeLineCheckInterval { get; set; }
    public string? SourceCode1Start { get; set; }
    public string? SourceCode1End { get; set; }
    public string? SourceCode2Start { get; set; }
    public string? SourceCode2End { get; set; }
    public string? SourceCode3Start { get; set; }
    public string? SourceCode3End { get; set; }
    public string? SourceCode4Start { get; set; }
    public string? SourceCode4End { get; set; }
    public string? SourceCode5Start { get; set; }
    public string? SourceCode5End { get; set; }
    public string? SourceCode6Start { get; set; }
    public string? SourceCode6End { get; set; }
    public string? SourceCode7Start { get; set; }
    public string? SourceCode7End { get; set; }
    public short SourceCodeDisabledInterval { get; set; }
    public string? SourceCodeNameUnAbbrev { get; set; }
    public short? SourceCodeRotationActive { get; set; }
    public string? SourcecodeRotationAlias { get; set; }
    public short? SourcecodeRotationTrue { get; set; }
    public short? SourcecodeDonorTracClient { get; set; }
    public bool? SourceCodeDefault { get; set; }
    public bool? Inactive { get; set; }
    public int? LastStatEmployeeId { get; set; }
    public int? AuditLogTypeId { get; set; }
    public int? SourceCodeOrgId { get; set; }
    public int? SourceCodeCallTypeId { get; set; }
}
