using Registry.Common.Enums;
using Registry.Common.Idology;

namespace Registry.Common.DTO
{
    public class IDologyAnswersRequest
    {
        public int RegistryID { get; set; }
        public Response Response { get; set; }
        public LanguagesEnum Language { get; set; }
    }
}
