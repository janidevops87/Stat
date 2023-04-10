﻿using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Statline.Common.Infrastructure.Networking.RestClient;
using Statline.StatTrac.Integration.Api.Security;
using Statline.StatTrac.Integration.Api.ViewModels.Copernicus;
using Statline.StatTrac.Integration.App.Copernicus;
using System.Net;

namespace Statline.StatTrac.Integration.Api.Controllers;

[Authorize(AuthorizationPolicies.Copernicus)]
[Route("api/[controller]")]
[ApiController]
public class Copernicus : ControllerBase
{
    private readonly CopernicusApp copernicusApp;
    private readonly IMapper mapper;

    public Copernicus(
        CopernicusApp copernicusApp,
        IMapper mapper)
    {
        this.copernicusApp = copernicusApp;
        this.mapper = mapper;
    }

    [HttpPost("referrals", Name = nameof(AddReferral))]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<ActionResult<int>> AddReferral(NewReferralViewModel newReferral)
    {
        var newReferralInfo = mapper.Map<NewReferralInfo>(newReferral);

        int callId;

        try
        {
            callId = await copernicusApp.AddReferralAsync(newReferralInfo);
        }
        // Below exception handlers basically forward StatTrac API errors
        // to the client of this API. We're not trying
        // to make full illusion that these errors are generated by this API.
        // It's probably not even possible given that StatTrac API has
        // very different shape. To make this explicit, original error
        // is wrapped in another object. This includes Problem Details, so
        // the error response is not that "machine-readable" as it is
        // when Problem Details returned directly. The here goal is to give
        // the client error explanation for humans, which can be read or logged.
        // If we need more consistent error reporting, so client code can
        // make some decisions based on that, we need to do more work on this.
        catch (HttpApiException<Common.Infrastructure.Networking.RestClient.ProblemDetails> ex)
        when (ex.StatusCode == HttpStatusCode.BadRequest)
        {
            return MakeBadRequestResult(ex);
        }
        catch (HttpApiException<string> ex)
        when (ex.StatusCode == HttpStatusCode.BadRequest)
        {
            return MakeBadRequestResult(ex);
        }

        return CreatedAtAction(nameof(FindReferralByCallNumber),
            new { callId },
            value: callId);
    }

    // Hide this api from swagger docs until it's implemented.
    [ApiExplorerSettings(IgnoreApi = true)]
    [HttpGet("referrals/bycallid/{callId:int:min(1)}", Name = nameof(FindReferralByCallNumber))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public ActionResult FindReferralByCallNumber(int callId)
    {
        return BadRequest("Not implemented");
    }

    private BadRequestObjectResult MakeBadRequestResult<TContent>(HttpApiException<TContent> ex)
       where TContent : notnull
    {
        return BadRequest(new
        {
            Message = "Underlying StatTrac API responded with an error.",
            Reponse = ex.Content
        });
    }
}