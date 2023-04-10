using DocumentFormat.OpenXml.Packaging;
using Microsoft.Extensions.Options;
using Statline.Common.Utilities;
using Statline.StatTracUploader.App.Uploader;
using Statline.StatTracUploader.App.Uploader.ReferralFileParser;
using Statline.StatTracUploader.Domain.Common;
using Statline.StatTracUploader.Domain.Temporary;
using Statline.StatTracUploader.Infrastructure.FileParsers.Common;
using Statline.StatTracUploader.Infrastructure.FileParsers.Excel.Extensions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace Statline.StatTracUploader.Infrastructure.FileParsers.Excel
{
    public class ExcelReferralFileParser : IReferralFileParser
    {
        private readonly TimeZoneInfo timeZone;

        public ExcelReferralFileParser(
            IOptions<ExcelReferralFileParserOptions> options)
        {
            Check.NotNull(options, nameof(options));
            timeZone = LoadTimeZoneInfo(options.Value);
        }

        public async Task<ReferralFileParserResult> ParseAsync(
            InputReferralInfo inputReferralInfo)
        {
            Check.NotNull(inputReferralInfo, nameof(inputReferralInfo));

            var excelDocumentData = inputReferralInfo.Data;

            var definedNamedValues = await GetNamedValuesFromExcelDocument(excelDocumentData).ConfigureAwait(false);

            var errors = new List<ReferralFileParserException>();

            // Parse referral in two phases:
            // 1: Get the raw data as it's represented in the excel document.
            //  a) check if required fields are filled;
            //  b) check if the fields can be parsed as expected primitive data types;
            // 2: Parsing the raw referral model to higher level, more strongly typed model.
            //  a) check dependencies between fields (e.g. Age and AgeUnit);
            //  b) parse enums;
            //  c) combine some fields into separate objects.
            //
            // After each stage check for gathered errors.

            var rawReferral = ParseRawReferral(definedNamedValues, errors);

            if (errors.Any())
            {
                return ReferralFileParserResult.Failed(errors);
            }

            var referral = GetReferral(rawReferral, errors);

            if (errors.Any())
            {
                return ReferralFileParserResult.Failed(errors);
            }

            return ReferralFileParserResult.Ok(referral);
        }

        private RawReferral ParseRawReferral(
            Dictionary<string, string?> namedValues,
            IList<ReferralFileParserException> errors)
        {
            return new RawReferral
            (
                DonorPerson: new RawReferralDonorPerson
                (
                    FirstName: HandleErrors(() => namedValues.GetOptionalString(KnownDefinedNames.First_Name_Value), errors),
                    LastName: HandleErrors(() => namedValues.GetOptionalString(KnownDefinedNames.Last_Name_Value), errors),
                    DateOfBirth: HandleErrors(() => namedValues.GetOptionalDateTime(KnownDefinedNames.DOB_Value)?.ToDateTimeOffset(timeZone), errors),
                    Age: HandleErrors(() => namedValues.GetOptionalInteger(KnownDefinedNames.Age_Value), errors),
                    AgeUnit: HandleErrors(() => namedValues.GetOptionalString(KnownDefinedNames.Age_Unit_Value), errors),
                    Race: HandleErrors(() => namedValues.GetOptionalString(KnownDefinedNames.Race_Value), errors),
                    Gender: HandleErrors(() => namedValues.GetOptionalString(KnownDefinedNames.Gender_Value), errors),
                    Weight: HandleErrors(() => namedValues.GetOptionalFloat(KnownDefinedNames.Weight_Value), errors),
                    MedicalRecordNumber: HandleErrors(() => namedValues.GetOptionalString(KnownDefinedNames.MRN_Value), errors)
                ),

                CallerInformation: new RawCallerInformation
                (
                    Unit: HandleErrors(() => namedValues.GetOptionalString(KnownDefinedNames.Unit_Value), errors),
                    Floor: HandleErrors(() => namedValues.GetOptionalString(KnownDefinedNames.Floor_Value), errors),
                    PhoneNumber: HandleErrors(() => namedValues.GetRequiredString(KnownDefinedNames.Phone_Value), errors),
                    Extension: HandleErrors(() => namedValues.GetOptionalString(KnownDefinedNames.Extension_Value), errors),
                    HospitalName: HandleErrors(() => namedValues.GetRequiredString(KnownDefinedNames.Hospital_Name_Value), errors),
                    CallerFirstName: HandleErrors(() => namedValues.GetRequiredString(KnownDefinedNames.Caller_First_Name_Value), errors),
                    CallerLastName: HandleErrors(() => namedValues.GetRequiredString(KnownDefinedNames.Caller_Last_Name_Value), errors)
                ),

                PagingInformation: new RawPagingInformation
                (
                    PagedToClient: HandleErrors(() => namedValues.GetOptionalBoolean(
                        KnownDefinedNames.Paged_To_Client_Value), errors),
                    PagedToClientOn: HandleErrors(() => namedValues.GetOptionalDateTime(
                        KnownDefinedNames.Date_Value, // Assume the same date as for CallReceivedOn.,
                        KnownDefinedNames.Paged_To_Client_Time_Value)?.ToDateTimeOffset(timeZone), errors),
                    RePagedToClientOn: HandleErrors(() => namedValues.GetOptionalDateTime(
                        KnownDefinedNames.Date_Value, // Assume the same date as for CallReceivedOn.
                        KnownDefinedNames.Re_Paged_To_Client_Time_Value)?.ToDateTimeOffset(timeZone), errors),
                    ReceivedBy: HandleErrors(() => namedValues.GetOptionalString(
                        KnownDefinedNames.Received_By_Value), errors),
                    PagedBy: HandleErrors(() => namedValues.GetOptionalString(
                        KnownDefinedNames.Paged_By_Value), errors),
                    ReferralPagedToHospital: HandleErrors(() => namedValues.GetOptionalBoolean(
                        KnownDefinedNames.Referral_Paged_To_Hospital_Value), errors)
                ),

                IsUpdate: HandleErrors(() => namedValues.GetOptionalBoolean(
                    KnownDefinedNames.Update_Value,
                    defaultValue: false), errors),
                CallerSourceCode: HandleErrors(() => namedValues.GetRequiredString(
                    KnownDefinedNames.Source_Code_Value), errors),
                CallReceivedOn: HandleErrors(() => namedValues.GetRequiredDateTime(
                     KnownDefinedNames.Date_Value,
                     KnownDefinedNames.Time_Value).ToDateTimeOffset(timeZone), errors),
                CoordinatorFirstName: HandleErrors(() => namedValues.GetRequiredString(
                    KnownDefinedNames.TC_Coordinator_First_Name_Value), errors),
                CoordinatorLastName: HandleErrors(() => namedValues.GetRequiredString(
                    KnownDefinedNames.TC_Coordinator_Last_Name_Value), errors),
                Heartbeat: HandleErrors(() => namedValues.GetRequiredBoolean(
                    KnownDefinedNames.Heartbeat_Value), errors),
                Vent: HandleErrors(() => namedValues.GetRequiredString(
                    KnownDefinedNames.Vent_Value), errors),
                ExtubationAt: HandleErrors(() => namedValues.GetOptionalDateTimeWithIgnoringTimeOnly(
                    KnownDefinedNames.Extubation_Date_Value,
                    KnownDefinedNames.Extubation_Time_Value)?.ToDateTimeOffset(timeZone), errors),
                DeclaredCardiacTimeOfDeath: HandleErrors(() => namedValues.GetOptionalDateTimeWithIgnoringTimeOnly(
                    KnownDefinedNames.Declared_CTOD_Date_Value,
                    KnownDefinedNames.Declared_CTOD_Time_Value), errors),
                AdmittedOn: HandleErrors(() => namedValues.GetOptionalDateTimeWithIgnoringTimeOnly(
                    KnownDefinedNames.Admit_Date_Value,
                    KnownDefinedNames.Admit_Time_Value), errors),
                CauseOfDeath: HandleErrors(() => namedValues.GetOptionalString(
                    KnownDefinedNames.COD_Value), errors),
                MedicalHistory: HandleErrors(() => namedValues.GetOptionalString(
                    KnownDefinedNames.Medical_Hx_Value), errors),
                ReferralNumer: HandleErrors(() => namedValues.GetOptionalInteger(
                    KnownDefinedNames.Referral_Value), errors),
                EnteredOn: HandleErrors(() => namedValues.GetOptionalDateTime(
                    KnownDefinedNames.Date_Value, // Assume the same date as for CallReceivedOn.
                    KnownDefinedNames.Time_Entered_Value)?.ToDateTimeOffset(timeZone), errors)
            );
        }

        // The goal of this method is to gather errors
        // without interrupting parsing process, so
        // we get as much errors information as possible
        // after just one parse attempt.
        private static TResult HandleErrors<TResult>(
            Func<TResult> func,
            IList<ReferralFileParserException> errors)
        {
            try
            {
                return func();
            }
            catch (ReferralFileParserException ex)
            {
                errors.Add(ex);
            }

            // NOTE: This is tricky when the result is of 
            // non-nullable reference type, because in case of
            // error we need to return something, e.g. default
            // value (which is null). We allow returning null in 
            // this case (using "!") as we know that if any errors
            // are gathered here the higher-level code won't
            // use the values of the properties we're parsing.
            return default!;
        }

        private Referral GetReferral(
            RawReferral rawReferral,
            IList<ReferralFileParserException> errors)
        {
            if (rawReferral.IsUpdate && rawReferral.ReferralNumer is null)
            {
                errors.Add(new ReferralFileParserException("Referral # is required for Update form."));
            }

            return new Referral
            {
                DonorPerson = GetDonorPerson(rawReferral.DonorPerson, errors),
                CallerInformation = GetCallerInformation(rawReferral.CallerInformation, errors),
                PagingInformation = GetPagingInformation(rawReferral.PagingInformation),
                IsUpdate = rawReferral.IsUpdate,
                CallerSourceCode = rawReferral.CallerSourceCode,
                CallReceivedOn = rawReferral.CallReceivedOn,
                CoordinatorName = new PersonName(rawReferral.CoordinatorFirstName, rawReferral.CoordinatorLastName),
                Heartbeat = rawReferral.Heartbeat,
                Vent = HandleErrors(() => ParseVentilatorType(rawReferral.Vent), errors),
                ExtubationAt = rawReferral.ExtubationAt,
                DeclaredCardiacTimeOfDeath = rawReferral.DeclaredCardiacTimeOfDeath,
                AdmittedOn = rawReferral.AdmittedOn,
                CauseOfDeath = rawReferral.CauseOfDeath,
                MedicalHistory = rawReferral.MedicalHistory,
                ReferralNumer = rawReferral.ReferralNumer,
                EnteredOn = rawReferral.EnteredOn,
            };
        }

        private PagingInformation? GetPagingInformation(
            RawPagingInformation rawPagingInformation)
        {
            if (rawPagingInformation.PagedToClient is null &&
                rawPagingInformation.PagedToClientOn is null &&
                rawPagingInformation.RePagedToClientOn is null &&
                rawPagingInformation.ReceivedBy is null &&
                rawPagingInformation.PagedBy is null &&
                rawPagingInformation.ReferralPagedToHospital is null)
            {
                return null;
            }

            return new PagingInformation(
                rawPagingInformation.PagedToClient,
                rawPagingInformation.PagedToClientOn,
                rawPagingInformation.RePagedToClientOn,
                rawPagingInformation.ReceivedBy,
                rawPagingInformation.PagedBy,
                rawPagingInformation.ReferralPagedToHospital);
        }

        private static ReferralDonorPerson GetDonorPerson(
            RawReferralDonorPerson rawReferralDonorPerson,
            IList<ReferralFileParserException> errors)
        {
            return new ReferralDonorPerson(
                name: GetDonorName(rawReferralDonorPerson),
                dateOfBirth: rawReferralDonorPerson.DateOfBirth,
                age: HandleErrors(() => GetDonorAge(rawReferralDonorPerson), errors),
                race: rawReferralDonorPerson.Race,
                gender: HandleErrors(() => ParsePersonGender(rawReferralDonorPerson.Gender), errors),
                weight: GetDonorWeight(rawReferralDonorPerson),
                medicalRecordNumber: rawReferralDonorPerson.MedicalRecordNumber);
        }

        private static CallerInformation GetCallerInformation(
           RawCallerInformation rawCallerInformation,
            IList<ReferralFileParserException> errors)
        {
            return new CallerInformation(
               phoneNumber: HandleErrors(() => ParsePhoneNumber(rawCallerInformation.PhoneNumber), errors),
               extension: HandleErrors(() => ParsePhoneExtension(rawCallerInformation.Extension), errors), 
               hospitalName: rawCallerInformation.HospitalName,
               callerName: new PersonName(rawCallerInformation.CallerFirstName, rawCallerInformation.CallerLastName),
               unit: rawCallerInformation.Unit,
               floor: rawCallerInformation.Floor);
        }

        private static PhoneExtension? ParsePhoneExtension(string? extension)
        {
            if (extension is null)
            {
                return null;
            }

            try
            {
                return new PhoneExtension(extension.Trim());
            }
            catch (FormatException ex)
            {
                throw new ReferralFileParserException("Invalid phone extension: " + ex.Message, ex);
            }
        }

        private static PhoneNumber ParsePhoneNumber(string formattedPhoneNumber)
        {
            try
            {
                return PhoneNumber.Parse(formattedPhoneNumber);
            }
            catch (FormatException ex)
            {
                throw new ReferralFileParserException("Invalid phone number: " + ex.Message, ex);
            }
        }

        private static PersonName? GetDonorName(RawReferralDonorPerson rawReferralDonorPerson)
        {
            if (rawReferralDonorPerson.FirstName is null &&
                rawReferralDonorPerson.LastName is null)
            {
                return null;
            }

            return new PersonName(rawReferralDonorPerson.FirstName, rawReferralDonorPerson.LastName);
        }

        private static PersonAge? GetDonorAge(RawReferralDonorPerson rawReferralDonorPerson)
        {
            int? age = rawReferralDonorPerson.Age;

            if (age is null)
            {
                return null;
            }

            if (rawReferralDonorPerson.AgeUnit is null)
            {
                throw new ReferralFileParserException("Age Unit is not selected while Age is specified.");
            }

            if (!Enum.TryParse<AgeUnit>(rawReferralDonorPerson.AgeUnit, out var ageUnit))
            {
                throw new ReferralFileParserException("Unknown Age Unit.");
            }

            return new PersonAge(age.Value, ageUnit);
        }

        private static PersonWeight? GetDonorWeight(RawReferralDonorPerson rawReferralDonorPerson)
        {
            float? weight = rawReferralDonorPerson.Weight;

            if (weight is null)
            {
                return null;
            }

            return new PersonWeight(weight.Value, WeightUnit.Kilograms);
        }

        private static VentilatorType ParseVentilatorType(string formattedVentilatorType)
        {
            if (Enum.TryParse<VentilatorType>(formattedVentilatorType, out var ventilatorType))
            {
                return ventilatorType;
            }

            throw new ReferralFileParserException("Unknown ventilator type.");
        }

        private static PersonGender? ParsePersonGender(string? formattedGender)
        {
            if (formattedGender is null)
            {
                return null;
            }

            if (Enum.TryParse<PersonGender>(formattedGender, out var personGender))
            {
                return personGender;
            }

            throw new ReferralFileParserException("Unknown person gender.");
        }

        private async Task<Dictionary<string, string?>> GetNamedValuesFromExcelDocument(
            IStreamReference excelDocumentStreamRef)
        {
            using var excelDocStream = await excelDocumentStreamRef.OpenReadAsync().ConfigureAwait(false);
            using var excelDoc = SpreadsheetDocument.Open(excelDocStream, isEditable: false);

            var definedNames = excelDoc.GetDefinedNames();

            return definedNames.ToDictionary(
                kvp => kvp.Key,
                kvp => excelDoc.GetCellValue(kvp.Value));
        }

        private static TimeZoneInfo LoadTimeZoneInfo(
            ExcelReferralFileParserOptions options)
        {
            // TODO: Move to option validation and pass only
            // time zone id to this method.
            if (string.IsNullOrWhiteSpace(options.TimeZoneId))
            {
                throw new ArgumentException(
                    $"Option {nameof(options.TimeZoneId)} must be specified.",
                    nameof(options));
            }

            TimeZoneInfo timeZone;

            try
            {
                timeZone = TimeZoneInfo.FindSystemTimeZoneById(
                    options.TimeZoneId);
            }
            catch (Exception ex) when (
                ex is TimeZoneNotFoundException ||
                ex is InvalidTimeZoneException)
            {
                throw new ArgumentException(
                    $"Failed to load TimeZoneInfo for time zone ID " +
                    $"'{options.TimeZoneId}': {ex.Message}",
                    nameof(options),
                    ex);
            }

            return timeZone;
        }
    }
}
