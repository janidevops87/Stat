using System;
using System.IO;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFile.Windows.Service
{
    /// <summary>
    /// The default implementation which resembles how 
    /// original code was producing files.
    /// </summary>
    internal class LocalFileOutput : IFileOutput
    {
        public async Task WriteToFileAsync(string filePath, Func<Stream, Task> writerCallback)
        {
            try
            {
                await WriteToFileCore(filePath, writerCallback).ConfigureAwait(false);
            }
            catch (DirectoryNotFoundException)
            {
                // Lazily create directories.
                Directory.CreateDirectory(Path.GetDirectoryName(filePath));
                await WriteToFileCore(filePath, writerCallback).ConfigureAwait(false);
            }
        }

        private static async Task WriteToFileCore(string filePath, Func<Stream, Task> writerCallback)
        {
            using (var stream = File.OpenWrite(filePath))
            {
                await writerCallback(stream).ConfigureAwait(false);
            }
        }
    }
}
