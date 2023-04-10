using Statline.StatTrac.Domain.Phones;
using Statline.StatTrac.Domain.Phones.Factory;
using System.Linq;

namespace Statline.StatTrac.App.HighLevel.Phones;

public class PhonesHighLevelApplication
{
    private readonly IPhoneRepository phoneRepository;
    private readonly PhoneFactory phoneFactory;

    public PhonesHighLevelApplication(
        IPhoneRepository phoneRepository,
        PhoneFactory phoneFactory)
    {
        this.phoneRepository = Check.NotNull(phoneRepository);
        this.phoneFactory = Check.NotNull(phoneFactory);
    }

    public async Task<int> AddOrganizationPhoneAsync(
        int organizationId,
        PhoneInfo newPhoneInfo,
        int onBehalfOfEmployeeId)
    {
        Check.NotNull(newPhoneInfo);

        var phone = await phoneFactory.CreateOrganizationPhoneFromPhoneInfoAsync(
            organizationId,
            newPhoneInfo,
            onBehalfOfEmployeeId);

        await phoneRepository.AddPhoneAsync(phone);

        return phone.PhoneId;
    }

    public IAsyncEnumerable<int> GetFilteredOrganizationPhoneIds(
        int organizationId,
        PhoneFilterCriteria filterCriteria)
    {
        Check.NotNull(filterCriteria);

        return phoneRepository.GetFilteredOrganizationPhoneIds(
            organizationId,
            filterCriteria)
            .Select(id => id.Value);
    }
}
