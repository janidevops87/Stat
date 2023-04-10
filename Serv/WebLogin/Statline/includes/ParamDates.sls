<%

Function buildDropDownOptionYearList(startYear)
	dim forLoop	
	for forLoop = startYear to DatePart("yyyy", Now()) + 2		
		%>
		<option value="<%=forLoop%>" <%If DatePart("yyyy", Now()) = forLoop Then%>selected<%End If%>><%=forLoop%></option>
		<%
	
	Next

End Function


%>
