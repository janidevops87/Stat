using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure.Storage.RetryPolicies;
using Statline.Framework;
using Statline.Framework.Interfaces;
using System;
using System.Configuration;
using System.IO;

namespace Statline.Framework.Repository
{
    public class AzureBlobStorage : IStorage
    {
        public static string StorageAccountName = ConfigurationManager.AppSettings["storageAccount"].ToString();
        public static string StorageContainer = ConfigurationManager.AppSettings["storageContainer"].ToString();

        private CloudStorageAccount storageAccount;
        private CloudBlobClient blobClient;
        private CloudBlobContainer container;
        public AzureBlobStorage()
        {
            storageAccount = CloudStorageAccount.Parse(BaseIdentity.ApplicationSecrets[StorageAccountName]);
            blobClient = storageAccount.CreateCloudBlobClient();
            blobClient.DefaultRequestOptions.RetryPolicy = new LinearRetry(TimeSpan.FromMilliseconds(2000), 3);
            container = blobClient.GetContainerReference(StorageContainer);
        }
        public void UploadFile(string fileName, byte[] content)
        {
            CloudBlockBlob blockBlob = container.GetBlockBlobReference(fileName);
            blockBlob.UploadFromByteArray(content, 0, content.Length);
        }

        public Stream DownloadFile(string fileName)
        {
            CloudBlockBlob blockBlob = container.GetBlockBlobReference(fileName);
            Stream stream = new MemoryStream();
            blockBlob.DownloadToStream(stream);
            return stream;
        }

        public void DeleteFile(string fileName)
        {
            CloudBlockBlob blockBlob = container.GetBlockBlobReference(fileName);
            blockBlob.DeleteIfExists();
        }
    }
}