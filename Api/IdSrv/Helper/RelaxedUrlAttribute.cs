using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using Statline.Common.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Statline.IdentityServer.Helper
{
    /// <summary>
    /// Provides URL validation which is similar to <see cref="UrlAttribute"/>
    /// but allows host names like <c>localhost</c>.
    /// </summary>
    /// <remarks>
    /// For this validation to work on client side you must:
    /// 1. Reference additional validation methods which are located in
    /// 'additional-methods.js' file (part of 'jquery-validation' package);
    /// 2. Register 'url2' unobtrusive validation adapter in JS like this: 
    /// <c>jQuery.validator.unobtrusive.adapters.addBool('url2')</c>.
    /// See how its done for 'url' here:
    /// https://github.com/aspnet/jquery-validation-unobtrusive/blob/e7444c9ab5512d455069815e23b954ce2e7b2518/src/jquery.validate.unobtrusive.js#L369
    /// 
    /// Note, that this attribute doesn't try to make client
    /// and server validation exactly the same.
    /// </remarks>
    // NOTE: This attribute leads to producing "type='text'" (not 'url') inputs.
    // If concerned, further development should be done.
    [AttributeUsage(
        AttributeTargets.Property |
        AttributeTargets.Field |
        AttributeTargets.Parameter,
        AllowMultiple = false)]
    public class RelaxedUrlAttribute : ValidationAttribute, IClientModelValidator
    {
        private const string DefaultErrorMessage = "The {0} is not a valid fully-qualified URL.";
        private static readonly ValidationResult ErrorResult =
            new ValidationResult(errorMessage: null);

        public RelaxedUrlAttribute()
            : base(DefaultErrorMessage)
        {
        }

        public void AddValidation(ClientModelValidationContext context)
        {
            Check.NotNull(context, nameof(context));

            var message = GetErrorMessage(context);

            // Using jQuery Unobtrusive Validation:
            // https://github.com/aspnet/jquery-validation-unobtrusive.
            MergeAttribute(context.Attributes, "data-val", "true");
            MergeAttribute(context.Attributes, "data-val-url2", message);
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            switch (value)
            {
                case Uri uri:
                    return ValidateUri(uri);
                case string strUri:
                    if (!Uri.TryCreate(strUri, UriKind.RelativeOrAbsolute, out var createdUri))
                    {
                        return ErrorResult;
                    }
                    return ValidateUri(createdUri);
                case null:
                    break;
                default:
                    // This means not a validation error, but
                    // wrong attribute usage.
                    throw new InvalidOperationException("The object instance is not convertible to a URI.");
            }

            return ValidationResult.Success;
        }

        private ValidationResult ValidateUri(Uri uri)
        {
            // Below each error result is the same object without 
            // a message to make framework generate error message based
            // on the ErrorMessage property (if specified). 
            // We could return specific messages, but this would
            // break user expectations regarding ErrorMessage property.

            if (!uri.IsAbsoluteUri)
            {
                return ErrorResult;
            }

            // This check is to match the client-side url2 validation, see here:
            // https://github.com/jquery-validation/jquery-validation/blob/master/src/additional/url2.js
            if (uri.Scheme != Uri.UriSchemeHttp &&
                uri.Scheme != Uri.UriSchemeHttps &&
                uri.Scheme != Uri.UriSchemeFtp)
            {
                return ErrorResult;
            }

            return ValidationResult.Success;
        }

        private bool MergeAttribute(
            IDictionary<string, string> attributes,
            string key,
            string value)
        {
            if (attributes.ContainsKey(key))
            {
                return false;
            }

            attributes.Add(key, value);
            return true;
        }

        private string GetErrorMessage(ClientModelValidationContext context)
        {
            string memberDisplayName =
                context.ModelMetadata.DisplayName ?? context.ModelMetadata.PropertyName;

            var message = FormatErrorMessage(memberDisplayName);

            return message;
        }
    }
}
