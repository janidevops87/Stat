This folder contains type converters for non-view-model types (e.g. domain model types).
For primitive domain types like PhoneNumber it's acceptable to be included in view models
as-is, reducing the number of view models mimicking domain types and their validation logic. 
Type converters can be used to parse/format domain types from request data. I'm placing the 
type converters here to reduce pollution of domain model with types which are not really 
needed for domain model itself. 

NOTE: For now this approach can't be used as it turns out ASP.NET Core still doesn't
support decorating properties with type converters 
(see https://github.com/dotnet/aspnetcore/issues/8857). So the only way to use
a type converter is to attach it to a class being converted, and it's what we want to
avoid. Leaving this file here for future.

Note that JsonConverters is a different story, they work fine. Actually,
for JSON payloads in post request TypeConverter is not supported by System.Text.Json
serializer, so custom JsonConverter is the way to solve this.