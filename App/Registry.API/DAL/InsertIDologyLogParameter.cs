namespace Registry.API.DAL
{
	public class InsertIDologyLogParameter
	{
		public int? IDologyLogID { get; set; }
		public int? RegistryID { get; set; }
		public int? IDologyLogNumberID { get; set; }
		public string IDologyLogRequest { get; set; }
		public string IDologyLogResponse { get; set; }
		public int? LastStatEmployeeID { get; set; }
	}
}
