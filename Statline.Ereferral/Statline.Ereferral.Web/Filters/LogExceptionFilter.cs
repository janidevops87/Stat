﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Statline.Ereferral.Web.Services;
using System;
using System.Net;

namespace Statline.Ereferral.Web.Filters
{
    public class LogExceptionFilter : IExceptionFilter
    {
        private ILogger _logger;
        private EreferralSettings _setting;

        public LogExceptionFilter(ILogger<LogExceptionFilter> logger, IOptions<EreferralSettings> setting)
        {
            _logger = logger;
            _setting = setting.Value;
        }

        public void OnException(ExceptionContext context)
        {
            // Log the exception
            LogException(context.Exception, 0, context.HttpContext.Session.Id);
            // Return the exception message without the stacktrace to the user
            HttpResponse response = context.HttpContext.Response;
            response.StatusCode = (int)HttpStatusCode.BadRequest;
            response.WriteAsync(JsonConvert.SerializeObject(new { modelError = context.Exception.Message }));
            context.ExceptionHandled = true;
        }

        /// <summary>
        /// Log all the exception along with any inner exception
        /// </summary>
        /// <param name="ex"></param>
        /// <param name="level"></param>
        private void LogException(Exception ex, int level, string sessionId)
        {
            try
            {
                if (ex != null)
                {
                    _logger.LogError(ex, $"{sessionId ?? "NoSessionId"}--{ex.Message} {ex.StackTrace} ({level})");
                    LogException(ex.InnerException, level + 1, sessionId);
                }
            }
            catch (Exception)
            {
                // We don't want to logging to break the system
            }
        }
    }
}