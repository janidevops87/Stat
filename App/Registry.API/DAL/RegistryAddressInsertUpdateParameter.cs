namespace Registry.API.DAL
{
    public class RegistryAddressInsertUpdateParameter
    {
        public int? RegistryAddrID { get; set; }
        public int? RegistryID { get; set; }
        public int? AddrTypeID { get; set; }
        public string Addr1 { get; set; }
        public string Addr2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
        public int? LastStatEmployeeID { get; set; }
    }
}
