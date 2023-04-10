using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Statline.Registry.Common
{
    /// <summary>
    /// Enumeration of the Types of Validation Error
    /// Messages that we provide multi-lingual formatting for
    /// </summary>
    public enum ValidationErrorMessageTypes
    {
        DEFAULT,
        LENGTH_LIMITATION,
        SIGNATURE_CHECKBOX_NOT_SET
    }
    /// <summary>
    /// Creates a Formatted Validation Error Message
    /// based on the Language and Type of Validation Error
    /// Languages Currently Supported: English (EN) and Spanish (ES)
    /// </summary>
   public  class ValidationErrorMessage
    {
        #region Constants
        const string defaultMessage_English = "Please correct the following items highlighted in yellow:";
        const string defaultMessage_Spanish = "Por favor, corrija los siguientes elementos resaltados en amarillo:";
        
        const string lengthLimitationMessagePrefix_English = "Please limit text to no more than ";
        const string lengthLimitationMessageSuffix_English = " characters.";
        
        const string lengthLimitationMessagePrefix_Spanish = "Favor de limitar el texto a no más de " ;
        const string lengthLimitationMessageSuffix_Spanish = " caracteres.";

        const string signatureCheckBoxNotSetMessage_English = "Your signature will not be submitted unless the checkbox has been selected";
        const string signatureCheckBoxNotSetMessage_Spanish = "Su firma no se presentará si no se ha seleccionado la casilla de verificación";
        #endregion

        #region Properties
        protected string LanguageCode { get; set; }
        public string ErrorMessage { get; set; }
        #endregion

        #region Constructors
        /// <summary>
        /// Constructor for ValidationErrorMessage Class that does not accept Custom Error Text
        /// </summary>
        /// <param name="ValidationError">Type of Validation Error</param>
        /// <param name="language">Language Code. ES = Spanish, EN = English, M = English</param>
        public ValidationErrorMessage(ValidationErrorMessageTypes ValidationError, string language)
        {
            SetLanguage(language);
            FormatValidationErrorMessage(ValidationError);
        }
        /// <summary>
        /// Constructor for ValidationErrorMessage that accepts Custom Error Text
        ///  Custom Error Text may not display if the ValidationErrorMessageType does not support Custom Error Text
        /// </summary>
        /// <param name="ValidationError">Type of Validation Error</param>
        /// <param name="language">Language Code. ES = Spanish, EN = English, M = English</param>
        /// <param name="errorSpecificText">Error Specific Text. For Example number of character limitation </param>
        public ValidationErrorMessage(ValidationErrorMessageTypes ValidationError, string language, string errorSpecificText)
        {
            SetLanguage(language);
            FormatValidationErrorMessage(ValidationError, errorSpecificText);
        }
        #endregion

        #region Private Methods
        /// <summary>
        /// Produces Formatted Validation Error Message based on the Message Type and the Language Specified
        /// </summary>
        /// <param name="ValidationError">Type of Validation Error</param>
        /// <param name="errorSpecificText">Message specific to the error, if the Validation Type supports custome messages</param>
        private void FormatValidationErrorMessage(ValidationErrorMessageTypes ValidationError, string errorSpecificText = null)
        {
            string formattedValidationErrorMessage = string.Empty;
            
            if(LanguageCode == "ES")
            {
                switch (ValidationError)
                {
                    case  ValidationErrorMessageTypes.LENGTH_LIMITATION:
                        formattedValidationErrorMessage = lengthLimitationMessagePrefix_Spanish + errorSpecificText + lengthLimitationMessageSuffix_Spanish;
                        break;
                    case ValidationErrorMessageTypes.SIGNATURE_CHECKBOX_NOT_SET:
                        formattedValidationErrorMessage = signatureCheckBoxNotSetMessage_Spanish;
                        break;
                    default:
                        formattedValidationErrorMessage = defaultMessage_Spanish;
                        break;
                }
            }
            else{
                switch (ValidationError)
                {
                    case ValidationErrorMessageTypes.LENGTH_LIMITATION:
                        formattedValidationErrorMessage = lengthLimitationMessagePrefix_English + errorSpecificText + lengthLimitationMessageSuffix_English;
                        break;
                    case ValidationErrorMessageTypes.SIGNATURE_CHECKBOX_NOT_SET:
                        formattedValidationErrorMessage = signatureCheckBoxNotSetMessage_English;
                        break;
                    default:
                        formattedValidationErrorMessage = defaultMessage_English;
                        break;
                }
            }

            ErrorMessage = formattedValidationErrorMessage;
        }
        /// <summary>
        /// Sets Language Code. Currently only supports English and Spanish. "Mobile" defaults to English
        /// </summary>
        /// <param name="language">Language Code. ES = Spanish, EN = English, M = English</param>
        private void SetLanguage(string language){            
            if (language.ToUpper() == "ES")
            {
                LanguageCode = language.ToUpper();
            }
            else //default to English for Mobile and English language codes
            { 
                LanguageCode = "EN";
            }
        }
        #endregion  
    }
}
