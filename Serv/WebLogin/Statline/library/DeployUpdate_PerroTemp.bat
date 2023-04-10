attrib -R \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\FrmLogEventList.aspx
attrib -R \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\wfLogEvent.aspx
attrib -R \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\msg.aspx
attrib -R \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\logevent.htm
attrib -R \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\err_default.htm
attrib -R \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\bin\FrmLogEvent.dll

copy FrmLogEventList.aspx \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent
copy wfLogEvent.aspx \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent
copy msg.aspx \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent
copy logevent.htm \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent
copy err_default.htm \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent
copy bin\FrmLogEvent.dll \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\bin

attrib +R \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\FrmLogEventList.aspx
attrib +R \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\wfLogEvent.aspx
attrib +R \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\msg.aspx
attrib +R \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\logevent.htm
attrib +R \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\err_default.htm
attrib +R \\perro\c$\WLE_TestSite\Statline\forms\FrmLogEvent\bin\FrmLogEvent.dll

pause...