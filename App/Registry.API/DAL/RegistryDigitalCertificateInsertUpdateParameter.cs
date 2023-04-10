namespace Registry.API.DAL
{
    public class RegistryDigitalCertificateInsertUpdateParameter
    {
        public int? RegistryDigitalCertificateID { get; set; }
        public int? RegistryID { get; set; }
        public byte[] RegistryDigitalCertificateData { get; set; }
        public int? LastStatEmployeeID { get; set; }
        public string HashAlgorithmAtTimeofSigning { get; set; }
        public string SignaturePublicKey { get; set; }
        public byte[] Signature { get; set; }
    }
}
