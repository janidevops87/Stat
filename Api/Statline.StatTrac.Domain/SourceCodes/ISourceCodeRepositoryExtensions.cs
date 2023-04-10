using System.Linq;

namespace Statline.StatTrac.Domain.SourceCodes;

public static class ISourceCodeRepositoryExtensions
{
    public static async Task<bool> SourceCodeWithNameExistsAsync(
        this ISourceCodeRepository sourceCodeRepository,
        string sourceCodeName,
        SourceCodeType sourceCodeType,
        bool includeInactive = false)
    {
        Check.NotNull(sourceCodeRepository);
        Check.NotEmpty(sourceCodeName);

        return await sourceCodeRepository
            .AnySourceCodeExistsAsync(sc =>
                sc.SourceCodeName == sourceCodeName &&
                sc.SourceCodeType == sourceCodeType &&
                includeInactive ? true : sc.Inactive != true);
    }

    public static async Task<int?> FindSourceCodeIdByNameAsync(
      this ISourceCodeRepository sourceCodeRepository,
        string sourceCodeName,
        SourceCodeType sourceCodeType)
    {
        Check.NotNull(sourceCodeRepository);
        Check.NotEmpty(sourceCodeName);

        return await sourceCodeRepository.QuerySourceCodes(
            sc =>
                sc.SourceCodeName == sourceCodeName &&
                sc.SourceCodeType == sourceCodeType &&
                sc.Inactive != true,
            sc => (int?)sc.SourceCodeId).SingleOrDefaultAsync();
    }
}
