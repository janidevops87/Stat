﻿using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Features.IdentityAndAccess.Tenant.ViewModels
{
    public class TenantSummaryViewModel
    {
        [Display(Name = "Id")]
        public int Id { get; set; }

        [Display(Name = "Organization Name")]
        public string OrganizationName { get; set; }
    }
}
