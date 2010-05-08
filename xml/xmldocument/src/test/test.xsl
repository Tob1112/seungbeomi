<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:variable name="vSince">
        <font color="blue">1979</font>	
	</xsl:variable>
	
	<xsl:template match="/">
		<html>
		  <body>
		      <h2><font color="blue">our book's list</font></h2>
		      <table border="1" cellspacing="0" width="80%">
		          <tr bgcolor="#ffff66">
		              <th>no</th>
		              <th>title</th>
		              <th>kind</th>
		              <th>author</th>
		              <th>publisher</th>
		              <th>price</th>
		          </tr>
		          <!--<xsl:apply-templates select="/booklist/book[@kind='computer']"/>-->
		          <!--<xsl:apply-templates select="/booklist/book"/>-->
		          <xsl:apply-templates select="/booklist/book">
		              <xsl:sort select="@kind"/>
		              <xsl:sort select="price" data-type="number" order="descending"/>
		          </xsl:apply-templates>
		      </table>
		      <br />
		      <hr align="left" width="80%"/>
		      <xsl:call-template name="tCompany"/>
		  </body>
		</html>
	</xsl:template>
	<xsl:template match="book">
	   <tr>
	       <td align="center"><xsl:number format="1"/></td>
	       <td><xsl:value-of select="title"/></td>
	       <td><xsl:value-of select="@kind"/></td>
	       <td><xsl:value-of select="author"/></td>
	       <td><xsl:value-of select="publisher"/></td>
	       <td><xsl:value-of select="format-number(price,'###,###')"/></td>
	   </tr>
	</xsl:template>
	<xsl:template name="tCompany">
	   <font color="blue">seungbeomi software</font>company
	   <xsl:value-of select="$vSince"/>
	</xsl:template>
	
</xsl:stylesheet>