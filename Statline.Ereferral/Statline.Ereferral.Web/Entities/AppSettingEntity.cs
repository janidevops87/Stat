using System.ComponentModel.DataAnnotations.Schema;

namespace Statline.Ereferral.Web.Entities
{
    [Table("AppSetting")]
    public class AppSettingEntity
    {
        public int Id { get; set; }
        public string Key { get; set; }
        public string Value { get; set; }
    }
}