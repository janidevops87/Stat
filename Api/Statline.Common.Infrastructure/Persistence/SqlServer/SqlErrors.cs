namespace Statline.Common.Infrastructure.Persistence.SqlServer
{
    /// <summary>
    /// Holds constants for SQL Server error codes.
    /// </summary>
    public enum SqlErrors
    {
        /// <summary>
        /// There already is a record with such primary key.
        /// </summary>
        DuplicateKey = 2627,

        /// <summary>
        /// Unique constraint violation.
        /// </summary>
        UniqueConstraintViolation = 2601
    }
}
