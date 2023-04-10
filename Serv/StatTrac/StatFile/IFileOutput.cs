using System;
using System.IO;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFile
{
    /// <summary>
    /// An abstraction for storing exported files without coupling 
    /// to specific storage mechanism.
    /// </summary>
    public interface IFileOutput
    {
        /// <summary>
        /// Prepares a stream to write a file and calls <paramref name="writerCallbackfilePath"/>
        /// passing the stream.
        /// </summary>
        /// <param name="filePath">The path where the file should be stored. 
        /// If the path is rooted it will be mapped to the underlying storage 
        /// root folder. The directories in the path must exist.
        /// </param>
        /// <param name="writerCallback">The callback which will do file content write.</param>
        /// <exception cref="FileOutputDirectoryNotFoundException">
        /// Is thrown if any of the directories in the <paramref name="filePath"/>
        /// doesn't exist.
        /// </exception>
        Task WriteToFileAsync(string filePath, Func<Stream, Task> writerCallback);
    }
}
