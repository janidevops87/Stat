using Microsoft.AspNetCore.Mvc.ModelBinding;
using Statline.Ereferral.Models;
using Statline.Ereferral.Web.Services;
using System.Threading.Tasks;

namespace Statline.Ereferral.Web.Validators
{
    public class LoginValidator
    {
        private EreferralSettings _setting;
        private IStattracApi _statTracApi;

        public LoginValidator(EreferralSettings setting, IStattracApi donorTracApi)
        {
            _setting = setting;
            _statTracApi = donorTracApi;
        }

        public async Task<bool> IsValid(ReferralModel model, ModelStateDictionary modelState)
        {
            if (!(await _statTracApi.IsIdentityServerAvailableAsync()))
            {
                modelState.AddModelError("modelError", "Identity Server is unavailable");
                return false;
            }
            if (!(await _statTracApi.IsStatTracApiAvailableAsync()))
            {
                modelState.AddModelError("modelError", "Stattrac Api is unavailable");
                return false;
            }
            if (!System.Diagnostics.Debugger.IsAttached && !(await _statTracApi.IsCaptchaValid(_setting.RecaptchaApi, _setting.RecaptchaSecret, model.recaptcha)))
            {
                modelState.AddModelError("recaptchaSecret", "Invalid Recaptcha");
                return false;
            }
            return (modelState.Count == 0);
        }
    }
}