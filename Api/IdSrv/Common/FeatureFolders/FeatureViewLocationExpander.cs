using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.AspNetCore.Mvc.Razor;
using Statline.Common.Utilities;
using System;
using System.Collections.Generic;

namespace Statline.IdentityServer.Common.FeatureFolders
{
    public class FeatureViewLocationExpander : IViewLocationExpander
    {
        public IEnumerable<string> ExpandViewLocations(
            ViewLocationExpanderContext context,
            IEnumerable<string> viewLocations)
        {
            Check.NotNull(context, nameof(context));
            Check.NotNull(viewLocations, nameof(viewLocations));

            var controllerActionDescriptor =
                context.ActionContext.ActionDescriptor as ControllerActionDescriptor;

            if (controllerActionDescriptor == null)
            {
                throw new InvalidOperationException($"{nameof(ControllerActionDescriptor)} cannot be null.");
            }

            string featureName = (string)controllerActionDescriptor.Properties["feature"];

            foreach (var location in viewLocations)
            {
                yield return location.Replace("{3}", featureName);
            }
        }

        public void PopulateValues(ViewLocationExpanderContext context)
        {
        }
    }

}
