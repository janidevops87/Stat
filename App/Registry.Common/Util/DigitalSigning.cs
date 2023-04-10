using System;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;

namespace Registry.Common.Util
{
    /// <summary>
    /// Enumeration of all Microsoft Cryptography Methods
    /// that support Digital Signing, and a custom 
    /// X509Certificate Method.
    /// </summary>
    public enum CryptographicMethods
    {
        NONE,
        MD5,
        SHA1,
        X509Certificate
    }

    /// <summary>
    /// Encapsulates all methods and functions required to produce a 
    /// Digital Signature based on the Microsoft Supported Cryptography 
    /// Methods as well as X509 Certificates.
    /// Also provides support for Validating a Digital Signature.
    /// </summary>
    public class DigitalSignature
    {
        CryptographicMethods _Algorithm;
        String _SourceData;
        Byte[] _HashedData;
        Byte[] _Signature;
        String _PublicKey;
        X509Certificate2 _Certificate;

        #region Constants - Error Messages
        const string ConstructorErrorMsg = "Digital Signature Was Not Generated";
        const string EncryptionErrorMsg = "Unsupported Encryption Type Specified for Digital Signature";
        const string CertificateErrorMsg = "No valid Certificate was found";
        #endregion

        #region Properties
        /// <summary>
        /// Read Only. Currently Selected Cryptographic Algorithm
        /// </summary>
        public CryptographicMethods Algorithm
        {
            get { return _Algorithm; }
        }
        /// <summary>
        /// Read Only. Source Data in unmodified string format
        /// </summary>
        protected String SourceData
        {
            get { return _SourceData; }
        }
        /// <summary>
        /// Read Only. Source Data as Unicode Byte Array. 
        /// Returns empty Byte Array is Source Data is empty.
        /// </summary>        
        public Byte[] SourceDataByteArray
        {
            get
            {
                if (_SourceData == null)
                {
                    return new Byte[0];
                }
                else
                {
                    return new System.Text.ASCIIEncoding().GetBytes(_SourceData);
                }
            }
        }
        /// <summary>
        /// Protected and Read Only. Resulting Hash of Source Data based on the Cryptographic Algorithm 
        /// Can only be accessed by classes that are derived from this class.
        /// </summary>
        protected Byte[] HashedData
        {
            get { return _HashedData; }
        }
        /// <summary>
        /// Read Only. When Creating Digital Signature, stores Digital Signature of 
        /// Source Data based on the Cryptographic Algorithm.
        /// When Validating Digital Signature, stores Digital Signature to be validated.
        /// </summary>
        public Byte[] Signature
        {
            get { return _Signature; }
        }
        /// <summary>
        /// Read Only. Public Key Associated with Digital Signature.
        /// </summary>
        public String PublicKey
        {
            get { return _PublicKey; }
        }
        #endregion

