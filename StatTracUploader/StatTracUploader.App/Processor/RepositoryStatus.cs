using System;

namespace Statline.StatTracUploader.App.Processor
{
    public record RepositoryStatus(
        RepositoryAvailability Availability, 
        DateTimeOffset LastCheckAt, 
        DateTimeOffset NextCheckAt);
}