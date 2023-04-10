#nullable disable

namespace Statline.StatTrac.Domain.EReferrals;

public class ReferralModel
{

    public int sourceCodeId { get; set; }
    public string facilityEreferralCode { get; set; }
    public int timeZoneId { get; set; }
    public string timeZone { get; set; }
    public int statEmployeeId { get; set; }
    public string contactFirstName { get; set; }
    public string contactLastName { get; set; }
    public int? contactTitleId { get; set; }
    public string callbackPhoneNumber { get; set; }
    public DateTime? cardiacDeathDateTime { get; set; }
    public string cardiacDeathDate { get; set; }
    public string cardiacDeathTime { get; set; }
    public string donorRecoveryLocation { get; set; }
    public int heartbeatId { get; set; }
    public int ventilatorId { get; set; }
    public string ventilatorName { get; set; }
    public string referralFacility { get; set; }
    public int? hospitalUnitId { get; set; }
    public string floor { get; set; }
    public string medicalRecordNumber { get; set; }
    public string legalFirstName { get; set; }
    public string legalLastName { get; set; }
    public string identityUnknown { get; set; }
    public DateTime? admitDateTime { get; set; }
    public string admitDate { get; set; }
    public string admitTime { get; set; }
    public DateTime? dob { get; set; }
    public int? age { get; set; }
    public int? ageUnitId { get; set; }
    public string ageUnitName { get; set; }
    public string ageEstimated { get; set; }
    public int? raceId { get; set; }
    public string raceName { get; set; }
    public int? sexId { get; set; }
    public string sexName { get; set; }
    public string weight { get; set; }
    public int? weightUnitId { get; set; }
    public string weightUnitName { get; set; }
    public string weightEstimated { get; set; }
    public DateTime? extubationDateTime { get; set; }
    public string extubationTime { get; set; }
    public string extubationDate { get; set; }
    public string admittingDiagnosis { get; set; }
    public string medicalHistory { get; set; }
    public int aids { get; set; }
    public int hiv { get; set; }
    public int hepB { get; set; }
    public int hepC { get; set; }
    public int ivda { get; set; }
    public string recaptcha { get; set; }
    public string authorizationCode { get; set; }
    public string callbackPhoneNumberExtension { get; set; }
    public int organizationId { get; set; }
    public DateTime? callDateTime { get; set; }
    public int? causeOfDeathId { get; set; }
}