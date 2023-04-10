namespace Statline.StatTrac.Domain.Referrals;

public enum DuplicateReferralsFilterType
{
    /// <summary>
    /// This filter type is StatTrac-compatible and may
    /// result in large number of duplicates found, 
    /// which may not even be real duplicates. That's OK
    /// for interactive duplicates checking, when user can
    /// see the list and make a decision.
    /// </summary>
    LastNameOrMedicalRecordNumber = 1,

    /// <summary>
    /// This filter type takes into account only Medical Record Number,
    /// so the results set will be pretty narrow. This is a good choice
    /// when no user is involved in the check, so no false duplicates 
    /// will be reported.
    /// </summary>
    MedicalRecordNumber = 2
}