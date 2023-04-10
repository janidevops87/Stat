namespace Registry.Common.DTO
{
    public class ReportDbEntity
    {
        public string StateDisplayName { get; set; }
        public string RegistrySource { get; set; }
        public int Totals { get; set; }
        public string TotalPercent { get; set; }
        public int GrandTotal { get; set; }
    }
}