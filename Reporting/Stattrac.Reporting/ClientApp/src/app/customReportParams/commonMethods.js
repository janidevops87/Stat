"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CommonMethods = void 0;
var CommonMethods = /** @class */ (function () {
    function CommonMethods() {
    }
    CommonMethods.prototype.addtoParameterList = function (model) {
        var params = [];
        for (var _i = 0, _a = Object.keys(model); _i < _a.length; _i++) {
            var key = _a[_i];
            var value = model[key];
            if (value !== undefined && value !== null) {
                if (typeof value === "number") {
                    params.push(key + ',' + value);
                }
                else if (typeof value === "string" && value.length > 0) {
                    params.push(key + ',' + value);
                }
                else if (typeof value === "boolean") {
                    params.push(key + ',' + value);
                }
                else if (typeof value === "object") {
                    params.push(key + 'Time,' + value.toLocaleDateString("en-US"));
                }
            }
        }
        return params;
    };
    return CommonMethods;
}());
exports.CommonMethods = CommonMethods;
//# sourceMappingURL=commonMethods.js.map