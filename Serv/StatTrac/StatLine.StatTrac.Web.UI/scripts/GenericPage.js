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


	function webGridReportList_RowSelectionChanged(sender, eventArgs)
	{
           var pageName = "/Statline.StatTrac.Web.UI/ReportParams.aspx";
           pageName = pageName + '?report=' + eventArgs.getSelectedRows().getItem(0).get_cell(0).get_value();           
           redirectPage(pageName);           
        
	}
function redirectPage(pageName)
{
    var servername = document.location.host;
    var protocol = document.location.protocol;
    var newPage = protocol + "//" + servername + pageName;
    var newPageName = window.name;   
	window.location = newPage;

}
function openPage(pageName)
{
    var servername = document.location.host;
    var protocol = document.location.protocol;
    var newPage = protocol + "//" + servername + pageName;
    var newPageName = "";        
    window.open(newPage, newPageName,'' );
}	