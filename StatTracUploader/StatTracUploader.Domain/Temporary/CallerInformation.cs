using Statline.Common.Utilities;
using Statline.StatTracUploader.Domain.Common;

namespace Statline.StatTracUploader.Domain.Temporary
{
    public record CallerInformation
    {
        public PhoneNumber PhoneNumber { get; private set; } = null!;
        public PhoneExtension? Extension { get; private set; } = null!;
        public string HospitalName { get; }
        public PersonName CallerName { get; private set; } = null!;
        public string? Unit { get; }
        public string? Floor { get; }

        public CallerInformation(
            PhoneNumber phoneNumber,
            PhoneExtension? extension,
            string hospitalName,
            PersonName callerName,
            string? unit,
            string? floor)
           : this(
                hospitalName,
                unit,
                floor)
        {
            CallerName = Check.NotNull(callerName, nameof(callerName));
            PhoneNumber = Check.NotNull(phoneNumber, nameof(phoneNumber));
            Extension = extension;
        }

        // This is needed due to this bug: https://github.com/dotnet/efcore/issues/12078#issuecomment-391269584
        private CallerInformation(
            string hospitalName,
            string? unit,
            string? floor)
        {
            HospitalName = Check.NotEmpty(hospitalName, nameof(hospitalName));
            Unit = unit;
            Floor = floor;
        }
    }
}

