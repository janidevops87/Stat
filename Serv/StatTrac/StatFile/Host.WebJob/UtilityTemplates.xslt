<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name ="RoundDecimal">
    <xsl:param name="fieldValue"/>
    <xsl:if test="string-length($fieldValue) &gt; 0">
      <xsl:value-of select="round($fieldValue)" />
    </xsl:if>
  </xsl:template>
  <xsl:template name ="SetFieldLength">
    <xsl:param name="fieldValue"/>
    <xsl:param name="fieldLength"/>
    <xsl:if test="string-length($fieldValue) &gt; 0">
      <xsl:value-of select="substring($fieldValue, 1, $fieldLength)" />
    </xsl:if>
  </xsl:template>
  <xsl:template name="FormatDateTime">

    <xsl:param name="DateTime" />

    <!-- new date format 2006-01-14T08:55:22 -->
    <xsl:if test="string-length($DateTime) &gt; 0">
      <xsl:variable name="month-temp">
        <xsl:value-of select="substring-after($DateTime,'-')" />
      </xsl:variable>
      <xsl:variable name="mo">

        <xsl:value-of select="substring-before($month-temp,'-')" />

      </xsl:variable>

      <xsl:variable name="day-temp">

        <xsl:value-of select="substring-after($month-temp,'-')" />

      </xsl:variable>

      <xsl:variable name="day">

        <xsl:value-of select="substring($day-temp, 1, 2)" />

      </xsl:variable>

      <xsl:variable name="year">

        <xsl:value-of select="substring($DateTime, 3, 2)" />

      </xsl:variable>

      <xsl:variable name="time">

        <xsl:value-of select="substring-after($day-temp,' ')" />

      </xsl:variable>

      <xsl:variable name="hh">

        <xsl:value-of select="substring($time,1,2)" />

      </xsl:variable>

      <xsl:variable name="mm">

        <xsl:value-of select="substring($time,4,2)" />

      </xsl:variable>

      <xsl:variable name="ss">

        <xsl:value-of select="substring($time,7,2)" />

      </xsl:variable>

      <xsl:value-of select="$mo"/>

      <xsl:value-of select="'/'"/>
      <xsl:value-of select="$day"/>
      <xsl:value-of select="'/'"/>
      <xsl:value-of select="$year"/>
      <xsl:value-of select="' '"/>
      <xsl:value-of select="$hh"/>
      <xsl:value-of select="':'"/>
      <xsl:value-of select="$mm"/>
      <xsl:value-of select="':'"/>
      <xsl:value-of select="$ss"/>
    </xsl:if>
  </xsl:template>
  <xsl:template name="FormatDate">

    <xsl:param name="DateTime" />

    <!-- new date format 2006-01-14T08:55:22 -->
    <xsl:if test="string-length($DateTime) &gt; 0">
      <xsl:variable name="month-temp">
        <xsl:value-of select="substring-after($DateTime,'-')" />
      </xsl:variable>
      <xsl:variable name="mo">

        <xsl:value-of select="substring-before($month-temp,'-')" />

      </xsl:variable>

      <xsl:variable name="day-temp">

        <xsl:value-of select="substring-after($month-temp,'-')" />

      </xsl:variable>

      <xsl:variable name="day">

        <xsl:value-of select="substring($day-temp, 1, 2)" />

      </xsl:variable>

      <xsl:variable name="year">

        <xsl:value-of select="substring($DateTime, 3, 2)" />

      </xsl:variable>

      <xsl:value-of select="$mo"/>
      <xsl:value-of select="'/'"/>
      <xsl:value-of select="$day"/>
      <xsl:value-of select="'/'"/>
      <xsl:value-of select="$year"/>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>