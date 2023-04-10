using System;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTracUploader.Infrastructure.Persistence.StatusProvider.DirectDbConnection
{
    public class DirectDbConnectionMainRepositoryStatusProviderOptions
    {
        [Required]
        public string ConnectionString { get; set; } = null!;
    }
}
