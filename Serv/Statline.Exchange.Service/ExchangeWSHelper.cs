using System;
using Statline.Configuration;
using Statline.Exchange.Service.org.statline.webmail;
using System.Net;
using System.Diagnostics;
using Microsoft.Practices.EnterpriseLibrary.Logging;

namespace Statline.Exchange.Service
{
    public class ExchangeWSHelper
    {
        private ExchangeServiceBinding ws;
        private string processFolderName;
        private string errorFolderName;

        public ExchangeWSHelper(string userName, string password, string wsURL)
        {
            // get a new instance to the ExchangeServiceBindig
            ws = new ExchangeServiceBinding();

            ws.Credentials = new NetworkCredential(userName, password);

            // set the web services url
            ws.Url = wsURL;
            processFolderName = ApplicationSettings.GetSetting(SettingName.ProcessFolderName);
            errorFolderName = ApplicationSettings.GetSetting(SettingName.ErrorFolderName);

        }
        public void ProcessEmails()
        {
            // Form the FindItem request.
            FindItemType findRequest = new FindItemType();

            // Choose the traversal mode.
            findRequest.Traversal = ItemQueryTraversalType.Shallow;

            // Define which item properties are returned in the response.
            ItemResponseShapeType itemProperties = new ItemResponseShapeType();
            itemProperties.BaseShape = DefaultShapeNamesType.AllProperties;

            // Add properties shape to request.
            findRequest.ItemShape = itemProperties;

            // Define the folders to search. In this example, the Inbox is searched.
            DistinguishedFolderIdType[] folderIDArray = new DistinguishedFolderIdType[1];
            folderIDArray[0] = new DistinguishedFolderIdType();
            folderIDArray[0].Id = DistinguishedFolderIdNameType.inbox;
            findRequest.ParentFolderIds = folderIDArray;

            // Perform the search by calling the FindItem method.
            FindItemResponseType findResponse;
            try
            {
                findResponse = ws.FindItem(findRequest);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
                throw;
            }
            // Get the response message.
            ResponseMessageType responseMessage = findResponse.ResponseMessages.Items[0];

            // Cast to the correct response message type.
            FindItemResponseMessageType findItemResponseMessage =
            responseMessage as FindItemResponseMessageType;

            if (findItemResponseMessage.ResponseClass == ResponseClassType.Success)
            {
                // Get the actual payload of items.
                ArrayOfRealItemsType realItems = findItemResponseMessage.RootFolder.Item as ArrayOfRealItemsType;

                if (realItems.Items != null)
                {
                    //loop through list and process emails
                    foreach (ItemType item in realItems.Items)
                    {

                        ItemInfoResponseMessageType message = GetMessage(item.ItemId.Id.ToString());
                        AbstractMessage im = MessageFactory.GetMessageObject();                        
                        im.EmailMessage = message.Items.Items[0].Subject + " " +  message.Items.Items[0].Body.Value;
                        AbstractProcess parse = ProcessFactory.GetProcesObject();
                        bool result = false;
                        try
                        {
                            result = parse.ProcessMessage(im);
                        }
                        catch (Exception ex)
                        {
                            Logger.Write(ex, "General");
                            throw;
                        }
                        if (result)
                        {
                            //email was processed successful, place email in process folder
                            MoveItem(item.ItemId.Id.ToString(), processFolderName);
                        }
                        else
                        {
                            //email was process UNSuccessful, place email in error folder
                            MoveItem(item.ItemId.Id.ToString(), errorFolderName);
                            //send email to operations team
                            string errorMessage = "The " + ApplicationSettings.GetSetting(SettingName.ApplicationName) + " process has moved an email to the Error folder.";
                            Logger.Write(errorMessage,
                            Category.ImportMailError.ToString(),
                            Convert.ToInt32(Priority.Default),
                            0, 
                            TraceEventType.Information
                            );

                        }
                    }
                }
            }
            else
            {
                string errorMessage = "The " + ApplicationSettings.GetSetting(SettingName.ApplicationName) + "cannot connect to and process emails";
                Exception ex = new Exception( errorMessage );
                throw ex;
            }


        }
        public ItemInfoResponseMessageType GetMessage(string itemId)
        {
            GetItemType item = new GetItemType();

            ItemIdType[] itemIds = new ItemIdType[1];
            itemIds[0] = new ItemIdType();
            itemIds[0].Id = itemId;

            item.ItemIds = itemIds;

            ItemResponseShapeType itemShape = new ItemResponseShapeType();
            itemShape.BaseShape = DefaultShapeNamesType.AllProperties;
            itemShape.BodyType = BodyTypeResponseType.Text;
            itemShape.BodyTypeSpecified = true;
            item.ItemShape = itemShape;

            GetItemResponseType itemResponse = ws.GetItem(item);

            ItemInfoResponseMessageType message = (ItemInfoResponseMessageType)itemResponse.ResponseMessages.Items[0];

            return message;

        }
        private FindFolderResponseMessageType FindFolder(string folderName)
        {
            // create a find folder type
            FindFolderType folderType = new FindFolderType();

            // set the searches traversal level
            folderType.Traversal = FolderQueryTraversalType.Shallow;


            FolderResponseShapeType folderProperties = new FolderResponseShapeType();
            folderProperties.BaseShape = DefaultShapeNamesType.AllProperties;

            folderType.FolderShape = folderProperties;

            DistinguishedFolderIdType[] folderIDArray = new DistinguishedFolderIdType[1];
            folderIDArray[0] = new DistinguishedFolderIdType();
            folderIDArray[0].Id = DistinguishedFolderIdNameType.inbox;
            folderType.ParentFolderIds = folderIDArray;

            //add an expression to find a specific folder
            ContainsExpressionType containsExpression = new ContainsExpressionType();

            //add field to search
            PathToUnindexedFieldType pathField = new PathToUnindexedFieldType();
            pathField.FieldURI = UnindexedFieldURIType.folderDisplayName;
            containsExpression.Item = pathField;

            containsExpression.ContainmentComparison = ContainmentComparisonType.IgnoreCase;
            containsExpression.ContainmentComparisonSpecified = true;
            containsExpression.ContainmentMode = ContainmentModeType.FullString;
            containsExpression.ContainmentModeSpecified = true;

            //set the strig to search
            ConstantValueType constantValue = new ConstantValueType();
            constantValue.Value = folderName;
            containsExpression.Constant = constantValue;

            //set the restring type for search
            RestrictionType restriction = new RestrictionType();
            restriction.Item = containsExpression;

            folderType.Restriction = restriction;

            FindFolderResponseType responseType;
            try
            {
                responseType = ws.FindFolder(folderType);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
                throw;
            }

            FindFolderResponseMessageType folder = (FindFolderResponseMessageType)responseType.ResponseMessages.Items[0];

            return folder;
            // FindFolderResponseMessageType folder = responsType.ResponseMessages.Items[0] .Items[0] //responsType.ResponseMessages.Items.


        }  

        private void MoveItem(string itemId, string folderName)
        {
            MoveItemType moveType = new MoveItemType();

            //setup the item array
            ItemIdType[] itemIds = new ItemIdType[1];
            itemIds[0] = new ItemIdType();
            itemIds[0].Id = itemId;

            moveType.ItemIds = itemIds;

            TargetFolderIdType targetFolder = new TargetFolderIdType();
            FindFolderResponseMessageType folder;
            try
            {
                folder = FindFolder(folderName);

            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
                throw;
            }

            TargetFolderIdType folderIDArray = new TargetFolderIdType();
            folderIDArray.Item = folder.RootFolder.Folders[0].FolderId;
            moveType.ToFolderId = folderIDArray;


            ws.MoveItem(moveType);
        }

    }
}
