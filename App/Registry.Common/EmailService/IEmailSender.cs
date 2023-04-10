using System.Collections.Generic;
using Registry.Common.DTO;

namespace Registry.Common.EmailService
{
    public interface IEmailSender
    {
        void SendEmails(List<Email> emails, RegistryOwnerEmail registryOwnerEmail);
    }
}
