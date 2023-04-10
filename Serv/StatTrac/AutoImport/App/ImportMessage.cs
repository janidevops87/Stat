using System;
using System.Collections.Generic;
using System.Text;

namespace Statline.StatTrac.AutoImport
{


    public class ImportMessage
    {
        public const string SENDERSNAME = "Sender's Name:";
        public const string ORGANOFFER = "organ offer";
        public const string CARRIAGERETURN = "\n";
        public const string CANDIDATE = "A candidate at ";
        public const string OPO = "OPO:";
        public const string DONORID = "Donor ID:";
        public const string HTTPS = "https";
        public const string ENDPAREN = ")";
        public const string PLEASE = "Please";
        public const string ORGAN = "Organ:";
        public const string THESENDERTEXT = "The sender provided the following contact information.";
        public const string NEWLINE = "\n";
        public const string STARTPOS = "<body";
        public const string HTMLBR = "<br>";
        public const string HTMLSPACE = "&nbsp;";
        public const string HTMLFONTSIZE = "size";
        public const string HTMLENDTAG = ">";
        public const int TRANSPLANTCENTERLENGTH = 4;
        public const int OPOLENGTH = 4;

        private string senderName;
        private string transplantCenter;
        private string fromOPO;
        private string unosid;
        private string statTracMessage;
        private string url;
        private string sender;
        private string offerInformation;
        private string organDetail;
        private string rawEmailMessage;

        public string RawEmailMessage
        {
            get { return rawEmailMessage; }
            set { rawEmailMessage = value; }
        }
        public string OrganDetail
        {
            get { return organDetail; }
            set { organDetail = value; }
        }
        public string OfferInformation
        {
            get { return offerInformation; }
            set { offerInformation = value; }
        }
        public string Sender
        {
            get { return sender; }
            set { sender = value; }
        }
	    public string URL
        {
            get { return url; }
            set { url = value; }
        }
	    public string StatTracMessage
        {
            get { return statTracMessage; }
            set { statTracMessage = value; }
        }
        public string UNOSID
        {
            get { return unosid; }
            set { unosid = value; }
        }
        public string FromOPO
        {
            get { return fromOPO; }
            set { fromOPO = value; }
        }
        public string TransplantCenter
        {
            get { return transplantCenter; }
            set { transplantCenter = value; }
        }
        public string SenderName
        {
            get { return senderName; }
            set { senderName = value; }
        }


    }
}
