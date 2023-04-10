<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8"/>
<xsl:template match="/">
  <html>
    <head>
      <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    </head>
    <body>
      <div style="width: 600; text-align:center; font-family:Arial; font-size:10pt;">
        <p>
          <b>
            Con el fin de completar su registración, es. necesario que su identificación sea verificada.
            Por favor conteste las siguientes preguntas para verificar su identidad.
          </b>
        </p>
        <form action="ValidateDynamic.aspx" method="GET" name="idQuestions">
          <xsl:for-each select="response">
            <INPUT type="hidden" name="idNumber">
              <xsl:attribute name="value">
                <xsl:value-of select="id-number"/>
              </xsl:attribute>
            </INPUT>
          <xsl:for-each select="questions/question">
            <xsl:value-of select="prompt"/>
            <div Style="text-align:right; width: 500;">
              <INPUT type="hidden" name="Type" >
                <xsl:attribute name="value">
                  <xsl:value-of select="type"/>
                </xsl:attribute>
              </INPUT>
              <SELECT  name="Answer">
                <OPTION selected=""></OPTION>
                <xsl:for-each select="answer">
                  <OPTION >
                    <xsl:attribute name="value">
                      <xsl:value-of select="."/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                  </OPTION>
                </xsl:for-each>
              </SELECT>
            </div>
          </xsl:for-each>
          </xsl:for-each>
          <p></p>
          <div style="text-align: center;">
            <INPUT type="submit" value="Continue"></INPUT>
          </div>
        </form>
      </div>
    </body>
  </html>
</xsl:template>
</xsl:stylesheet>