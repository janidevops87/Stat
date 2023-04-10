using System.IO;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFax.Application
{
    public interface IWordToPdfConverter
    {
        Task ConvertAsync(Stream wordDocumentStream, Stream pdfDocumentStream);
    }
}