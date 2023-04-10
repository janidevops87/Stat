using System;
using System.Collections.Generic;
using System.Text;
using System.Net;
using Statline.StatTrac.AutoImport.org.statline.webmail;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.StatTrac.AutoImport.Configuration;
namespace Statline.StatTrac.AutoImport
{
    public class ExchangeWSHelper
    {
        private ExchangeServiceBinding ws; 
        private string processFolderName;
        private string errorFolderName;
        private string singleRecipientEmailAddress;

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
                ArrayOfRealItemsType realItems =
                findItemResponseMessage.RootFolder.Item as ArrayOfRealItemsType;

                if (realItems.Items != null)
                {
                    //loop through list and process emails
                    foreach(ItemType item in realItems.Items)
                    {

                        ItemInfoResponseMessageType message = GetMessage(item.ItemId.Id.ToString());
                        ImportMessage im = new ImportMessage();
                        im.RawEmailMessage = message.Items.Items[0].Body.Value;
                        AutoImportParse parse = new AutoImportParse();
                        bool result = false;
                        try
                        {
                            result = parse.ProcessMessage(im, (MessageType)item);
                        }
                        catch (Exception ex)
                        {
                            Logger.Write(ex, "General");
                            throw;
                        }
                        if(result)
                        {
                            //email was processed successful, place email in process folder
                            MoveItem(item.ItemId.Id.ToString(), processFolderName);      
                        }
                        else
                        {
                            //email was process UNSuccessful, place email in error folder
                            MoveItem(item.ItemId.Id.ToString(), errorFolderName);      
                            //send email to operations team
                            Logger.Write("The AutomImport process has moved an email to the Error folder." ,
                            Category.ImportMailError.ToString()                            
                            );

                        }
                    }
                }
            }
            else
            {
                Exception ex = new Exception("The AutoImport cannot connect to and process emails");
                throw ex;
            }


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
            try
            {
                TargetFolderIdType folderIDArray = new TargetFolderIdType();
                folderIDArray.Item = folder.RootFolder.Folders[0].FolderId;
                moveType.ToFolderId = folderIDArray;
            }
            catch (Exception ex)
            {
                Logger.Write(String.Format("The AutoImport Service has tried to move an email to folder {0} but has failed. The exception follows {1}", folderName, ex), "Error");
                throw;
            }
            
            
            ws.MoveItem(moveType);
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

            //ItemInfoResponseMessageType itemShape = new ItemInfoResponseMessageType();

            GetItemResponseType itemResponse = ws.GetItem(item);

            ItemInfoResponseMessageType message = (ItemInfoResponseMessageType)itemResponse.ResponseMessages.Items[0];

            return message;
            
        }        
        /// <summary>
        /// SearchMessage() was used to test and proof the exchange web service
        /// </summary>
        public void SearchMessage()
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

            //// Identify the field to examine. In this example,
            //// the "body" with the unindexed field itemBody is identified.
            //PathToUnindexedFieldType pathToUnindexedField =
            //new PathToUnindexedFieldType();
            //pathToUnindexedField.FieldURI = UnindexedFieldURIType.itemBody;

            //// Define the type of search filter to apply. In this example,
            //// "itemBody CONTAINS SearchedTextPassedIn" is the search filter.
            //ContainsExpressionType containsExpression = new ContainsExpressionType();
            //containsExpression.Item = pathToUnindexedField;

            //// Specify how the search expression is evaluated.
            //containsExpression.ContainmentComparison =
            //ContainmentComparisonType.IgnoreCase;
            //containsExpression.ContainmentComparisonSpecified = true;
            //containsExpression.ContainmentMode = ContainmentModeType.Substring;
            //containsExpression.ContainmentModeSpecified = true;

            //// Identify the value to compare to the examined field (ItemClass).
            //ConstantValueType constantValue = new ConstantValueType();
            //constantValue.Value = "Bret";

            //// Add the value to the search expression.
            //containsExpression.Constant = constantValue;

            //// Create a restriction.
            //RestrictionType restriction = new RestrictionType();

            //// Add the search expression to the restriction.
            //restriction.Item = containsExpression;

            //// Add the restriction to the request.
            //findRequest.Restriction = restriction;

            // Perform the search by calling the FindItem method.
            FindItemResponseType findResponse = ws.FindItem(findRequest);

            // Get the response message.
            ResponseMessageType responseMessage = findResponse.ResponseMessages.Items[0];

            // Cast to the correct response message type.
            FindItemResponseMessageType findItemResponseMessage =
            responseMessage as FindItemResponseMessageType;

            if (findItemResponseMessage.ResponseClass == ResponseClassType.Success)
            {
                // Get the actual payload of items.
                ArrayOfRealItemsType realItems =
                findItemResponseMessage.RootFolder.Item as ArrayOfRealItemsType;

                if (realItems.Items != null)
                {
                    //return new List<ItemType>(realItems.Items);
                    foreach (ItemType item in realItems.Items)
                    {
                        ItemInfoResponseMessageType message = GetMessage(item.ItemId.Id);
                        ImportMessage im = new ImportMessage();
                        im.RawEmailMessage = message.Items.Items[0].Body.Value;
                        AutoImportParse parse = new AutoImportParse();
                        parse.ProcessMessage(im, (MessageType)item);

                    }
                }
                else
                {
                    //return null;
                }
            }
            else
            {
                // Handle any errors here.
            }
        }
        
    }
}
