using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using System;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace Statline.StatTrac.Api.Extensions
{
    public class WhiteListFilterMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<WhiteListFilterMiddleware> _logger;
        private readonly string _adminWhiteList;

        public WhiteListFilterMiddleware(RequestDelegate next, ILogger<WhiteListFilterMiddleware> logger, string adminWhiteList)
        {
            _adminWhiteList = adminWhiteList;
            _next = next;
            _logger = logger;
        }

        public async Task Invoke(HttpContext context)
        {
           
                var remoteIp = context.Connection.RemoteIpAddress.ToString();
                _logger.LogInformation($"Request from Remote IP address: {remoteIp}");

                string[] ip = _adminWhiteList.Split(';');
            if (!ip.Any(option => option == remoteIp))
            {
                _logger.LogInformation($"IP address not in white list: {remoteIp}");
                context.Response.StatusCode = (int)HttpStatusCode.Forbidden;
                return;

            }
                   

            await _next.Invoke(context);

        }
    }
}
