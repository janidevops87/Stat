namespace Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Organizations
{
    internal class Organization
    {
        public Organization(int id, string? name)
        {
            Id = id;
            Name = name;
        }

        public int Id { get; }
        public string? Name { get; }
    }
}
