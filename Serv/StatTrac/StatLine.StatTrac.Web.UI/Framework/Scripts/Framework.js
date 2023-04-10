var masterForm;
var masterDocument
if (window.navigator.appName.toLowerCase().indexOf("netscape") > -1)
{
	masterForm = document.forms["masterForm"];
	masterDocument = document.all;
}
else
{
	masterForm = document.masterForm;
	masterDocument = document.layers;
}
var ns4 = (document.layers);
var ie4 = (document.all && !document.getElementById);
var ie5 = (document.all && document.getElementById);
var ns6 = (!document.all && document.getElementById);

function getObjectById( id )
{
	// Netscape 4
	if( ns4 )
	{
		return document.layers[id];
	}
	// Explorer 4
	else if( ie4 )
	{
		return document.all[id];
	}
	// W3C - Explorer 5+ and Netscape 6+
	else if( ie5 || ns6 )
	{
		return document.getElementById(id);
	}
}


function isVisible( id )
{
	var o;
	// Netscape 4
	if( ns4 )
	{
		o = document.layers[id].style.display == "";
	}
	// Explorer 4
	else if( ie4 )
	{
		o = document.all[id].style.display == "";
	}
	// W3C - Explorer 5+ and Netscape 6+
	else if( ie5 || ns6 )
	{
		o = document.getElementById(id).style.display == "";
	}
	return o;
}

function show( id )
{
	// Netscape 4
	if( ns4 )
	{
		document.layers[id].style.display = "";
	}
	// Explorer 4
	else if( ie4 )
	{
		document.all[id].style.display = "";
	}
	// W3C - Explorer 5+ and Netscape 6+
	else if( ie5 || ns6 )
	{
		document.getElementById(id).style.display = "";
		//document.getElementById(id).disabled = false;
	}
}

function hide( id )
{
	// Netscape 4
	if( ns4 )
	{
		document.layers[id].style.display = "none";
	}
	// Explorer 4
	else if( ie4 )
	{
		document.all[id].style.display = "none";
	}
	// W3C - Explorer 5+ and Netscape 6+
	else if( ie5 || ns6 )
	{
		document.getElementById(id).style.display = "none";
		//document.getElementById(id).disabled = true;
	}
}

function areAnyRulesVisible( ruleIds )
{
	var ruleIdsArray = ruleIds.split(",");
	var anyShowing = false;
	for (i = 0; i < ruleIdsArray.length; i++)
	{
		//alert( 'ruleToggleRow' + ruleIdsArray[i] );
		if( isVisible( 'ruleToggleRow' + ruleIdsArray[i] ) )
		{
			anyShowing = true;
		}
	}
	return anyShowing;
}

function toggleRuleRow( checkBox, ruleId, ruleIds )
{
	var id = 'ruleToggleRow' + ruleId;
	
	//alert( id );
	//alert( ruleIds );
	
	if( checkBox.checked )	
		show( id );
	else
		hide( id );

	var anyShowing = areAnyRulesVisible( ruleIds );
	if( anyShowing )
	{
		hide( 'noneShowingText' );	
	}
	else
	{
		show( 'noneShowingText' );	
	}

}