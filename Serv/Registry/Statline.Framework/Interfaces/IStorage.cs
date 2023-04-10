using System.IO;

namespace Statline.Framework.Interfaces
{
    public interface IStorage
    {
        void UploadFile(string fileName, byte[] content);
        Stream DownloadFile(string fileName);
        void DeleteFile(string fileName);
    }
}