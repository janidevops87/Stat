using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Registry.Common.Enums
{
    public static class StateDictionary
    {
        private static Dictionary<string, string> _states;

        public static Dictionary<string, string> States
        {
            get
            {
                if (_states != null) return _states;

                _states = new Dictionary<string, string>
                {
                    {"AL", "Alabama"},
                    {"AK", "Alaska"},
                    {"AZ", "Arizona"},
                    {"AR", "Arkansas"},
                    {"CA", "California"},
                    {"CO", "Colorado"},
                    {"CT", "Connecticut"},
                    {"DE", "Delaware"},
                    {"DC", "District of Columbia"},
                    {"FL", "Florida"},
                    {"GA", "Georgia"},
                    {"HI", "Hawaii"},
                    {"ID", "Idaho"},
                    {"IL", "Illinois"},
                    {"IN", "Indiana"},
                    {"IA", "Iowa"},
                    {"KS", "Kansas"},
                    {"KY", "Kentucky"},
                    {"LA", "Louisiana"},
                    {"ME", "Maine"},
                    {"MD", "Maryland"},
                    {"MA", "Massachusetts"},
                    {"MI", "Michigan"},
                    {"MN", "Minnesota"},
                    {"MS", "Mississippi"},
                    {"MO", "Missouri"},
                    {"MT", "Montana"},
                    {"NE", "Nebraska"},
                    {"NV", "Nevada"},
                    {"NH", "New Hampshire"},
                    {"NJ", "New Jersey"},
                    {"NM", "New Mexico"},
                    {"NY", "New York"},
                    {"NC", "North Carolina"},
                    {"ND", "North Dakota"},
                    {"OH", "Ohio"},
                    {"OK", "Oklahoma"},
                    {"OR", "Oregon"},
                    {"PA", "Pennsylvania"},
                    {"RI", "Rhode Island"},
                    {"SC", "South Carolina"},
                    {"SD", "South Dakota"},
                    {"TN", "Tennessee"},
                    {"TX", "Texas"},
                    {"UT", "Utah"},
                    {"VT", "Vermont"},
                    {"VA", "Virginia"},
                    {"WA", "Washington"},
                    {"WV", "West Virginia"},
                    {"WI", "Wisconsin"},
                    {"WY", "Wyoming"}
                };

                return _states;
            }
        }

        public static string GetStateCode(string stateName)
        {
            return States.FirstOrDefault(s => string.Compare(s.Value, stateName, true, CultureInfo.InvariantCulture) == 0).Key;
        }
    }
}
