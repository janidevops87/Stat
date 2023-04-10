namespace Statline.StatTrac.Domain.EReferrals;

public interface IEReferralRepository
{
    Task<int> GetSourceCodeId(string sourceCode);
    Task<List<ContactTitle>> GetContactTitleList();
    Task<List<HospitalUnit>> GetHospitalUnitList();
    Task<FacilityInfo?> GetFacilityInfo(string sourceCode, string facilityCode, string? contactFirstName, string? contactLastName);
    Task<bool> IsMedicalRecordDuplicate(string sourceCode, string facilityCode, string medicalRecord);
    Task<HospitalUnitAndFloor?> GetHospitalUnitAndFloor(string sourceCode, string facilityCode, string phone);
    Task<string?> SubmitEreferral(ReferralModel referralModel);
    Task<List<FacilityInfo>> GetFacilityCodes(string sourceCode);
}
