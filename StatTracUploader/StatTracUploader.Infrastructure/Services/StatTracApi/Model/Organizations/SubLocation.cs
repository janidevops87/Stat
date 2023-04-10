﻿namespace Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Organizations
{
    internal class SubLocation
    {
        public SubLocation(int id, string? name, string? level)
        {
            Id = id;
            Name = name;
            Level = level;
        }

        public int Id { get; }
        public string? Name { get; }
        public string? Level { get; }
    }
}
