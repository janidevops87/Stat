using System.ComponentModel.DataAnnotations;

namespace Registry.Common.Enums
{
    public enum VerificationSource
    {
        [Display(Name = "Web")]
        Web = 1,
        [Display(Name = "DMV")]
        DMV = 2,
        [Display(Name = "Donate Life America")]
        DLA = 3,
    }
}
