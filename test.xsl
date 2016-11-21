<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" encoding="utf-8"/>
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
			<ILN><xsl:value-of select="//Фирма/@ILN"/></ILN>
		</Seller>
		<DeliveryPoint>
			<ILN><xsl:value-of select="//АдрДоставки/@GLN"/></ILN>
		</DeliveryPoint>
	</DespatchAdvice-Parties>
	<DespatchAdvice-Consignment>
		<Packing-Sequence>
			<xsl:for-each select="//Line-Item">
				<Line>
					<Line-Item>
						<xsl:value-of select="position()"/>
					</Line-Item>
					<SupplierItemCode>
						<xsl:value-of select="./Товар/@Код"/>
					</SupplierItemCode>
					<ItemDescription>
						<xsl:value-of select="substring(./Товар/@Наименование, 9)"/>
					</ItemDescription>
					<QuantityDespatched>
						<xsl:value-of select="./Количество"/>
					</QuantityDespatched>
					<UnitOfMeasure>
						<xsl:call-template name="QuantityFormat">
							<xsl:with-param name="quantity" select="./Единица"/>
						</xsl:call-template>
					</UnitOfMeasure>
					<UnitNetPrice><xsl:value-of select="format-number(./Цена, '.00')"/></UnitNetPrice>
					<xsl:variable name="priceVAT">
     					<xsl:value-of select="./Цена * (1 + ./СтавкаНДС*0.01)"/>
					</xsl:variable>
					<UnitGrossPrice><xsl:value-of select="format-number($priceVAT, '.00')"/></UnitGrossPrice>
					<TaxRate><xsl:value-of select="./СтавкаНДС"/></TaxRate>
					<xsl:variable name="sum">
     					<xsl:value-of select="./Цена * ./Количество"/>
					</xsl:variable>
					<NetAmount><xsl:value-of select="format-number($sum, '.00')"/></NetAmount>
					<xsl:variable name="sumVAT">
     					<xsl:value-of select="$priceVAT * ./Количество"/>
					</xsl:variable>
					<TaxAmount><xsl:value-of select="format-number($sumVAT - $sum, '.00')"/></TaxAmount>
					<GrossAmount><xsl:value-of select="format-number($sumVAT, '.00')"/></GrossAmount>

				</Line>
			</xsl:for-each> 


		</Packing-Sequence>
	</DespatchAdvice-Consignment>
	<DespatchAdvice-Summary>
		<TotalPSequence>1</TotalPSequence>
		<TotalLines><xsl:value-of select="count(//НомерСтроки)"/></TotalLines>
	</DespatchAdvice-Summary>
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

<xsl:template name="QuantityFormat">
	<xsl:param name="quantity"></xsl:param>
	<xsl:choose>
		<xsl:when test="$quantity = 'шт.'">
			<xsl:text>PCE</xsl:text>
		</xsl:when>
		<xsl:when test="$quantity = 'кг.'">
			<xsl:text>KGM</xsl:text>
		</xsl:when>
	</xsl:choose>
		
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