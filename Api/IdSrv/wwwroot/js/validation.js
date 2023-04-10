// This gets executed on script load.
(function () {
    AddUrl2Validation();
}());

function AddUrl2Validation() {
    // Add url2 validation adapter, which gets converted to
    // url2 jQuery validator method:
    // https://github.com/jquery-validation/jquery-validation/blob/master/src/additional/url2.js
    jQuery.validator.unobtrusive.adapters.addBool('url2');
}

