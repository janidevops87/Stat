using Statline.StatTrac.Domain.Common;
using System.ComponentModel.DataAnnotations;

namespace Statline.StatTrac.Api.ViewModels.Common;

public record PersonWeightViewModel(
    [Range(double.Epsilon, double.MaxValue, ErrorMessage ="Weight must be positive value.")]
    float Value,
    WeightUnit Unit);
