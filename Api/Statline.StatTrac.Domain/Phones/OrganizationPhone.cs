using Statline.StatTrac.Domain.Common;

namespace Statline.StatTrac.Domain.Phones;

public class OrganizationPhone : Phone
{
    // From EF perspective this is not usual situation
    // when there is inheritance. EF uses base entity's ID as PK
    // for base AND inherited entity when TPT strategy is used.
    // However, since we're adopting existing DB, we have to live
    // with already existing additional ID of inherited entity.
    public int OrganizationPhoneId { get; set; }

    public int? OrganizationId { get; set; }
   
    // Base class has the same properties, so these have to have unique names so that
    // they don't hide those from the base class. Hence the prefix.
    public DateTimeOffset? OrganizationPhoneLastModified { get; set; }
    public int? OrganizationPhoneLastStatEmployeeId { get; set; }
    public AuditLogType? OrganizationPhoneAuditLogTypeId { get; set; }
    public IntegerBoolean OrganizationPhoneInactive { get; set; }

    /// <remarks>
    /// Each sub-location in an organization can have multiple 
    /// organization phones associated with it.
    /// Each organization phone can have single sub-location
    /// associated with it.
    /// </remarks>
    public int? SubLocationId { get; set; }
    
    // I believe this property is a legacy way to store
    // sub-location level information using separate
    // SubLocationLevel entity.
    // Today, that referenced entity should NOT be used.
    // public int? SubLocationLevelId { get; set; }

    /// <summary>
    /// Gets or set the name of sub-location level (floor).
    /// </summary>
    public string? SubLocationLevel { get; set; }
}
