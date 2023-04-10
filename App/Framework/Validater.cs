using System;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Xml.Serialization;

namespace Statline.Stattrac.Framework
{
    public static class Validater
    {
        public static bool ObjectIsValidArray(object obj, short expectedDimensions = 0, short expectedLastIndexDim1 = 0, short expectedLastIndexDim2 = 0)
        {
            //Array is bigger than expected: return true
            //Array is the same size as expected: return true
            //Object is not an array or it is smaller than expected: return false

            //Prepare private variables
            bool returnValue = false;
            string failureReason = string.Empty;

            //Make sure object is not null
            if (obj != null)
            {
                //Make sure object is an array
                if ((obj is Array))
                {
                    //Make sure we care about the array's contents
                    if (expectedDimensions > 0)
                    {
                        //Make sure we have enough dimensions in our array
                        Array arr = obj as Array;
                        if (arr.Rank >= expectedDimensions)
                        {
                            //Make sure we have enough items in our array
                            if (arr.Rank > 1)
                            {
                                returnValue = (arr.GetUpperBound(0) + 1) >= expectedLastIndexDim1 && (arr.GetUpperBound(1) + 1) >= expectedLastIndexDim2;
                            }
                            else if (arr.Rank.Equals(1))
                            {
                                returnValue = (arr.Length >= expectedLastIndexDim1);
                            }
                            else
                            {
                                failureReason = "Array didn't contain any dimensions.";
                                returnValue = false;
                            }
                        }
                        else
                        {
                            failureReason = "Array didn't contain the expected number of dimensions.";
                            returnValue = false;
                        }
                    }
                    else
                    {
                        returnValue = true;
                    }
                }
                else
                {
                    failureReason = "The object was not an array.";
                    returnValue = false;
                }
            }
            else
            {
                failureReason = "The object was not initialized.";
                returnValue = false;
            }

            //Check to see if we had a validation failure so we can log it
            if (returnValue == false)
            {
                //Log validation failure
                try
                {
                    //Serialize the object (if it's an array)
                    string objText = "not an array";
                    if (obj is Array)
                    {
                        XmlSerializer s = new XmlSerializer(typeof(string[][]));
                        StringBuilder sb = new StringBuilder();
                        StringWriter sw = new StringWriter(sb);
                        s.Serialize(sw, obj as Array);
                        sw.Close();
                        objText = sb.ToString();
                    }

                    //Build & log new exception
                    var callingMethod = new StackFrame(1, true).GetMethod();
                    string source = callingMethod.ReflectedType.FullName + ": " + callingMethod.Name;
                    string message = "StatTrac Validation Warning: " + 
                        "found in Statline.Stattrac.Framework.Validater.ObjectIsValidArray " + 
                        "from source - " + source +
                        ", object - " + objText +
                        ", reason - " + failureReason + 
                        ", expected dimensions - " + expectedDimensions +
                        ", expected length (dim1) - " + expectedLastIndexDim1 +
                        ", expected length (dim2) - " + expectedLastIndexDim2;
                    Exception ex = new Exception(message);
                    StatTracLogger.CreateInstance().Write(ex, TraceEventType.Warning);
                }
                catch (Exception)
                {
                    //Swallow error
                }
            }

            return returnValue;
        }
    }
}
