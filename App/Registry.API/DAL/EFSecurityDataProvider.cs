using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using Registry.Common.DTO;

namespace Registry.API.DAL
{
    public class EFSecurityDataProvider : EFDataProviderBase, ISecurityDataProvider
    {
        public async Task<IList<RegistryOwner>> GetClients()
        {
            using (var context = RegistryDb)
            {
                return await context.RegistryOwner.AsNoTracking().Select(x => new RegistryOwner
                {
                    RegistryOwnerId = x.RegistryOwnerId,
                    RegistryOwnerName = x.RegistryOwnerName,
                    RegistryOwnerRouteName = x.RegistryOwnerRouteName,
                    AllowDisplayNoDonors = x.AllowDisplayNoDonors ?? false,
                    CaptchaOn = x.CaptchaOn,
                    Emails = x.RegistryOwnerElectronicSignatureTexts.Select(e => new RegistryOwnerEmail
                    {
                        EmailFrom = e.EmailFrom,
                        EmailMailboxAccount = e.EmailMailboxAccount,
                        LanguageCode = e.LanguageCode
                    }).ToList(),
                    DMVStates = x.RegistryOwnerStateConfigs
                        .Where(s => !s.DisableDMVSearchOption)
                        .Select(s => s.RegistryOwnerStateAbbrv)
                        .Distinct()
                        .ToList()
                }).ToListAsync();
            }
        }

        public async Task<UserAuthenticationTicket> Login(string userName, string password)
        {
            UserAuthenticationTicket ticket = null;

            using (var refContext = ReferralDb)
            {
                //todo: password isn't even encrypted??
                var webPerson = refContext.WebPerson.Include(x => x.Person)
                    .FirstOrDefault(x => x.WebPersonUserName.Equals(userName) && x.WebPersonPassword.Equals(password));

                if (webPerson != null)
                {
                    var orgId = webPerson.Person.OrganizationId;

                    using (var regContext = RegistryDb)
                    {
                        ticket = await regContext.RegistryOwner
                            .Where(x => x.RegistryOwnerUserOrgs.Any(o => o.UserOrgId == orgId))
                            .Select(x => new UserAuthenticationTicket
                            {
                                RegistryOwnerId = x.RegistryOwnerId,
                                RegistryOwnerRouteName = x.RegistryOwnerRouteName,
                                UserName = webPerson.Person.FullName,
                                Login = webPerson.WebPersonUserName
                            }).FirstAsync();
                    }
                }

            }

            return ticket;
        }
    }
}
