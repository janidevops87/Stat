using Statline.StatTrac.Domain.EReferrals;

namespace Statline.StatTrac.App.EReferrals;

public class EReferralsApplication
{
    private readonly IEReferralRepository ereferralRepository;

    public EReferralsApplication(
        IEReferralRepository referralRepository)
    {
        Check.NotNull(referralRepository, nameof(referralRepository));
        this.ereferralRepository = referralRepository;
    }

    public async Task<List<FacilityInfo>> GetFacilityCodes(string sourceCode)
    {
        return await ereferralRepository.GetFacilityCodes(sourceCode);
    }
    public async Task<int> GetSourceCodeId(string sourceCode)
    {
        return await ereferralRepository.GetSourceCodeId(sourceCode);
    }

    public async Task<List<HospitalUnit>> GetHospitalUnitList()
    {
        return await ereferralRepository.GetHospitalUnitList();
    }

    public async Task<List<ContactTitle>> GetContactTitleList()
    {
        return await ereferralRepository.GetContactTitleList();
    }
    public async Task<FacilityInfo?> GetFacilityInfo(string sourceCode, string facilityCode, string? contactFirstName, string? contactLastName)
    {
        return await ereferralRepository.GetFacilityInfo(sourceCode, facilityCode, contactFirstName, contactLastName);
    }

    public async Task<bool> IsMedicalRecordDuplicate(string sourceCode, string facilityCode, string medicalRecord)
    {
        return await ereferralRepository.IsMedicalRecordDuplicate(sourceCode, facilityCode, medicalRecord);
    }

    public async Task<HospitalUnitAndFloor?> GetHospitalUnitAndFloor(string sourceCode, string facilityCode, string phone)
    {
        return await ereferralRepository.GetHospitalUnitAndFloor(sourceCode, facilityCode, phone);
    }

    public async Task<string?> SubmitEreferral(ReferralModel referralModel)
    {
        return await ereferralRepository.SubmitEreferral(referralModel);
    }
}
