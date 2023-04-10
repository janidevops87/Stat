function TrackCount(fieldObj,maxChars,fieldID)
{
  var diff = maxChars - fieldObj.value.length;

  // Need to check & enforce limit here also in case user pastes data
  if (diff < 0)
  {
    fieldObj.value = fieldObj.value.substring(0,maxChars);
    diff = maxChars - fieldObj.value.length;
  }

  if( fieldID != null )
  {
    var element = document.getElementById(fieldID)
    if( element != null )
    {
        element.innerHTML=diff;
    }
  }

}
