	function toggleInputElementsDisabledStatus(id)
	{
		// client-side script that toggles 
		// input control's disabled status
		var elem = document.getElementById(id);
		if (elem != null)
		{
			// toggle the disabled status
			elem.disabled = !elem.disabled;
			if(elem.disabled == true)
			{
				//assume disabled 
				elem.style.backgroundColor = '#CCCCCC';
			}
			else
			{
				elem.style.backgroundColor = 'white';
			}	
			

		}
		
	}
	
	function openPage(pageName)
{//alert(pageName);
    var servername = document.location.host;
    var protocol = document.location.protocol;
    var newPage = protocol + "//" + servername + pageName;
    var newPageName = "";
	window.open(newPage, newPageName,'' );
}	