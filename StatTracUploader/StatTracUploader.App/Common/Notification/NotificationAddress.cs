using Statline.Common.Utilities;
namespace Statline.StatTracUploader.App.Common.Notification
{
    public record NotificationAddress
    {
        public string Address { get; }
        public string? Name { get; }

        public NotificationAddress(string address, string? name)
        {
            Check.NotEmpty(address, nameof(address));
            Address = address;
            Name = name;
        }
    }
}
