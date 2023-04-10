using System;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using Registry.Common.DTO;
using Registry.Common.Util;

namespace Registry.API.DAL
{
    public class EFEnrollmentDataProvider : EFDataProviderBase, IEnrollmentDataProvider
    {
        internal const int NoDonorRecordsFound = -1;
        internal const int MultipleDonorRecordsFound = 0;

        public async Task<Common.DTO.Registry> GetRegistry(int registryID)
        {
            using (var context = RegistryDb)
            {
                return (await ExecuteStoredProcedure<Common.DTO.Registry, Tuple<int>>("GetRegistry", Tuple.Create(registryID), context)).Single();
            }
        }

        public async Task<Common.DTO.Registry> GetFullRegistry(int registryID)
        {
            using (var context = RegistryDb)
            {
                var registry = (await ExecuteStoredProcedure<Common.DTO.Registry, Tuple<int>>("GetRegistry", Tuple.Create(registryID), context)).Single();
                var registryAddress = (await ExecuteStoredProcedure<RegistryAddressInsertUpdateParameter, Tuple<int>>("GetRegistryAddr", Tuple.Create(registryID), context)).OrderBy(x=>x.AddrTypeID).FirstOrDefault();
                var registryEvent = (await ExecuteStoredProcedure<RegistryEventInsertUpdateParameter, Tuple<int>>("GetEventRegistry", Tuple.Create(registryID), context)).Single();

                registry.Address1 = registryAddress.Addr1;
                registry.Address2 = registryAddress.Addr2;
                registry.City = registryAddress.City;
                registry.State = registryAddress.State;
                registry.Zip = registryAddress.Zip;
                registry.EventCategorySpecifyText = registryEvent.EventCategorySpecifyText;
                registry.EventCategoryID = registryEvent.EventCategoryID;
                registry.EventSubCategoryID = registryEvent.EventSubCategoryID;
                registry.EventSubCategorySpecifyText = registryEvent.EventSubCategorySpecifyText;

                return registry;
            }
        }

        public async Task<int> InsertRegistry(Common.DTO.Registry registry)
        {
            using (var context = RegistryDb)
            {
                var result = await ExecuteStoredProcedure<RegistryInsertUpdateParameter, RegistryInsertUpdateParameter>(
                    "InsertRegistry",
                    //TODO: map with AutoMapper
                    //all values in comments below are taken from SQL profiler when filling out CODA enrollment form with all available fields for that version of the form filled out
                    new RegistryInsertUpdateParameter
                    {
                        Comment = registry.Comment,
                        DeleteFlag = true,
                        DOB = registry.DOB,
                        Donor = false,
                        DonorConfirmed = false,
                        Email = registry.Email,
                        EyeColor = registry.EyeColor, //null
                        FirstName = registry.FirstName,
                        Gender = registry.Gender,
                        LastName = registry.LastName,
                        LastStatEmployeeID = -1,
                        License = registry.License,
                        Limitations = registry.Limitations,
                        LimitationsOther = registry.LimitationsOther, //null
                        MiddleName = registry.MiddleName ?? "",
                        OnlineRegDate = registry.OnlineRegDate,
                        SignatureDate = registry.OnlineRegDate, //todo: looks like a total mess
                        Phone = registry.Phone, //null
                        Race = registry.Race, //null
                        RegisteredByID = 1,
                        RegistryOwnerID = registry.RegistryOwnerID, //depends on client corresponding to login
                        SSN = registry.SSN ?? "",
                        Suffix = registry.Suffix, //null
                    }, context);

                var registryID = result?.Single().RegistryID;
                return registryID ?? 0;
            }
        }

        public async Task<int> InsertRegistryAddress(Common.DTO.Registry registry)
        {
            using (var context = RegistryDb)
            {
                return (await ExecuteStoredProcedure("InsertRegistryAddr",
                    //TODO: map with AutoMapper
                    //all values in comments below are taken from SQL profiler when filling out CODA enrollment form with all available fields for that version of the form filled out
                    new RegistryAddressInsertUpdateParameter
                    {
                        Addr1 = registry.Address1,
                        Addr2 = registry.Address2,
                        AddrTypeID = registry.AddressTypeID,//1
                        City = registry.City,
                        LastStatEmployeeID = -1,
                        RegistryID = registry.RegistryID,
                        State = registry.State,
                        Zip = registry.Zip,
                    }, context));
            }
        }

        public async Task<int> InsertRegistryEvent(Common.DTO.Registry registry)
        {
            using (var context = RegistryDb)
            {
                return (await ExecuteStoredProcedure("InsertEventRegistry",
                    //TODO: map with AutoMapper
                    //all values in comments below are taken from SQL profiler when filling out CODA enrollment form with all available fields for that version of the form filled out
                    new RegistryEventInsertUpdateParameter
                    {
                        EventCategorySpecifyText = registry.EventCategorySpecifyText,
                        EventCategoryID = registry.EventCategoryID,
                        EventSubCategoryID = registry.EventSubCategoryID,
                        EventSubCategorySpecifyText = registry.EventSubCategorySpecifyText,
                        LastStatEmployeeID = -1,
                        RegistryID = registry.RegistryID,
                    }, context));
            }
        }

        public async Task<RegistrySignature> GetRegistrySignature(int registryID)
        {
            using (var context = RegistryDb)
            {
                return (await ExecuteStoredProcedure<RegistrySignature, Tuple<int>>("GetFormElectronicSignature", Tuple.Create(registryID), context)).Single();
            }
        }

