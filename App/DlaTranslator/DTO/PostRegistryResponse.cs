using Registry.Common.Enums;
using Registry.Common.Idology;

namespace Registry.Common.DTO
{
    public class PostRegistryResponse
    {
        public int? RegistryID { get; set; }
		public RegistryApiError RegistryApiResult { get; set; }
		public Response Response { get; set; }
	}
}
