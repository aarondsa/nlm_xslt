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

Back:
	Classes: back, references, footnotes
	References title: h3
	Footnotes title: h3

-->

<xsl:variable name="mediapath"></xsl:variable>

<!-- Section 1: Skeleton of the article-->

	<xsl:template match="/">
		<html>
			<head>
			<LINK REL="StyleSheet" href="article_css.css" TYPE="text/css" />
			</head>
			
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
<!-- Don't want journal metadata for all site, so it's commented out!-->
<div>
	<xsl:template match="/article/front/journal-meta">
		<table class="front-journal">
		<xsl:if test="journal-id">
			<tr>
			<td><strong>Journal ID:</strong></td><td><xsl:apply-templates select="journal-id[1]"></xsl:apply-templates></td>
			</tr>
		</xsl:if>
		
		<xsl:if test="journal-title-group/journal-title">
			<tr>
			<td><strong>Journal Name:</strong></td><td><xsl:apply-templates select="journal-title-group/journal-title"></xsl:apply-templates></td>
			</tr>
		</xsl:if>
		
		<xsl:if test="publisher/publisher-name">
			<tr>
			<td><strong>Publisher Name:</strong></td><td><xsl:apply-templates select="publisher/publisher-name"></xsl:apply-templates></td>
			</tr>
		</xsl:if>
		
		<xsl:if test="issn">
			<tr>
			<td><strong>ISSN:</strong></td><td><xsl:apply-templates select="issn"></xsl:apply-templates></td>
			</tr>
		</xsl:if>
		
		
		</table>
		
	</xsl:template>
</div>
<!--Display article metadata-->

	<xsl:template match="/article/front/article-meta">
		<table class="front-article">
		
		<tr>
		<td><h1 class="article-title" ><xsl:apply-templates select="title-group/article-title"></xsl:apply-templates></h1></td>
		</tr>
		
		<xsl:if test="title-group/subtitle">
		<tr>
		<td><h2 class="subtitle" ><xsl:apply-templates select="title-group/subtitle"></xsl:apply-templates></h2></td>
		</tr>
		</xsl:if>
		
		<!--For some reason I can't get this to work! it outputs the first two nodes rather than just the first one.
		<xsl:if test=".//subject">
		<tr>
		<td><h4><xsl:apply-templates select=".//subj-group[1]/subject[1]"></xsl:apply-templates></h4></td>
		</tr>
		</xsl:if>
		-->
		<xsl:for-each select="contrib-group/contrib">
		<tr>
		<td>
			<xsl:apply-templates select="name/given-names"></xsl:apply-templates>
			<xsl:text> </xsl:text>
			<xsl:apply-templates select="name/surname"></xsl:apply-templates>
			<xsl:text>, </xsl:text>
			<i><xsl:apply-templates select="role"></xsl:apply-templates></i>
		</td>
		
		</tr>
		</xsl:for-each>
		
		
		
		</table>
	</xsl:template>

<!--BODY OF THE ARTICLE-->

<!--Table of contents

The non-bootstrap code has been left in place so that the bootstrap code is easier to understand. In essence, we:

1. go to the body of the article
2. make a div
3. create a dropdown item (the first ul)
4. for each title within each section, create a sub-list item, whose name is the title, and which links to the title
--!>

<xsl:template match="article/body">
		<div>	
		<ul class="nav pills">
			<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown">Contents <b class="caret"></b> </a>
				<ul class="dropdown-menu">
				<xsl:for-each select="sec/title">
				<li><a><xsl:attribute name="href">#<xsl:value-of select="."></xsl:value-of></xsl:attribute><xsl:value-of select="."></xsl:value-of></a></li>
				</xsl:for-each>
				</ul>
			</li>
		</ul>					
		</div>
<!--
		<div class="table-of-contents">
		
		<h2 class="table-of-contents-title">Contents</h2>
		
		<table class="table-of-contents">
		
		<xsl:for-each select="sec/title">
			<tr>
			<td  width="5%"></td>
			<td>
			<a><xsl:attribute name="href">#<xsl:value-of select="."></xsl:value-of></xsl:attribute>-<xsl:value-of select="."></xsl:value-of></a>
			</td>
			</tr>
		</xsl:for-each>
		
		</table>
		<hr></hr>
		</div>
--!>

		<xsl:apply-templates></xsl:apply-templates>
</xsl:template>

