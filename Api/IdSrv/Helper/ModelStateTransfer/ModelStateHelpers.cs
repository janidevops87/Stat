using Microsoft.AspNetCore.Mvc.ModelBinding;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Linq;

namespace Statline.IdentityServer.Helper.ModelStateTransfer
{
    internal static class ModelStateHelpers
    {
        public static string SerialiseModelState(ModelStateDictionary modelState)
        {
            var errorList = modelState
                .Select(kvp => new ModelStateTransferValue
                {
                    Key = kvp.Key,
                    AttemptedValue = kvp.Value.AttemptedValue,
                    RawValue = kvp.Value.RawValue,
                    ErrorMessages = kvp.Value.Errors.Select(err => err.ErrorMessage).ToList(),
                });

            return JsonConvert.SerializeObject(errorList);
        }

        public static ModelStateDictionary DeserialiseModelState(string serialisedErrorList)
        {
            var errorList = JsonConvert.DeserializeObject<List<ModelStateTransferValue>>(serialisedErrorList);

            var modelState = new ModelStateDictionary();

            foreach (var item in errorList)
            {
                // We need special handling for arrays since they
                // are not deserialized to CLR arrays (what we want) 
                // but to a JArray.
                //
                // TODO: This approach implies that the array holds strings,
                // but need to check if other types are possible.
                if (item.RawValue is JArray jarray)
                {
                    item.RawValue = jarray.Select(t => (string)t).ToArray();
                }

                modelState.SetModelValue(item.Key, item.RawValue, item.AttemptedValue);

                foreach (var error in item.ErrorMessages)
                {
                    modelState.AddModelError(item.Key, error);
                }
            }
            return modelState;
        }
    }
}
