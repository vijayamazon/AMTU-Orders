/*
** amazonORDERSTXT.sql
**
** Script to create a SQL Server db table to hold amazon TXT order file data
*/
USE [amazonDB]
GO

/****** Object:  Table [dbo].[amazonORDERSTXT]    Script Date: 8/30/2014 11:03:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[amazonORDERSTXT](
	[order_id] [varchar](50) NULL,
	[order_item_id] [varchar](150) NULL,
	[purchase_date] [varchar](25) NULL,
	[payments_date] [varchar](50) NULL,
	[buyer_email] [varchar](150) NULL,
	[buyer_name] [varchar](150) NULL,
	[buyer_phone_number] [varchar](20) NULL,
	[sku] [varchar](512) NULL,
	[product_name] [varchar](100) NULL,
	[quantity_purchased] [varchar](5) NULL,
	[currency] [varchar](10) NULL,
	[item_price] [varchar](10) NULL,
	[item_tax] [varchar](10) NULL,
	[shipping_price] [varchar](10) NULL,
	[shipping_tax] [varchar](10) NULL,
	[ship_service_level] [varchar](25) NULL,
	[recipient_name] [varchar](200) NULL,
	[ship_address_1] [varchar](100) NULL,
	[ship_address_2] [varchar](100) NULL,
	[ship_address_3] [varchar](100) NULL,
	[ship_city] [varchar](100) NULL,
	[ship_state] [varchar](100) NULL,
	[ship_postal_code] [varchar](100) NULL,
	[ship_country] [varchar](10) NULL,
	[ship_phone_number] [varchar](25) NULL,
	[tax_location_code] [varchar](10) NULL,
	[tax_location_city] [varchar](10) NULL,
	[tax_location_county] [varchar](10) NULL,
	[tax_location_state] [varchar](10) NULL,
	[per_unit_item_taxable_district] [varchar](10) NULL,
	[per_unit_item_taxable_city] [varchar](10) NULL,
	[per_unit_item_taxable_county] [varchar](10) NULL,
	[per_unit_item_taxable_state] [varchar](10) NULL,
	[per_unit_item_non_taxable_district] [varchar](10) NULL,
	[per_unit_item_non_taxable_city] [varchar](10) NULL,
	[per_unit_item_non_taxable_county] [varchar](10) NULL,
	[per_unit_item_non_taxable_state] [varchar](10) NULL,
	[per_unit_item_zero_rated_district] [varchar](10) NULL,
	[per_unit_item_zero_rated_city] [varchar](10) NULL,
	[per_unit_item_zero_rated_county] [varchar](10) NULL,
	[per_unit_item_zero_rated_state] [varchar](10) NULL,
	[per_unit_item_tax_collected_district] [varchar](10) NULL,
	[per_unit_item_tax_collected_city] [varchar](10) NULL,
	[per_unit_item_tax_collected_county] [varchar](10) NULL,
	[per_unit_item_tax_collected_state] [varchar](10) NULL,
	[per_unit_shipping_taxable_district] [varchar](10) NULL,
	[per_unit_shipping_taxable_city] [varchar](10) NULL,
	[per_unit_shipping_taxable_county] [varchar](10) NULL,
	[per_unit_shipping_taxable_state] [varchar](10) NULL,
	[per_unit_shipping_non_taxable_district] [varchar](10) NULL,
	[per_unit_shipping_non_taxable_city] [varchar](10) NULL,
	[per_unit_shipping_non_taxable_county] [varchar](10) NULL,
	[per_unit_shipping_non_taxable_state] [varchar](10) NULL,
	[per_unit_shipping_zero_rated_district] [varchar](10) NULL,
	[per_unit_shipping_zero_rated_city] [varchar](10) NULL,
	[per_unit_shipping_zero_rated_county] [varchar](10) NULL,
	[per_unit_shipping_zero_rated_state] [varchar](10) NULL,
	[per_unit_shipping_tax_collected_district] [varchar](10) NULL,
	[per_unit_shipping_tax_collected_city] [varchar](10) NULL,
	[per_unit_shipping_tax_collected_county] [varchar](10) NULL,
	[per_unit_shipping_tax_collected_state] [varchar](10) NULL,
	[item_promotion_discount] [varchar](10) NULL,
	[item_promotion_id] [varchar](10) NULL,
	[ship_promotion_discount] [varchar](10) NULL,
	[ship_promotion_id] [varchar](10) NULL,
	[delivery_start_date] [varchar](10) NULL,
	[delivery_end_date] [varchar](10) NULL,
	[delivery_time_zone] [varchar](10) NULL,
	[delivery_Instructions] [varchar](10) NULL,
	[sales_channel] [varchar](10) NULL
)

GO

SET ANSI_PADDING OFF
GO


