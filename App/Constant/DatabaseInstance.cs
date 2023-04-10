namespace Statline.Stattrac.Constant
{
    public enum DatabaseInstance
    {
        Production,
        Test,
        Backup,
        ProductionArchive,
        Training,
        Development
    }
    /// <summary>
    /// Used for StatTrac DLL compatibility
    /// when opening legacy forms.
    /// </summary>
    public enum ConnectionType
    {
        PROD_CONN = 0,
        TEST_CONN = 1,
        PROD_BKUP_CONN = 2,
        ARCHIVE = 3,
        TRAINING_CONN = 4,
        DEVELOPMENT = 5,
        ISSUES = 6,
        INTERNET = 7
    }
}