        #region Constructor
        /// <summary>
        /// Default Constructor
        /// </summary>
        public DigitalSignature()
        {
        }
        /// <summary>
        /// Constructor for Non-Certificate Based Digital Signatures
        /// </summary>
        /// <param name="DataToSign">Source Data that needs to be signed</param>
        /// <param name="CryptographicAlgorithm">Cryptographic Algorithm Type used to produce the Digital Signature.</param>
        public DigitalSignature(string DataToSign, string CryptographicAlgorithm)
        {
            try
            {
                SetCryptographicMethod(CryptographicAlgorithm);
                HashData(DataToSign);
                SignData();
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// Constructor for Certificate Based Digital Signature with Existing Certifcate.        
        /// </summary>
        /// <param name="DataToSign">Source Data that needs to be signed</param>
        /// <param name="SigningCertificate">X509 Compliant Certificate used to produce Digital Signature</param>
        public DigitalSignature(string DataToSign, X509Certificate2 SigningCertificate)
        {
            try
            {
                SetCryptographicMethod(CryptographicMethods.X509Certificate.ToString());
                HashData(DataToSign);
                _Certificate = SigningCertificate;
                SignData();
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// Constructor for Certificate Based Digital Signature with Certificate Store Lookup.        
        /// </summary>
        /// <param name="DataToSign">Source Data that needs to be signed</param>
        /// <param name="CryptographicAlgorithm">Cryptographic Algorithm Type used to produce the Digital Signature.</param>
        /// <param name="X509CertificateSubject">Subject of X509Certificate to be located in Certificate Store</param>
        public DigitalSignature(string DataToSign, string CryptographicAlgorithm, string X509CertificateSubject)
        {
            try
            {
                GetX509Certificate(X509CertificateSubject, true);
                SetCryptographicMethod(CryptographicAlgorithm);
                HashData(DataToSign);
                SignData();
            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// Constuctor for Validating data to a Digital Signature. 
        /// </summary>
        /// <param name="DataToValidate">Source Data who's Signature we are comparing</param>
        /// <param name="CryptographicAlgorithm">Cryptographic Algorithm Type used to produce the Digital Signature.</param>
        /// <param name="Signature">Digital Signature to compare to the Source Data</param>
        /// <param name="PublicKey">Public Key created with the Digital Signature and used to Validate the Source Data</param>
        public DigitalSignature(string DataToValidate, string CryptographicAlgorithm, byte[] Signature, string PublicKey)
        {
            try
            {
                SetCryptographicMethod(CryptographicAlgorithm);
                HashData(DataToValidate);
                _Signature = Signature;
                _PublicKey = PublicKey;
            }
            catch
            {
                throw new Exception(ConstructorErrorMsg);
            }
        }
        #endregion

        #region Private Methods
        /// <summary>
        /// Loads X509 Certificate from Certificate Store of Computer Running Application
        /// Certificate must exist and must contain the Private Key in order to Sign Data
        /// </summary>
        /// <param name="X509CertificateSubject">Subject of Certificate. Used to locate Certificate in Certificate Store</param>
        /// <param name="PrivateKeyRequired">Require Private Key as part of Certifcate. When signing data, set to True.</param>
        private void GetX509Certificate(string X509CertificateSubject, Boolean PrivateKeyRequired)
        {
            _Certificate = null;
            // Access certificate store of Local Machine
            //NOTE - StoreName and StoreLocation may need to be changed to reflect Server Setup.
            X509Store myX509Store = new X509Store(StoreName.CertificateAuthority, StoreLocation.LocalMachine);
            myX509Store.Open(OpenFlags.ReadOnly);

            // Find the certificate we'll use to sign            
            foreach (X509Certificate2 cert in myX509Store.Certificates)
            {
                if (cert.Subject.Contains(X509CertificateSubject))
                {
                    // We found it. 
                    _Certificate = cert;
                    break;
                }
            }
            if (_Certificate == null)
            {
                throw new Exception(CertificateErrorMsg);
            }
            else if (PrivateKeyRequired && _Certificate.HasPrivateKey)
            {
                try
                {
                    if (_Certificate.PrivateKey.ToString() == "Keyset does not exist\r\n")
                    {
                        throw new Exception(CertificateErrorMsg);
                    }
                }
                catch
                {
                    throw;
                }
            }
        }
        /// <summary>
        /// Converts CryptographicAlgorithm from String to Enum and set's local variable.
        /// Throws Error if unsupported type located
        /// </summary>
        /// <param name="CryptographicAlgorithm"></param>
        private void SetCryptographicMethod(string CryptographicAlgorithm)
        {
            _Algorithm = CryptographicMethods.NONE; //Default Algorithm

            foreach (CryptographicMethods CryptographicMethod in Enum.GetValues(typeof(CryptographicMethods)))
            {
                if (CryptographicMethod.ToString() == CryptographicAlgorithm.ToString())
                {
                    _Algorithm = CryptographicMethod;
                }
            }

            if (_Algorithm == CryptographicMethods.NONE)
            {
                throw new Exception(EncryptionErrorMsg);
            }
        }
        /// <summary>
        /// Converts DataToSign into a Hash based on the Cryptography Algorithm specified.
        /// Stores DataToSign in _SourceData and resulting Hash in _HashData
        /// </summary>
        /// <param name="DataToSign">Source Data that is going to be Digitally Signed</param>
        private void HashData(string DataToSign)
        {
            Byte[] SourceDataByteArray = new System.Text.ASCIIEncoding().GetBytes(DataToSign); ;
            _SourceData = DataToSign;

            if (_Algorithm == CryptographicMethods.SHA1 || _Algorithm == CryptographicMethods.X509Certificate)
            {
                SHA1Managed SHhash = new SHA1Managed();
                _HashedData = SHhash.ComputeHash(SourceDataByteArray);
            }
            else
            {
                throw new Exception(EncryptionErrorMsg);
            }
        }
        /// <summary>
        /// Performs actual Digital Signature based on the Cryptographic Algorithm specified.
        /// Stores resulting Digital Signature in _Signature and Public Key in _PublicKey
        /// </summary>
        private void SignData()
        {
            //Create ServiceProvider
            RSACryptoServiceProvider RSA = null;

            switch (_Algorithm)
            {
                case CryptographicMethods.SHA1:
                    //Generate a new public/private key pair.
                    RSA = new RSACryptoServiceProvider();
                    //Save the Public Key                    
                    _PublicKey = RSA.ToXmlString(false);
                    break;

                case CryptographicMethods.X509Certificate:
                    //Load Private Key from Certificate into ServiceProvider
                    RSA = (RSACryptoServiceProvider)_Certificate.PrivateKey;
                    //Save the Public Key
                    _PublicKey = _Certificate.PublicKey.Key.ToXmlString(false);
                    break;

                default:
                    throw new Exception(EncryptionErrorMsg);
            }

            //Sign the hashed data using the SHA1 Algorithm
            _Signature = RSA.SignHash(_HashedData, CryptographicMethods.SHA1.ToString());
        }
        #endregion

        #region Public Methods
        /// <summary>
        /// Performs DigitalSignature Validation based on the Cryptographic Algorithm. Used to verify SourceData has not changed since originally signed.
        /// </summary>
        /// <returns>Returns True if SourceData and Digital Signature Match (Source Data is unchanged). Returns False for all other reason.</returns>
        public Boolean IsValid()
        {
            Boolean validSignature = false;
            //Create New Service Provider
            RSACryptoServiceProvider RSA = new RSACryptoServiceProvider();
            try
            {
                //load public key into RSA provider
                if (_Algorithm == CryptographicMethods.SHA1 || _Algorithm == CryptographicMethods.X509Certificate)
                {
                    RSA.FromXmlString(_PublicKey);
                }
                else
                {
                    throw new Exception(EncryptionErrorMsg);
                }

                //Load Public Key from Certificate into Signature Deformatter 
                RSAPKCS1SignatureDeformatter rsaSignatureDeformatter = new RSAPKCS1SignatureDeformatter(RSA);

                //Set Cryptographic Algorhithm - only supporting SHA1 
                rsaSignatureDeformatter.SetHashAlgorithm(CryptographicMethods.SHA1.ToString());

                //validate signature
                validSignature = rsaSignatureDeformatter.VerifySignature(_HashedData, _Signature);
            }
            catch
            {
                throw;
            }
            return validSignature;
        }
        #endregion
    }
}
