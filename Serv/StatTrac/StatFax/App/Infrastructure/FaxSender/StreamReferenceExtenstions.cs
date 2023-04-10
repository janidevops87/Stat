using System.IO;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFax.Infrastructure.FaxSender
{
    internal static class StreamReferenceExtenstions
    {
        public static async Task<byte[]> ReadAllBytesAsync(this IStreamReference streamReference)
        {
            using var bodyStream = await streamReference.OpenReadAsync().ConfigureAwait(false);
            using var reader = new BinaryReader(bodyStream);

            // Async reading is not supported yet: https://github.com/dotnet/corefx/issues/8382.
            // May fail if the stream can't report length.
            return reader.ReadBytes((int)bodyStream.Length);
        }
    }
}
