<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<Document-DespatchAdvice>
	<DespatchAdvice-Header>
		<DespatchAdviceNumber><xsl:value-of select="//Document-Header/НомерДок"/></DespatchAdviceNumber>
		<DespatchAdviceDate>
			<xsl:call-template name="DateFormat">
				<xsl:with-param name="date" select="//Document-Header/ДатаДок"/>
			</xsl:call-template>
		</DespatchAdviceDate>
		<EstimatedDeliveryDate>
			<xsl:call-template name="DateFormat">
				<xsl:with-param name="date" select="//Document-Header/ДатаПоставки"/>
			</xsl:call-template>
		</EstimatedDeliveryDate>
		<BuyerOrderNumber><xsl:value-of select="substring(//Document-Header/Основание, 1, 13)"/></BuyerOrderNumber>
		<DocumentFunctionCode>9</DocumentFunctionCode>
		<DocumentNameCode>351</DocumentNameCode>
	</DespatchAdvice-Header>
	<Document-Parties>
		<Sender>
			<ILN><xsl:value-of select="//Фирма/@ILN"/></ILN>
		</Sender>
		<Receiver>
			<ILN><xsl:value-of select="//Клиент/@GLN"/></ILN>
		</Receiver>
	</Document-Parties>
	<DespatchAdvice-Parties>
		<Buyer>
			<ILN><xsl:value-of select="//Клиент/@GLN"/></ILN>
		</Buyer>
		<Seller>
			<ILN><xsl:value-of select="//Фирма/@GLN"/></ILN>
		</Seller>
		<DeliveryPoint>
			<ILN><xsl:value-of select="//АдрДоставки/@GLN"/></ILN>
		</DeliveryPoint>
	</DespatchAdvice-Parties>

</Document-DespatchAdvice>

</xsl:template>

<xsl:template name="DateFormat">
	 <xsl:param name="date"></xsl:param>
	<xsl:text>20</xsl:text>
   <xsl:value-of select="substring( $date, 7, 2 )" />
   <xsl:text>-</xsl:text>
   <xsl:value-of select="substring( $date, 4, 2 )" />
   <xsl:text>-</xsl:text>
   <xsl:value-of select="substring( $date, 1, 2 )" />
</xsl:template>

 </xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="in_file.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
		          commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->