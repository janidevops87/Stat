using Microsoft.AspNetCore.Http;
using Statline.Ereferral.Models;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;

namespace Statline.Ereferral.Web.Services
{
    public interface IStattracApi
    {
        Task<bool> IsIdentityServerAvailableAsync();

        Task<bool> IsStatTracApiAvailableAsync();

        Task<bool> IsValidOpoCode(string opoCode);

        Task<bool> IsEmailValid(string opoCode, string email);

        Task<bool> UnosIdExists(string unosid);

        Task<bool> IsMedicalRecordDuplicate(string sourceCode, string facilityCode, string medicalRecord);
        
        Task<string> GetSourceCodeId(string sourceCode);

        Task<string> GetFacilityInfo(string sourceCode, string facilityCode, string contactFirstName, string contactLastName);

        Task<string> GetHospitalUnitAndFloor(string sourceCode, string facilityCode, string phone);

        Task<string> States();
        Task<string> Titles();
        Task<string> Races();
        Task<string> HospitalUnits();
        Task<string> GetFacilityCodes(string sourceCode);
        Task<string> OfferedOrganTissue();
        Task<HttpResponseMessage> FileUpload(IFormFile file);
        Task<bool> IsCaptchaValid(string api, string secret, string response);
        Task<string> SubmitEreferral(ReferralModel referralModel);
        Task<string> GetVersion();

    }
}