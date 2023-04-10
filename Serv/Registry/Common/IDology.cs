using System;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.Xml;
//using System.Xml.Linq;
using System.IO;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Util;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace Statline.Registry
{
    public class IDology
    {
#region GetValidation
        public string GetValidation(string url, string[] paramName, string[] paramVal)
        {
            String resultMessageStatus;
            String resultKeyStatus;

            HttpWebRequest request = WebRequest.Create(new Uri(url))
                                 as HttpWebRequest;
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";

            //Build IDology query and encode
            StringBuilder query = new StringBuilder();
            for (int i = 0; i < paramName.Length; i++)
            {
                query.Append("&");
                query.Append(paramName[i]);
                query.Append("=");
                query.Append(HttpUtility.UrlEncode(paramVal[i]));
            }
            //record sent value minus username password string 
            string requestData = query.ToString().Substring(40);

            // Encode the parameters as form data:
            byte[] formData =
                UTF8Encoding.UTF8.GetBytes(query.ToString());
            request.ContentLength = formData.Length;

            // Send request:
            using (Stream post = request.GetRequestStream())
            {
                post.Write(formData, 0, formData.Length);
            }

            // Get response:
            string responseData = null;
            using (HttpWebResponse response = request.GetResponse()
                                          as HttpWebResponse)
            {
                StreamReader reader =
                    new StreamReader(response.GetResponseStream());
                responseData = reader.ReadToEnd();
            }

            // Determine if PASS or FAIL, Match or No Match
            // Add checks for other ruleout items **here**
            resultMessageStatus = responseData.Contains("<message>PASS</message>") ? "PASS" : "FAIL";
            resultKeyStatus = responseData.Contains("<key>result.match</key>") ? "Match" : "No Match";

            // TODO: add save to database *Here*
            // for sent/received transmissions
            //requestData;
            //responseData;

            return responseData;
        }
#endregion

    }
}
