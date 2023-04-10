using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace Statline.Stattrac.Framework
{
    public enum Difference
    {
        Perfect = 4,
        High = 3,
        Medium = 2,
        Low = 1

    }
    public class Phonetic
    {

        public static string Soundex(string data)
        {
            StringBuilder result = new StringBuilder();

           
            if (!string.IsNullOrEmpty(data))
            {
                string previousCode = "";

                result.Append(data.Substring(0, 1));

                for (int i = 1; i < data.Length; i++)
                {
                    string currentLetter = data.Substring(i, 1).ToLower();
                    string currentCode = "";

                    if ("bfpv".IndexOf(currentLetter) > -1)
                        currentCode = "1";
                    else if ("cgjkqsxz".IndexOf(currentLetter) > -1)
                        currentCode = "2";
                    else if ("dt".IndexOf(currentLetter) > -1)
                        currentCode = "3";
                    else if (currentLetter == "l")
                        currentCode = "4";
                    else if ("mn".IndexOf(currentLetter) > -1)
                        currentCode = "5";
                    else if (currentLetter == "r")
                        currentCode = "6";

                    if (currentCode != previousCode)
                        result.Append(currentCode);

                    if (result.Length == 4) break;

                    if (currentCode != "")
                        previousCode = currentCode;
                }
            }

            if (result.Length < 4)
                result.Append(new String('0', 4 - result.Length));

            return result.ToString().ToUpper();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="data1"></param>
        /// <param name="data2"></param>
        /// <returns></returns>
        [Description("Compares data1 and data2 returning a value between 1 and 4.\n4 is Perfect Soundex Match.\n1 is a low match")]
        public static int Difference(string data1, string data2)
        {
            int result = 0;
            string soundex1 = Soundex(data1);
            string soundex2 = Soundex(data2);

            if (soundex1 == soundex2)
                result = 4;
            else
            {
                string sub1 = soundex1.Substring(1, 3);
                string sub2 = soundex1.Substring(2, 2);
                string sub3 = soundex1.Substring(1, 2);
                string sub4 = soundex1.Substring(1, 1);
                string sub5 = soundex1.Substring(2, 1);
                string sub6 = soundex1.Substring(3, 1);

                if (soundex2.IndexOf(sub1) > -1)
                    result = 3;
                else if (soundex2.IndexOf(sub2) > -1)
                    result = 2;
                else if (soundex2.IndexOf(sub3) > -1)
                    result = 2;
                else
                {
                    if (soundex2.IndexOf(sub4) > -1)
                        result++;

                    if (soundex2.IndexOf(sub5) > -1)
                        result++;

                    if (soundex2.IndexOf(sub6) > -1)
                        result++;
                }

                if (soundex1.Substring(0, 1) ==
                    soundex2.Substring(0, 1))
                    result++;
            }

            return (result == 0) ? 1 : result;
        }
    
    }
}
