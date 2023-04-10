
<!-- #include virtual="/loginstatline/includes/Authorize.sls"-->
<%
'WAREHOUSEDSN = "ProductionDataWarehouse"
'DBUSER = "sa"
'DPPWD = "kuvasz"



Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
Response.Write "<br>WAREHOUSEDSN: " & WAREHOUSEDSN

DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD

SET RS = DataWarehouseConn.Execute("SELECT TOP 2 * FROM referral_typecount")
DO WHILE NOT RS.EOF 
	Response.Write "<br>" & RS(0) & " - " & RS(1) & "<br>"
	RS.MoveNext
Loop


SET DataWarehouseConn = Nothing

%>



