using Moq;
using Stattrac.Services.Donor;
using Stattrac.Services.Donor.Registry;
using Stattrac.Services.Donor.Registry.Model;
using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using Xunit;

namespace StattracCS.Tests
{
    public partial class DonorServiceTests
    {
        [Theory]
        [MemberData(nameof(GetDonorFilteringScenariosData))]
        public async Task TestDonorFilteringScenarios(
            DonorSearchResult[] allSearchResults,
            DonorSearchResult[] expectedFinalSearchResults)
        {
            var registryApiClientMock = new Mock<IDonorRegistry>();
            var configurationProviderMock = new Mock<IDonorServiceConfigurationProvider>();

            // The configuration doesn't matter in this case.
            var config = new DonorServiceConfiguration(
                new DonorSearchConfiguration(
                    includeDlaDonors: true,
                    states: Enumerable.Empty<string>(),
                    registryOwnerIds: Enumerable.Empty<int>()),
                new DmvStateMappingConfiguration(
                    dsnIdToStateMap: ImmutableDictionary<short, string>.Empty));

            configurationProviderMock.Setup(p => p.GetConfigurationAsync()).ReturnsAsync(config);

            registryApiClientMock.Setup(c => c.SearchDonorsAsync(
                It.IsAny<DonorSearchRequest>(),
                It.IsAny<DonorSearchConfiguration>())).ReturnsAsync(allSearchResults);

            var target = new DonorService(
                registryApiClientMock.Object,
                configurationProviderMock.Object);

            var searchRequest = new DonorSearchRequest(
                donorFirstName: "Bret",
                donorLastName: "Knoll",
                dateOfBirth: DateTime.Parse("11/17/1970", CultureInfo.InvariantCulture));

            var finalSearchResults = await target.SearchRegistryAsync(searchRequest);

            Assert.Equal(expectedFinalSearchResults, finalSearchResults);
        }

        public static IEnumerable<object[]> GetDonorFilteringScenariosData()
        {
            var scenario1SearchResults = GetScenario1SearchResults();
            var scenario2SearchResults = GetScenario2SearchResults();
            var scenario3SearchResults = GetScenario3SearchResults();
            var scenario4SearchResults = GetScenario4SearchResults();
            var scenario5SearchResults = GetScenario5SearchResults();
            var scenario6SearchResults = GetScenario6SearchResults();
            var scenario7SearchResults = GetScenario7SearchResults();
            var scenario8SearchResults = GetScenario8SearchResults();

            return new List<object[]>
            {
                new object[]
                {
                    // all search results
                    scenario1SearchResults,
                    // expected filtered search results
                    scenario1SearchResults.AsSpan().Slice(start: 0, length: 1).ToArray()
                },
                new object[]
                {
                    // all search results
                    scenario2SearchResults,
                    // expected filtered search results
                    scenario2SearchResults.AsSpan().Slice(start: 0, length: 1).ToArray()
                },
                new object[]
                {
                    // all search results
                    scenario3SearchResults,
                    // expected filtered search results
                    scenario3SearchResults
                },
                new object[]
                {
                    // all search results
                    scenario4SearchResults,
                    // expected filtered search results
                    scenario4SearchResults
                },
                new object[]
                {
                    // all search results
                    scenario5SearchResults,
                    // expected filtered search results
                    scenario5SearchResults.AsSpan().Slice(start: 1, length: 1).ToArray()
                },
                new object[]
                {
                    // all search results
                    scenario6SearchResults,
                    // expected filtered search results
                    scenario6SearchResults.AsSpan().Slice(start: 2, length: 1).ToArray()
                },
                new object[]
                {
                    // all search results
                    scenario7SearchResults,
                    // expected filtered search results
                    scenario7SearchResults
                },
                new object[]
                {
                    // all search results
                    scenario8SearchResults,
                    // expected filtered search results
                    scenario8SearchResults
                }
            };
        }

        private static DonorSearchResult[] GetScenario1SearchResults()
        {
            return new DonorSearchResult[]
            {
                CreateDonorSearchResult(id: 0, registryType: DonorRegistryType.Dla, donorDate: "08/17/2020", sid: null),
                CreateDonorSearchResult(id: 1, registryType: DonorRegistryType.Dmv, donorDate: "11/21/2018", sid: "921243832"),
                CreateDonorSearchResult(id: 2, registryType: DonorRegistryType.Web, donorDate: "09/20/2002", sid: null),
             };
        }


