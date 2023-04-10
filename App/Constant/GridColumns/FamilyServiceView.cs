namespace Statline.Stattrac.Constant.GridColumns
{
    public enum PendingSecondaryActivity
    { 
        CallNumber,
        LogEventCalloutDateTime,
        SourceCodeName,
        LogEventName,
        LogEventPerson,
        FSCaseOpen,
        FSCaseSystemEvent,
        FSCaseSecondaryComplete,
        FSCaseApproached
    }
    public enum PendingSecondaryAlert
    { 
        CallNumber,
        FSCaseCreateDateTime,
        OrganizationName,
        PersonName,
        SourceCodeName
    }
    public enum PendingSecondaryWIP
    { 
        CallNumber,
        FSCaseCreateDateTime,
        OrganizationName,
        PersonName,
        FSCaseOpen,
        FSCaseSystemEvent,
        FSCaseSecondaryComplete,
        FSCaseApproached
    }
}
