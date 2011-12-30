<!--XSL template to convert NLM XML documents into HTML
created by Aaron D'Sa for Cambridge Medicine Journal

-->

<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Fri Dec 30 12:00:46 GMT 2011 -->

<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
	xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
	xmlns:err="http://www.w3.org/2005/xqt-errors"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	exclude-result-prefixes="xs xdt err fn">

	<xsl:output method="xml" indent="yes"/>



<xsl:template match="/">
	<html>
	
		
		
	<body>
		
		
		<xsl:apply-templates></xsl:apply-templates>
	</body>
	</html>
</xsl:template>

<!--FRONT OF THE ARTICLE-->

<xsl:template match="/article/front">
	<div><xsl:apply-templates></xsl:apply-templates>
	</div>
 </xsl:template>

<xsl:template match="/article/front/journal-meta">
	<table>
	<tr>
	<td><strong>Journal ID:</strong></td><td><xsl:apply-templates select="journal-id"></xsl:apply-templates></td>
	</tr>
	
	<tr>
	<td><strong>Journal Name:</strong></td><td><xsl:apply-templates select="journal-title-group/journal-title"></xsl:apply-templates></td>
	</tr>
	</table>
</xsl:template>

<xsl:template match="/article/front/article-meta">
	<table>
	<tr>
	<td><h2><xsl:apply-templates select="title-group/article-title"></xsl:apply-templates></h2></td>
	</tr>
	
	<tr>
	<td><h3><xsl:apply-templates select="title-group/subtitle"></xsl:apply-templates></h3></td>
	</tr>
	</table>
</xsl:template>

<!--BODY OF THE ARTICLE-->
<xsl:template match="article/body">

		<h3>Table of Contents</h3>
		<table>
		<xsl:for-each select="sec/title">
			<tr>
			<td>
			<a><xsl:attribute name="href">#<xsl:value-of select="."></xsl:value-of></xsl:attribute><xsl:value-of select="."></xsl:value-of></a>
			</td>
			</tr>
		</xsl:for-each>
		</table>
		<xsl:apply-templates></xsl:apply-templates>
</xsl:template>

<xsl:template match="/article/body/sec">
	<div><xsl:apply-templates></xsl:apply-templates>
	</div>
 </xsl:template>

<xsl:template match="/article/body/sec/p">
	<p><xsl:apply-templates></xsl:apply-templates>
	</p>
</xsl:template>

<xsl:template match="/article/body/sec/title">
	<h2><xsl:attribute name="id"><xsl:value-of select="."></xsl:value-of></xsl:attribute><xsl:apply-templates></xsl:apply-templates>
	</h2>
</xsl:template>

<xsl:template match="//xref">
	<a><xsl:attribute name="href">#<xsl:value-of select="@rid"></xsl:value-of></xsl:attribute>
		<sup><xsl:apply-templates></xsl:apply-templates>
		</sup></a>
</xsl:template>

<xsl:template match="//fig">
	<table class="sample" >
		<tr><td><xsl:apply-templates select="label"></xsl:apply-templates>	</td>
		</tr>
		<tr><td><img><xsl:attribute name="src"><xsl:value-of select="media/@xlink:href"></xsl:value-of></xsl:attribute></img></td><td><xsl:apply-templates select="caption"></xsl:apply-templates></td>
		</tr>
	</table>
</xsl:template>

<!--REFERENCES-->

<xsl:template match="/article/back/ref-list">
	<div><xsl:apply-templates></xsl:apply-templates>
	</div>
</xsl:template>

<xsl:template match="/article/back/ref-list/title">
	<h2><xsl:apply-templates></xsl:apply-templates>
	</h2>
</xsl:template>
 
 <xsl:template match="/article/back/ref-list">
	 <h2>References
	 </h2>
	 
	 <table>
	 <xsl:for-each select="ref">
		  <tr><xsl:attribute name="id"><xsl:value-of select="@id"></xsl:value-of></xsl:attribute>
		  <td  width="10%"><xsl:apply-templates select="label"></xsl:apply-templates>
		  </td>
		  <td><xsl:apply-templates select="mixed-citation"></xsl:apply-templates>
		  </td>
		 </tr>
	 </xsl:for-each>
	 </table>
 </xsl:template>
 
</xsl:stylesheet>
