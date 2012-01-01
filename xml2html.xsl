<?xml version="1.0" encoding="UTF-8" ?>
<!--XSL template to convert NLM XML documents into HTML
created by Aaron D'Sa for the Cambridge Medicine Journal
-->
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

<!--Styling
Front:
	Classes: front, front-journal, front-article
	Journal Metadata: strong
	Article Title: h2
	Article Subtitle: h3
	
Body: 
	Classes: body, table-of-contents, section, subheading, xref, figure
	Table of contents title: h3
	Subheading: h3

-->


<!-- Section 1: Skeleton of the article-->

	<xsl:template match="/">
		<html>
			<body>
			<xsl:apply-templates></xsl:apply-templates>
			</body>
		</html>
	</xsl:template>

<!--FRONT-->

<!--Put the front in a <div> class: front-->

	<xsl:template match="/article/front">
		<div class="front"><xsl:apply-templates></xsl:apply-templates>
		</div>
	 </xsl:template>

<!--Display journal metadata-->

	<xsl:template match="/article/front/journal-meta">
		<table class="front front-journal">
		<tr>
		<td><strong>Journal ID:</strong></td><td><xsl:apply-templates select="journal-id"></xsl:apply-templates></td>
		</tr>
		
		<tr>
		<td><strong>Journal Name:</strong></td><td><xsl:apply-templates select="journal-title-group/journal-title"></xsl:apply-templates></td>
		</tr>
		</table>
	</xsl:template>

<!--Display article metadata-->

	<xsl:template match="/article/front/article-meta">
		<table class="front front-article">
		<tr>
		<td><h2><xsl:apply-templates select="title-group/article-title"></xsl:apply-templates></h2></td>
		</tr>
		
		<tr>
		<td><h3><xsl:apply-templates select="title-group/subtitle"></xsl:apply-templates></h3></td>
		</tr>
		</table>
	</xsl:template>

<!--BODY OF THE ARTICLE-->

<!--Table of contents-->

<xsl:template match="article/body">
		<div class="body table-of-contents">
		<h3>Table of Contents</h3>
		<table class="body table-of-contents">
		<xsl:for-each select="sec/title">
			<tr>
			<td>
			<a><xsl:attribute name="href">#<xsl:value-of select="."></xsl:value-of></xsl:attribute><xsl:value-of select="."></xsl:value-of></a>
			</td>
			</tr>
		</xsl:for-each>
		</table>
		</div>
		<xsl:apply-templates></xsl:apply-templates>
</xsl:template>

<xsl:template match="/article/body/sec">
	<div class="body section"><xsl:apply-templates></xsl:apply-templates>
	</div>
 </xsl:template>

<xsl:template match="/article/body/sec/p">
	<p><xsl:apply-templates></xsl:apply-templates>
	</p>
</xsl:template>

<xsl:template match="/article/body/sec/title">
	<h3 class="body subheading"><xsl:attribute name="id"><xsl:value-of select="."></xsl:value-of></xsl:attribute><xsl:apply-templates></xsl:apply-templates>
	</h3>
</xsl:template>

<xsl:template match="//xref">
	<a class="body xref"><xsl:attribute name="href">#<xsl:value-of select="@rid"></xsl:value-of></xsl:attribute>
		<sup><xsl:apply-templates></xsl:apply-templates>
		</sup></a>
</xsl:template>

<xsl:template match="//fig">
	<table class="figure" >
		<tr><td><xsl:apply-templates select="label"></xsl:apply-templates>	</td>
		</tr>
		<tr><td><img><xsl:attribute name="src"><xsl:value-of select="media/@xlink:href"></xsl:value-of></xsl:attribute></img></td><td><xsl:apply-templates select="caption"></xsl:apply-templates></td>
		</tr>
	</table>
</xsl:template>

<!--REFERENCES-->

<xsl:template match="/article/back/ref-list">
	<div class="references" >
	<xsl:apply-templates></xsl:apply-templates>
	</div>
</xsl:template>

<xsl:template match="/article/back/ref-list">
	 <hr />
	 <h3>References
	 </h3>
	 
	 <table>
	 <xsl:for-each select="ref">
		  <tr><xsl:attribute name="id"><xsl:value-of select="@id"></xsl:value-of></xsl:attribute>
		  
		  <td  width="6%"><xsl:apply-templates select="label"></xsl:apply-templates>
		  </td>
		  
		  <td>
		  	<tr>
		  	<td>
			  	<xsl:for-each select=".//name">
			  		<xsl:apply-templates select="given-names"></xsl:apply-templates><xsl:text> </xsl:text><xsl:apply-templates select="surname"></xsl:apply-templates>, 
			  	</xsl:for-each>
		  	</td>
		  	</tr>
		  	<tr>
		  	<td>
		  		<xsl:apply-templates select="mixed-citation"></xsl:apply-templates>	
		  	</td>
		  	</tr>

		  	
		  </td>

		 </tr>
	 </xsl:for-each>
	 </table>
 </xsl:template>
 
</xsl:stylesheet>
