namespace Registry.Common.DTO
{
    public class GetClientStateRequest
    {
        public int? RegistryOwnerStateConfigID { get; set; }
        public int? RegistryOwnerID { get; set; }
        public bool? DisplayAllStates { get; set; }
    }
}
