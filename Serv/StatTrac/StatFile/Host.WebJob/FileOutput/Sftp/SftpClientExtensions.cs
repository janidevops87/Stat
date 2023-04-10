using Renci.SshNet;
using Renci.SshNet.Sftp;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFile.Host.WebJob.FileOutput.Sftp
{
    // TODO: This class contains ugly wrappers for calling 
    // synchronous methods asynchronously, 
    // since the SFTP library doesn't 
    // provide (yet) async version of this operation.
    // See https://github.com/sshnet/SSH.NET/issues/153.
    // These don't help with scalability but allow
    // clean and predictable code in calling async methods.
    internal static class SftpClientExtensions
    {
        public static async Task ConnectAsync(
            this SftpClient sftpClient,
            CancellationToken cancellationToken = default)
        {
            await Task.Run(
                () => sftpClient.Connect(),
                cancellationToken).ConfigureAwait(false);
        }

        public static async Task<bool> ExistsAsync(
            this SftpClient sftpClient,
            string path,
            CancellationToken cancellationToken = default)
        {
            return await Task.Run(
                () => sftpClient.Exists(path),
                cancellationToken).ConfigureAwait(false);
        }

        public static async Task<SftpFileStream> CreateAsync(
            this SftpClient sftpClient,
            string filePath,
            CancellationToken cancellationToken = default)
        {
            return await Task.Run(
                () => sftpClient.Create(filePath),
                cancellationToken).ConfigureAwait(false);
        }

        public static async Task CreateDirectoryAsync(
            this SftpClient sftpClient,
            string directoryPath,
            CancellationToken cancellationToken = default)
        {
            await Task.Run(
                () => sftpClient.CreateDirectory(directoryPath),
                cancellationToken).ConfigureAwait(false);
        }
    }
}