        public async Task<int> ActivateRegistree(Common.DTO.Registry registry, bool isDonor)
        {
            using (var context = RegistryDb)
            {
                return (await ExecuteStoredProcedure("UpdateRegistry",
                    //TODO: map with AutoMapper
                    new RegistryInsertUpdateParameter
                    {
                        RegistryID = registry.RegistryID,
                        FirstName = registry.FirstName,
                        LastName = registry.LastName,
                        DOB = registry.DOB,
                        Donor = isDonor,
                        DonorConfirmed = true,
                        DeleteFlag = false,
                    }, context));
            }
        }

        public async Task<int> DeactivateRegistree(Common.DTO.Registry registry)
        {
            using (var context = RegistryDb)
            {
                return (await ExecuteStoredProcedure("UpdateRegistry",
                    new RegistryInsertUpdateParameter
                    {
                        RegistryID = registry.RegistryID,
                        FirstName = registry.FirstName,
                        LastName = registry.LastName,
                        DOB = registry.DOB,
                        DonorConfirmed = false,
                        DeleteFlag = true
                    }, context));
            }
        }

        public async Task<RegistryVerification> GetRegistryVerification(RegistryVerificationRequest request)
        {
            using (var context = RegistryDb)
            {
                return (await ExecuteStoredProcedure<RegistryVerification, RegistryVerificationSelectParameter>("GetFormVerification",
                    new RegistryVerificationSelectParameter
                    {
                        SourceID = request.SourceID,
                        Source = request.Source.ToString(),
                        State = request.State,
                    }, context)).FirstOrDefault();
            }
        }

        public async Task<int> GetExistingDonor(Common.DTO.Registry registry)
        {
            using (var context = RegistryDb)
            {
                return (await ExecuteStoredProcedure("GetExistingDonor",
                    //TODO: map with AutoMapper
                    new ExistingDonorSelectParameter
                    {
                        RegistryID = registry.RegistryID.Value,
                        RegistryOwnerID = registry.RegistryOwnerID.Value,
                        FirstName = registry.FirstName,
                        LastFourSSN = (string.IsNullOrWhiteSpace(registry.SSN) ? "-" : registry.SSN),
                        LastName = registry.LastName,
                        License = registry.License ?? "-",
                        DOB = registry.DOB.Value,
                    }, context));
            }
        }

        public Databases.Registry.Entities.RegistryOwner GetRegistryOwner(int registryOwnerID)
        {
            Databases.Registry.Entities.RegistryOwner registryOwner = null;
            using (var context = RegistryDb)
            {
                registryOwner = context.RegistryOwner.Include(x => x.RegistryOwnerElectronicSignatureTexts)
                    .Where(x => x.RegistryOwnerId == registryOwnerID)
                    .Select(x => x).FirstOrDefault();
            }
            return registryOwner;
        }

        public async Task<int> InsertIDologyLog(int registryID, string IDologyLogRequest, string IDologyLogResponse)
        {
            using (var context = RegistryDb)
            {
                return (await ExecuteStoredProcedure("InsertIDologyLog",
                    new InsertIDologyLogParameter
                    {
                        IDologyLogID = 0,
                        RegistryID = registryID,
                        IDologyLogNumberID = 1,
                        IDologyLogRequest = IDologyLogRequest,
                        IDologyLogResponse = IDologyLogResponse,
                        LastStatEmployeeID = -1
                    }, context));
            }
        }

        public async Task<int> InsertRegistryDigitalCertificate(Common.DTO.Registry registry)
        {
            var digitalSignature = CreateDigitalSignature(registry);

            using (var context = RegistryDb)
            {
                return (await ExecuteStoredProcedure("InsertRegistryDigitalCertificate",
                    new RegistryDigitalCertificateInsertUpdateParameter
                    {
                        RegistryID = registry.RegistryID,
                        RegistryDigitalCertificateData = digitalSignature.SourceDataByteArray,
                        LastStatEmployeeID = -1,
                        HashAlgorithmAtTimeofSigning = digitalSignature.Algorithm.ToString(),
                        Signature = digitalSignature.Signature,
                        SignaturePublicKey = digitalSignature.PublicKey,
                    }, context));
            }
        }

        private DigitalSignature CreateDigitalSignature(Common.DTO.Registry registry)
        {
            var registryOwner = GetRegistryOwner(registry.RegistryOwnerID.Value);
            var DataToSign =
                 registryOwner.RegistryOwnerElectronicSignatureTexts.First().CertificateAuthority +
                "|IDologyID: " + 1.ToString() +
                "|Name: " + registry.GetFullName() +
                "|Address: " + registry.GetFullAddress() +
                "|Email: " + registry.Email +
                "|Timestamp: " + DateTime.Now.ToString() +
                "|Driver''s License or State ID: " + registry.License ?? "-";

            if (registryOwner.CertificateSigningHashAlgorithm == CryptographicMethods.X509Certificate.ToString())
            {
                return new DigitalSignature(DataToSign, registryOwner.CertificateSigningHashAlgorithm, registryOwner.CertificateSubject);
            }
            else
            {
                return new DigitalSignature(DataToSign, registryOwner.CertificateSigningHashAlgorithm);
            }
        }
    }
}
