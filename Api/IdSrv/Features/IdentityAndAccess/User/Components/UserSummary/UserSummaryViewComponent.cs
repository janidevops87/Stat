using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Statline.Common.Utilities;
using Statline.IdentityServer.Features.IdentityAndAccess.User.ViewModels;
using Statline.IdentityServer.IdentityAndAccess.App.Users;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.Features.IdentityAndAccess.User.Components.UserSummary
{
    public class UserSummaryViewComponent : ViewComponent
    {
        private readonly UserQueryApplication userQueryApplication;
        private readonly IMapper mapper;

        public UserSummaryViewComponent(
            UserQueryApplication userQueryApplication,
            IMapper mapper)
        {
            Check.NotNull(userQueryApplication, nameof(userQueryApplication));
            Check.NotNull(mapper, nameof(mapper));
            this.userQueryApplication = userQueryApplication;
            this.mapper = mapper;
        }

        public async Task<IViewComponentResult> InvokeAsync(UserId userId)
        {
            Check.NotNull(userId, nameof(userId));

            var userSummary = await userQueryApplication.GetTenantUserSummaryAsync(userId);
            var userSummaryViewModel = mapper.Map<UserSummaryViewModel>(userSummary);
            return View(
                userSummary.IsConfirmed ? "Confirmed" : "Unconfirmed",
                userSummaryViewModel);
        }
    }
}
