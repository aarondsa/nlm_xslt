# NLM XSLT

XSL template for converting NLM XML documents to HTML

Created by Aaron D'Sa for the Cambridge Medicine Journal (http://www.cambridgemedicine.org)

The project page is http://aarondsa.github.com/nlm_xslt/ and the latest html output of the template can be found here.

The repository contains the .xsl template, the example article used to test the template, and the html output. The example article is fully validated XML created by annotum. The .xsl and .xml documents were created in EditiX, which was also used to apply the template to the source document.

# STRUCTURE OF TEMPLATE

The template follows the structure of the NLM XML document

* Section 1: Declarations and Includes
* Section 2: Outline of html document
* Section 3: Front (including article metadata and journal metadata)
* Section 4: Body (including table of contents and article)
* Section 5: Back (including references)