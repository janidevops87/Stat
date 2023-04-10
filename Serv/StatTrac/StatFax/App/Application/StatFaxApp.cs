using DocumentFormat.OpenXml.CustomXmlDataProperties;
using DocumentFormat.OpenXml.Packaging;
using Microsoft.ApplicationInsights;
using Statline.Common.Utilities;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.StatFax.Application.EmailSender;
using Statline.StatTrac.StatFax.Application.FaxSender;
using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Statline.StatTrac.StatFax.Application
{
    public class StatFaxApp
    {
        // Returned value is fax send job ID.
        private delegate Task<string> FaxSender(
            StatFaxData.DocumentRequestQueueRow documentRow,
            IStreamReference faxBody);

        private readonly string templateFolderPath;
        private readonly string emailBodyTemplateFileNamePath;
        private readonly IEmailSender emailSender;
        private readonly IFaxSender faxSender;
        private readonly IWordToPdfConverter wordToPdfConverter;

        private StatFaxData dsStatFaxData;
        private static readonly TelemetryClient tc = StatFaxTelemetryClient.Initialize();

        public StatFaxApp(
            IEmailSender emailSender,
            IFaxSender faxSender,
            IWordToPdfConverter wordToPdfConverter,
            StatFaxAppOptions options)
        {
            Check.NotNull(emailSender, nameof(emailSender));
            Check.NotNull(faxSender, nameof(faxSender));
            Check.NotNull(wordToPdfConverter, nameof(wordToPdfConverter));
            Check.NotNull(options, nameof(options));

            var appFolder = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
            templateFolderPath = Path.Combine(appFolder, options.TemplateFolderName);
            emailBodyTemplateFileNamePath = Path.Combine(templateFolderPath, options.EmailBodyTemplateFileName);

            this.emailSender = emailSender;
            this.faxSender = faxSender;
            this.wordToPdfConverter = wordToPdfConverter;
        }

        public async Task ProcessAsync()
        {
            tc.TrackTraceWithFlush("StatFax Started");
            dsStatFaxData = new StatFaxData();

            StatFaxManager.GetStatFaxQueue(dsStatFaxData);

            foreach (var documentRow in dsStatFaxData.DocumentRequestQueue)
            {
                int noDocs = await PrepareData(
                    documentRow.DmvId,
                    documentRow.RegId,
                    documentRow.CallId,
                    documentRow.DocumentOrganization,
                    documentRow.FaxNumber,
                    documentRow.DocumentTo,
                    documentRow.DocumentSentByName,
                    documentRow.SubmitDate.ToString(),
                    documentRow.DSNID);

                if (noDocs != 0)
                {
                    // The file is deleted upon exiting the scope.
                    using TempFile faxFile =
                        GenerateFaxFile(templateFileName: documentRow.FormName);

                    var faxFileReference = new GenericStreamReference(() => File.OpenRead(faxFile));

                    FaxSender sender;

                    if (!documentRow.IsFaxNumberNull())
                    {
                        sender = SendViaFaxAsync;
                    }
                    else if (!documentRow.IsEmailNull())
                    {
                        sender = SendViaEmailAsync;
                    }
                    else
                    {
                        //write to faxqueue with a -1 job id to show not sent
                        StatFaxManager.UpdateFax(documentRow.DocumentRequestQueueID, "-1");
                        continue;
                    }

                    await SendFaxWithErrorHandlingAsync(documentRow, faxFileReference, sender);
                }
                else
                {
                    //write to faxqueue with a -1 job id to show not sent
                    StatFaxManager.UpdateFax(documentRow.DocumentRequestQueueID, "-1");
                }
            }
        }

        private async Task SendFaxWithErrorHandlingAsync(
            StatFaxData.DocumentRequestQueueRow documentRow,
            IStreamReference faxBody,
            FaxSender sender)
        {
            string faxJobId;

            try
            {
                faxJobId = await sender(documentRow, faxBody);
            }
            catch (Exception ex)
            {
                // Log exception in ApplicationInsights
                var message = "StatFax Error: Document not sent";
                if (documentRow is null)
                {
                    message += " (documentRow is null).";
                }
                else
                {
                    message += " (DocumentRequestQueueID: " + documentRow.DocumentRequestQueueID + ").";
                }                
                tc.TrackExceptionWithFlush(ex, message);

                //if error occurs, mark as not sent
                StatFaxManager.UpdateFax(documentRow.DocumentRequestQueueID, "-1");
                return;
            }

            //Update as sent
            StatFaxManager.UpdateFax(documentRow.DocumentRequestQueueID, faxJobId);
        }

        private async Task<string> SendViaEmailAsync(
           StatFaxData.DocumentRequestQueueRow documentRow,
           IStreamReference faxBody)
        {
            var bodyContent = new GenericStreamReference(() => File.OpenRead(emailBodyTemplateFileNamePath));

            // For sending fax via email there is a requirement to use PDF format,
            // so we're doing conversion.
            using TempFile pdfFaxBodyFile = await ConvertToPdfAsync(faxBody);

            var pdfFaxBody = new GenericStreamReference(() => File.OpenRead(pdfFaxBodyFile));

            // Also change file name extension.
            var faxBodyFileName = Path.ChangeExtension(documentRow.FormName, ".pdf");

            await emailSender.SendAsync(
                toAddress: documentRow.Email,
                toName: documentRow.DocumentTo,
                toReferralNumber: documentRow.CallId,
                body: new EmailBody(bodyContent, isHtml: true),
                new EmailAttachment(pdfFaxBody, faxBodyFileName));

            return null; // We have no JobID
        }

        private async Task<TempFile> ConvertToPdfAsync(IStreamReference faxBody)
        {
            var pdfDocumentFilePath = Path.GetTempFileName();

            using var wordDocumentStream = await faxBody.OpenReadAsync();
            using var pdfDocumentStream = File.OpenWrite(pdfDocumentFilePath);

            await wordToPdfConverter.ConvertAsync(wordDocumentStream, pdfDocumentStream);

            return pdfDocumentFilePath;
        }

        private async Task<string> SendViaFaxAsync(
            StatFaxData.DocumentRequestQueueRow documentRow,
            IStreamReference faxBody)
        {
            return await faxSender.SendAsync(
                toName: documentRow.DocumentTo,
                toNumber: documentRow.FaxNumber,
                body: new FaxBody(faxBody, fileName: documentRow.FormName));
        }

        private async Task<int> PrepareData(
            int dmvID,
            int regID,
            int callID,
            string faxQueueOrg,
            string faxQueueFaxNo,
            string faxQueueTo,
            string faxQueueByName,
            string faxqueueSubmitDate,
            int stateID)
        {
            dsStatFaxData.RegistryData.Rows.Clear();
            dsStatFaxData.FaxDocument.Rows.Clear();

            await StatFaxManager.GetRegistryDataAsync(dsStatFaxData, dmvID, regID, stateID).ConfigureAwait(false);

            if (dsStatFaxData.RegistryData.Count == 0)
            {
                return 0;
            }

            var registryDataRow = dsStatFaxData.RegistryData[0];

            #region Build Fax Document Row

            StatFaxData.FaxDocumentRow faxDocumentRow = dsStatFaxData.FaxDocument.NewFaxDocumentRow();
            dsStatFaxData.FaxDocument.AddFaxDocumentRow(faxDocumentRow);

            //case "txbRegId":
            if (!registryDataRow.IsRegistryIDNull())
            {
                faxDocumentRow.RegistryId = registryDataRow.RegistryID.ToString();
            }

            //case "txbRegDate":
            if (!registryDataRow.IsDonorFlagDateNull())
            {
                faxDocumentRow.RegistryDate = Convert.ToDateTime(registryDataRow.DonorFlagDate.ToString()).ToShortDateString();
            }

            //case "txbName":
            // 11/29/2011 ccarroll wi:14186 - Changed full name order to Last, First, Middle
            string lastName = "";
            string firstName = "";
            string midleName = "";

            if (!registryDataRow.IsLastNameNull())
            {
                lastName = registryDataRow.LastName.ToString();
            }

            if (!registryDataRow.IsFirstNameNull())
            {
                firstName = registryDataRow.FirstName.ToString();
            }

            if (!registryDataRow.IsMiddleNameNull())
            {
                midleName = registryDataRow.MiddleName.ToString();
            }

            if ((lastName.Trim().Length == 0))
            {
                faxDocumentRow.Name = String.Format("{0} {1} {2}", lastName, firstName, midleName);
            }
            else
            {
                faxDocumentRow.Name = String.Format("{0}, {1} {2}", lastName, firstName, midleName);
            }

            //case "txbReferralNo":
            faxDocumentRow.CallId = callID.ToString();

            //case "txbDOB":
            if (!String.IsNullOrEmpty(registryDataRow.DOB))
            {
                faxDocumentRow.DOB = Convert.ToDateTime(registryDataRow.DOB.ToString()).ToShortDateString();
            }

            //case "txbAddress":
            string addr1 = "";
            string addr2 = "";

            if (!registryDataRow.IsAddr1Null())
            {
                addr1 = registryDataRow.Addr1;
            }

            if (!registryDataRow.IsAddr2Null())
            {
                addr2 = registryDataRow.Addr2;
            }

            faxDocumentRow.Address = String.Format("{0} {1}", addr1, addr2);

            //case "txbCityStateZip":
            string city = "";
            string state = "";
            string zip = "";

            if (!registryDataRow.IsCityNull())
            {
                city = registryDataRow.City;
            }

            if (!registryDataRow.IsStateNull())
            {
                state = registryDataRow.State;
            }

            if (!registryDataRow.IsZipNull())
            {
                zip = registryDataRow.Zip;
            }

            faxDocumentRow.CityStateZip = string.Format("{0}, {1} {2}", city, state, zip);

            //case "txbSource":
            faxDocumentRow.Source = ((stateID == 29/*DLA Registry*/) ? "DLA" : ((dmvID != 0) ? "DMV" : "Web"));

            //case "txbNameFml":
            faxDocumentRow.NameFml = String.Format("{0} {1} {2}", firstName.Trim(), midleName.Trim(), lastName.Trim()); ;

            //case "txbAddressFull":
            faxDocumentRow.AddressFull = faxDocumentRow.Address + " " + faxDocumentRow.CityStateZip;

            //case "txbLicense":
            if (!registryDataRow.IsLicenseNull())
            {
                faxDocumentRow.License = registryDataRow.License;
            }

            //case "txbLimitations":
            if (!registryDataRow.IsLimitationsNull())
            {
                faxDocumentRow.Limitations = registryDataRow.Limitations;
            }

            //case "txbLimitationsOther":
            if (!registryDataRow.IsLimitationsOtherNull())
            {
                faxDocumentRow.LimitationsOther = registryDataRow.LimitationsOther;
            }

            //case "txbEmail":
            if (!registryDataRow.IsEmailNull())
            {
                faxDocumentRow.Email = registryDataRow.Email;
            }

            //case "CkbAffirm":
            if (!registryDataRow.IsDonorConfirmedNull())
            {
                if (Convert.ToBoolean(registryDataRow.DonorConfirmed) == true)
                {
                    faxDocumentRow.DonorConfirmed = "I";
                }
                else
                {
                    faxDocumentRow.DonorConfirmed = "I Do Not";
                }
            }
            //case "txbOrganization":
            faxDocumentRow.Organization = faxQueueOrg;

            //case "txbFaxNumber":
            faxDocumentRow.FaxNumber = faxQueueFaxNo;

            //case "txbReceiptent":
            //case "txbReceiptent":
            faxDocumentRow.Receipient = faxQueueTo;

            //case "txbDonorComment":
            if (!registryDataRow.IsRestrictionNull())
            {
                faxDocumentRow.DonorComment = registryDataRow.Restriction;
            }

            //case "txtbDonor":
            if (!registryDataRow.IsDonorNull())
            {
                faxDocumentRow.Donor = registryDataRow.Donor.ToString();
            }

            //case "txtbDonorYear":
            if (!registryDataRow.IsDonorYearNull())
            {
                faxDocumentRow.DonorYear = registryDataRow.DonorYear;
            }

            //case "txtbPreparedBy":
            faxDocumentRow.FaxPreparedBy = faxQueueByName;

            //case "txtbDatePrepared":
            faxDocumentRow.FaxDate = faxqueueSubmitDate;

            #endregion

            return dsStatFaxData.RegistryData.Count;
        }

        private TempFile GenerateFaxFile(string templateFileName)
        {
            string faxTemplateFilePath = Path.Combine(templateFolderPath, templateFileName);

            var customXmlData = XDocument.Parse(dsStatFaxData.GetXml());

            var faxFilePath = Path.GetTempFileName();

            File.Copy(faxTemplateFilePath, faxFilePath, overwrite: true);

            using (var wordDoc = WordprocessingDocument.Open(faxFilePath, isEditable: true))
            {
                MainDocumentPart mainPart = wordDoc.MainDocumentPart;

                var customXmlDataNamespace = customXmlData.Root.Name.NamespaceName;

                // Find all custom XML parts which have
                // data schema reference matching the schema of our DataSet.
                var faxDataCustomParts =
                        from part in mainPart.CustomXmlParts
                        let schemaRefs = part.CustomXmlPropertiesPart?.DataStoreItem?.SchemaReferences
                        where schemaRefs != null
                        from sr in schemaRefs.Cast<SchemaReference>()
                        where sr.Uri == customXmlDataNamespace
                        select part;

                var faxDataCustomPart = faxDataCustomParts.FirstOrDefault();

                // We expect that we already have stub data in the template.
                // That means we already have corresponding DataStoreItem with correct ID defined.
                // It's critical to have this DataStoreItem as all binding in the document reference
                // this DataStoreItem by id. 
                //
                // Another possible case is when the DataStoreItem(s) is defined, but doesn't have
                // corresponding data schema reference. Without it, we can't determine if this XML part
                // is the one we need (where we will put the data). This can be worked around 
                // by loading the part content and checking its schema name. 
                // However, this seems to be a pretty heavy 
                // solution for basically a mistake in the template format.
                //
                // TODO: Consider implementing adding new custom XML part and the DataStoreItem if no
                // found. 
                if (faxDataCustomPart is null)
                {
                    throw new InvalidOperationException(
                        $"Template document {templateFileName} doesn't contain required " +
                        $"custom XML data or corresponding data store item doesn't have " +
                        $"data schema reference (ds:schemaRefs attribute).");
                }

                // Delete all extra custom xml parts.
                mainPart.DeleteParts(mainPart.CustomXmlParts.Where(part => part != faxDataCustomPart));

                using (var stream = faxDataCustomPart.GetStream())
                {
                    customXmlData.Save(stream);
                }
            }

            return faxFilePath;
        }
    }
}