        private static DonorSearchResult[] GetScenario2SearchResults()
        {
            return new DonorSearchResult[]
            {
                CreateDonorSearchResult(id: 0, registryType: DonorRegistryType.Dla, donorDate: "08/17/2020", sid: null),
                CreateDonorSearchResult(id: 1, registryType: DonorRegistryType.Dmv, donorDate: "11/21/2018", sid: "921243832"),
                CreateDonorSearchResult(id: 2, registryType: DonorRegistryType.Web, donorDate: "09/20/2002", sid: "921243832"),
             };
        }

        private static DonorSearchResult[] GetScenario3SearchResults()
        {
            return new DonorSearchResult[]
            {
                CreateDonorSearchResult(id: 0, registryType: DonorRegistryType.Dla, donorDate: "08/17/2020", sid: null),
                CreateDonorSearchResult(id: 1, registryType: DonorRegistryType.Dmv, donorDate: "11/21/2018", sid: "921243832"),
                CreateDonorSearchResult(id: 2, registryType: DonorRegistryType.Web, donorDate: "09/20/2002", sid: "999999999")
            };
        }

        private static DonorSearchResult[] GetScenario4SearchResults()
        {
            return new DonorSearchResult[]
            {
                CreateDonorSearchResult(id: 0, registryType: DonorRegistryType.Dla, donorDate: "08/17/2016", sid: null),
                CreateDonorSearchResult(id: 1, registryType: DonorRegistryType.Dmv, donorDate: "11/21/2018", sid: "921243832"),
                CreateDonorSearchResult(id: 2, registryType: DonorRegistryType.Web, donorDate: "09/20/2002", sid: "999999999")
            };
        }

        private static DonorSearchResult[] GetScenario5SearchResults()
        {
            return new DonorSearchResult[]
            {
                CreateDonorSearchResult(id: 0, registryType: DonorRegistryType.Dla, donorDate: "08/17/2016", sid: null),
                CreateDonorSearchResult(id: 1, registryType: DonorRegistryType.Dmv, donorDate: "11/21/2018", sid: "921243832"),
                CreateDonorSearchResult(id: 2, registryType: DonorRegistryType.Web, donorDate: "09/20/2002", sid: "921243832")
            };
        }

        private static DonorSearchResult[] GetScenario6SearchResults()
        {
            return new DonorSearchResult[]
            {
                CreateDonorSearchResult(id: 0, registryType: DonorRegistryType.Dla, donorDate: "08/17/2016", sid: null),
                CreateDonorSearchResult(id: 1, registryType: DonorRegistryType.Dmv, donorDate: "11/01/2015", sid: "921243832"),
                CreateDonorSearchResult(id: 2, registryType: DonorRegistryType.Web, donorDate: "01/01/2018", sid: "921243832")
            };
        }

        private static DonorSearchResult[] GetScenario7SearchResults()
        {
            return new DonorSearchResult[]
            {
                CreateDonorSearchResult(id: 0, registryType: DonorRegistryType.Dla, donorDate: "08/17/2017", sid: null),
                CreateDonorSearchResult(id: 1, registryType: DonorRegistryType.Dla, donorDate: "08/17/2016", sid: null),
                CreateDonorSearchResult(id: 2, registryType: DonorRegistryType.Dmv, donorDate: "11/01/2015", sid: "921243832"),
            };
        }

        private static DonorSearchResult[] GetScenario8SearchResults()
        {
            return new DonorSearchResult[]
            {
                CreateDonorSearchResult(id: 0, registryType: DonorRegistryType.Dla, donorDate: "08/17/2017", sid: null),
                CreateDonorSearchResult(id: 1, registryType: DonorRegistryType.Dla, donorDate: "08/17/2016", sid: null),
            };
        }

        private static DonorSearchResult CreateDonorSearchResult(
            int id,
            DonorRegistryType registryType,
            string sid,
            string donorDate)
        {
            return new DonorSearchResult(
                id,
                new DonorRegistryInfo(
                    registryType,
                    registryState: null,
                    registryOwnerState: null),
                new DonorPerson(
                    new DonorName(
                         firstName: "Bret", middleName: "", lastName: "Knoll"),
                    new DonorAddress(
                        address1: "330 Two Rivers Road",
                        address2: null,
                        city: "Salida",
                        state: "CO",
                        zip: "81201"),
                    dateOfBirth: DateTime.Parse("11/17/1970", CultureInfo.InvariantCulture),
                    sid: sid, //!
                    ssn: null),
                verificationForm: null,
                donorDate: DateTime.Parse(donorDate, CultureInfo.InvariantCulture),//!
                donorDateType: null,
                onRegistry: true,
                donorConfirmed: true);
        }
    }
}