<xsl:template match="/article/body/sec">
	<div class="body section"><xsl:apply-templates></xsl:apply-templates>
	</div>
 </xsl:template>

<xsl:template match="/article/body/sec/p">
	<div class="paragraph">
	<p><xsl:apply-templates></xsl:apply-templates>
	</p>
	</div>
</xsl:template>

<xsl:template match="/article/body/sec/p/bold">
	<strong>
		<xsl:apply-templates></xsl:apply-templates>
	</strong>
</xsl:template>

<xsl:template match="/article/body/sec/p/italic">
	<i>
		<xsl:apply-templates></xsl:apply-templates>
	</i>
</xsl:template>

<xsl:template match="/article/body/sec/title">
	<h3 class="subheading"><xsl:attribute name="id"><xsl:value-of select="."></xsl:value-of></xsl:attribute><xsl:apply-templates></xsl:apply-templates>
	</h3>
</xsl:template>

<xsl:template match="//xref">
	<a class="xref"><xsl:attribute name="href">#<xsl:value-of select="@rid"></xsl:value-of></xsl:attribute>	<sup><xsl:apply-templates></xsl:apply-templates></sup></a>
</xsl:template>

<xsl:template match="//fig">
	<table class="figure" >
	
		<tr>
			<td>
				<strong>
				<xsl:apply-templates select="label"></xsl:apply-templates>
				</strong>
			</td>
		</tr>
		
		<tr>
			<td>
				
				<!--This is where you set the target URL of the image. for CMJ it is http://www.cambridgemedicine.org/images/. requires some 'string expression work' -->
				<a><xsl:attribute name="href"><xsl:value-of select="media/@xlink:href"></xsl:value-of></xsl:attribute>
				<img width="100px" ><xsl:attribute name="src"><xsl:value-of select="media/@xlink:href"></xsl:value-of></xsl:attribute></img>
				</a>
				
			</td>
			<td>
				<xsl:apply-templates select="caption"></xsl:apply-templates>
			</td>
		</tr>
	
	</table>
</xsl:template>

<xsl:template match="//table-wrap">
	<hr></hr>
	<div class="table" >
	
	<strong>
		<xsl:apply-templates select="label"></xsl:apply-templates>
	</strong>
	<br>
	</br>
	
	<xsl:apply-templates select="table"></xsl:apply-templates>
	
	<br>
	</br>
	<i>
		<xsl:apply-templates select="caption"></xsl:apply-templates>
	</i>
	
	</div>
	<hr></hr>
</xsl:template>

<!--BACK OF ARTICLE-->

<xsl:template match="/article/back/ref-list">
	<div class="back" >
		<xsl:apply-templates></xsl:apply-templates>
	</div>
</xsl:template>

 <!--References group-->

<xsl:template match="/article/back/ref-list">
	 <div class="references">

	 <hr />
	 <h2 class="references" >References
	 </h2>
	 
	 <table>
	 <xsl:for-each select="ref">
		  <tr><xsl:attribute name="id"><xsl:value-of select="@id"></xsl:value-of></xsl:attribute>
		  
		  <td  style="vertical-align:top"  width="6%"><xsl:apply-templates select="label"></xsl:apply-templates>
		  </td>
		  
		  <td>
		  	<table>
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
		  	<tr>
		  	<td>
		  		<xsl:apply-templates select=".//article-title"></xsl:apply-templates><xsl:text> </xsl:text><i><xsl:apply-templates select=".//source"></xsl:apply-templates></i>
		  	</td>
		  	</tr>
		  	</table>
		  	
		  </td>

		 </tr>
	 </xsl:for-each>
	 </table>
	 </div>
 </xsl:template>
 
 <!--Footnotes group-->
 
 <xsl:template match="article/back/fn-group">
 	 <div class="footnotes">

 	 <hr />
	 <h2 class="footnotes" >Footnotes
	 </h2>
	 
		 <table>
		 	<xsl:for-each select="fn">
		 		
		 			<tr><xsl:attribute name="id"><xsl:value-of select="@id"></xsl:value-of></xsl:attribute>
		 			<td style="vertical-align:top" width="6%" >
		 				<xsl:apply-templates select="label"></xsl:apply-templates>
		 			</td>
		 			
			 		<td>
			 			<p><xsl:apply-templates select="p"></xsl:apply-templates></p>
		 			</td>
		 			</tr>
		
		 	</xsl:for-each>
		 </table>
  	 </div>
 </xsl:template>
 
</xsl:stylesheet>
