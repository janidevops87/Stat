namespace Statline.StatTracUploader.Infrastructure.FileParsers.Excel
{
    internal record RawCallerInformation(
        string PhoneNumber,
        string? Extension,
        string HospitalName,
        string CallerFirstName,
        string CallerLastName,
        string? Unit,
        string? Floor);
}

