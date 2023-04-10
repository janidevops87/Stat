using Statline.StatTrac.Domain.Common;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.Api.ViewModels.Common;

public record PersonAgeViewModel(
    [Range(minimum:1, int.MaxValue, ErrorMessage ="Age must be positive value.")]
    int Value,
    AgeUnit Unit);
