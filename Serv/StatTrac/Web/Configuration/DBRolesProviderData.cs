using System.Xml.Serialization;
using Microsoft.Practices.EnterpriseLibrary.Security.Configuration;
using Statline.StatTrac.Web.Security;

namespace Statline.StatTrac.Web.Configuration
{
	/// <summary>
	/// Configuration data for the Database Roles Provider.
	/// </summary>
	//[XmlRoot("rolesProvider", Namespace=SecuritySettings.ConfigurationNamespace)]
	public class DBRolesProviderData //: RolesProviderData
	{
    //    private string database;

    //    /// <summary>
    //    /// <para>Initialize a new instance of the <see cref="DBRolesProviderData"/> class.</para>
    //    /// </summary>
    //    public DBRolesProviderData() : this(string.Empty, string.Empty)
    //    {
    //    }

    //    /// <summary>
    //    /// <para>Initialize a new instance of the <see cref="DBRolesProviderData"/> class with a name and a database instance name.</para>
    //    /// </summary>
    //    /// <param name="name">
    //    /// <para>The name of the provider.</para>
    //    /// </param>
    //    /// <param name="database">
    //    /// <para>The name of the database instance where the roles are persisted.</para>
    //    /// </param>
    //    public DBRolesProviderData(string name, string database) : base(name)
    //    {
    //        this.database = database;
    //    }

    //    /// <summary>
    //    /// Gets or sets the configured Database instance name.
    //    /// </summary>
    //    /// <value>The configured database instance.</value>
    //    [XmlAttribute(AttributeName = "database")]
    //    public string Database
    //    {
    //        get { return this.database; }
    //        set { this.database = value; }
    //    }

    //    /// <summary>
    //    /// Gets the assembly qualified name of this provider.
    //    /// </summary>
    //    [XmlIgnore]
    //    public override string TypeName
    //    {
    //        get { return typeof(DBRolesProvider).AssemblyQualifiedName; }
    //        set
    //        {
    //        }
    //    }
    }
}