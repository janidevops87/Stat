using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.BusinessVeracity.EodProcessor.Infrastructure.FileStorage.AmazonS3;

public class AmazonS3FileStorageOptions
{
    [Required]
    public string AwsAccessKeyId { get; set; } = default!;

    [Required]
    public string AwsSecretAccessKey { get; set; } = default!;

    [Required]
    public string RegionEndpointName { get; set; } = default!;

    [Required]
    public string BucketName { get; set; } = default!;
}
