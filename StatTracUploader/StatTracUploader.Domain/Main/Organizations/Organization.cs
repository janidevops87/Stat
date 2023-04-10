namespace Statline.StatTracUploader.Domain.Main.Organizations
{
    public class Organization
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