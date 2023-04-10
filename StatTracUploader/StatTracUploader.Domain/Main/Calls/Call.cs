using System;

namespace Statline.StatTracUploader.Domain.Main.Calls
{
    public class Call
    {
        public int Id { get; set; }
        public string? CallNumber { get; set; }
        public CallType? Type { get; set; }
        public DateTimeOffset? DateTime { get; set; }
        public short? StatEmployeeId { get; set; }
        public TimeSpan? TotalTime { get; set; }
        public short? TempExclusive { get; set; }
        public short? Inactive { get; set; }
        public short? Seconds { get; set; }
        public short? Temp { get; set; }
        public int? SourceCodeId { get; set; }
        public int? OpenById { get; set; }
        public int? TempSavedById { get; set; }
        public decimal? Extension { get; set; }
        public int? OpenByWebPersonId { get; set; }
        public short? RecycleNcFlag { get; set; }
        public short? Active { get; set; }
        public int? SaveLastById { get; set; }
    }
}
