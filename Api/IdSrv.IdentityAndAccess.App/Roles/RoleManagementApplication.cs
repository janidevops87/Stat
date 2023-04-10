using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Statline.Common.Utilities;
using Statline.IdentityServer.IdentityAndAccess.App.Common;
using Statline.IdentityServer.IdentityAndAccess.App.Roles.Dto;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Command;
using Statline.IdentityServer.IdentityAndAccess.Domain.Model.Common;

namespace Statline.IdentityServer.IdentityAndAccess.App.Roles
{
    public class RoleManagementApplication
    {
        private readonly IRoleRepository roleRepository;
        private readonly IMapper mapper;
        private readonly RoleManager<Role> roleManager;

        public RoleManagementApplication(
            IRoleRepository roleRepository,
            IMapper mapper,
            RoleManager<Role> roleManager)
        {
            Check.NotNull(mapper, nameof(mapper));
            Check.NotNull(roleManager, nameof(roleManager));
            this.roleRepository = roleRepository;
            this.mapper = mapper;
            this.roleManager = roleManager;
        }

        public async Task<IEnumerable<RoleListSummaryInfo>> ListRolesAsync()
        {
            var roles = await roleRepository.ListRolesAsync();
            return mapper.Map<IEnumerable<RoleListSummaryInfo>>(roles);
        }

        public async Task<RoleId> CreateRoleAsync(NewRoleInfo newRoleInfo)
        {
            Check.NotNull(newRoleInfo, nameof(newRoleInfo));

            var newRole = mapper.Map<Role>(newRoleInfo);

            var result = await roleManager.CreateAsync(newRole);
            result.ThrowIfFailed();

            return newRole.Id;
        }

        public async Task DeleteRoleAsync(RoleId roleId)
        {
            Check.NotNull(roleId, nameof(roleId));

            var role = await roleManager.GetById(roleId);
            var result = await roleManager.DeleteAsync(role);
            result.ThrowIfFailed();
        }

        public async Task<RolePartInfo<RolePropertiesInfo>>
            GetRolePropertiesAsync(RoleId roleId)
        {
            Check.NotNull(roleId, nameof(roleId));

            var role = await roleManager.GetById(roleId);

            var roleProps = mapper.Map<RolePartInfo<RolePropertiesInfo>>(role);

            return roleProps;
        }

        public async Task UpdateRolePropertiesAsync(
            RoleId roleId,
            RolePropertiesInfo propsInfo)
        {
            Check.NotNull(roleId, nameof(roleId));
            Check.NotNull(propsInfo, nameof(propsInfo));

            var role = await roleManager.GetById(roleId);

            // RoleManager implements some security checks and normalization,
            // so instead of just updating the whole role entity we 
            // do it step-by-step.

            if (!string.Equals(propsInfo.Name, role.Name, StringComparison.Ordinal))
            {
                var result = await roleManager.SetRoleNameAsync(role, propsInfo.Name);
                result.ThrowIfFailed();

                result = await roleManager.UpdateAsync(role);
                result.ThrowIfFailed();
            }
        }
    }
}
