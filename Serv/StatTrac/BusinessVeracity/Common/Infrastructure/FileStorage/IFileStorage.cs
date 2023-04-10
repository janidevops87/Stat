namespace Statline.StatTrac.BusinessVeracity.Common.Infrastructure.FileStorage;

public interface IFileStorage
{
    /// <summary>
    /// Opens a file by name and calls provided delegate 
    /// passing it a stream to write file content to.
    /// </summary>
    /// <param name="writeCallback">The callback which will write file content.</param>
    /// <param name="name">File name.</param>
    /// <dev>
    /// Why that complicated method signature you may ask. That is because
    /// different storage implementations deal with file writing very differently.
    /// E.g. local file system implementation will just provide a <see cref="FileStream"/>
    /// to write to; cloud providers such as Amazon S3 will need a stream to read from 
    /// while uploading a file. So it's hard to provide a unified signature which can be implemented 
    /// efficiently. E.g:
    /// 
    /// 1. Accepting a stream to read from: "Task CreateFromStreamAsync(Stream stream, string name)"
    ///     - Stream providing implementation (<see cref="FileStream"/>) would 
    ///     copy from supplied stream to the file stream.
    ///     - Stream uploading implementation would just read supplied stream directly.
    ///     - Sounds not that bad, but calling code will need to use some temporary buffering stream 
    ///     like <see cref="MemoryStream"/> (high memory consumption) or 
    ///     a mediator stream (complicated calling code, having to solve 
    ///     the problem of underlying technology).
    ///     
    /// 2. Returning a stream to write to: "Task<Stream> OpenWriteAsync(string name)"
    ///     - Stream providing implementation (<see cref="FileStream"/>) would 
    ///     just return the file stream.
    ///     - Stream uploading implementation would have to use some temporary buffering stream 
    ///     like <see cref="MemoryStream"/> (high memory consumption) or 
    ///     a mediator stream. But this is not that easy: after the stream is returned, 
    ///     the implementation needs to do reading the stream asynchronously while 
    ///     the calling code is writing to it. This can be done in background, but the calling
    ///     code will never know if the file was written to the storage successfully.
    /// 
    /// This signature is closer to approach 2, however it not only provides a stream to write to,
    /// but also allows calling code to wait for whole file write operation completion.
    /// </dev>
    Task OpenAndWriteAsync(Func<Stream, Task> writeCallback, string name);
}
