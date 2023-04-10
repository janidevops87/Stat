using System.Linq;
using System.Reflection;

namespace Statline.StatTracUploader.Infrastructure.FileParsers.Excel
{
    internal static class KnownDefinedNames
    {
        public static readonly string Admit_Date_Value = "Admit_Date_Value";
        public static readonly string Admit_Time_Value = "Admit_Time_Value";
        public static readonly string Age_Value = "Age_Value";
        public static readonly string Age_Unit_Value = "Age_Unit_Value";
        public static readonly string Caller_First_Name_Value = "Caller_First_Name_Value";
        public static readonly string Caller_Last_Name_Value = "Caller_Last_Name_Value";
        public static readonly string COD_Value = "COD_Value";
        public static readonly string Date_Value = "Date_Value";
        public static readonly string Declared_CTOD_Date_Value = "Declared_CTOD_Date_Value";
        public static readonly string Declared_CTOD_Time_Value = "Declared_CTOD_Time_Value";
        public static readonly string DOB_Value = "DOB_Value";
        public static readonly string Extension_Value = "Extension_Value";
        public static readonly string Extubation_Date_Value = "Extubation_Date_Value";
        public static readonly string Extubation_Time_Value = "Extubation_Time_Value";
        public static readonly string First_Name_Value = "First_Name_Value";
        public static readonly string Last_Name_Value = "Last_Name_Value";
        public static readonly string Gender_Value = "Gender_Value";
        public static readonly string Heartbeat_Value = "Heartbeat_Value";
        public static readonly string Hospital_Name_Value = "Hospital_Name_Value";
        public static readonly string Medical_Hx_Value = "Medical_Hx_Value";
        public static readonly string MRN_Value = "MRN_Value";
        public static readonly string Paged_By_Value = "Paged_By_Value";
        public static readonly string Paged_To_Client_Time_Value = "Paged_To_Client_Time_Value";
        public static readonly string Paged_To_Client_Value = "Paged_To_Client_Value";
        public static readonly string Phone_Value = "Phone_Value";
        public static readonly string Race_Value = "Race_Value";
        public static readonly string Re_Paged_To_Client_Time_Value = "Re_Paged_To_Client_Time_Value";
        public static readonly string Received_By_Value = "Received_By_Value";
        public static readonly string Referral_Paged_To_Hospital_Value = "Referral_Paged_To_Hospital_Value";
        public static readonly string Referral_Value = "Referral_Value";
        public static readonly string Source_Code_Value = "Source_Code_Value";
        public static readonly string TC_Coordinator_First_Name_Value = "TC_Coordinator_First_Name_Value";
        public static readonly string TC_Coordinator_Last_Name_Value = "TC_Coordinator_Last_Name_Value";
        public static readonly string Time_Entered_Value = "Time_Entered_Value";
        public static readonly string Time_Value = "Time_Value";
        public static readonly string Unit_Value = "Unit_Value";
        public static readonly string Floor_Value = "Floor_Value";
        public static readonly string Update_Value = "Update_Value";
        public static readonly string Vent_Value = "Vent_Value";
        public static readonly string Weight_Value = "Weight_Value";

        static KnownDefinedNames()
        {
            var allNameFields =
                typeof(KnownDefinedNames).GetFields(BindingFlags.Public | BindingFlags.Static);

            All = allNameFields.Select(fi => fi.GetValue(null)).Cast<string>().ToArray(); 
        }

        public static string[] All { get; }
    }
}
