/*
** ng_move_amazon_orders
** Auth: JFM
** Desc: Stored procedure to pull amazon orders into the orders table for processing
** Usage: exec ng_move_amazon_orders
**
** Revision History
**
**	V1.0   08/15/2014 -- Created
**	V1.1   08/19/2014
**
*/
create procedure [dbo].[ng_move_amazon_orders] @showVersion int = 0
as
begin
	declare @v_throw_error varchar(2000);
	if @showVersion = 1
	begin
		select @v_throw_error = 'NG_MOVE_AMAZON_ORDERS V1.1 8/19/2014';
		THROW 60001,@v_throw_error,1
	end
	set nocount on;

	/*
	** Variables for start of <ORDER> segment and all of <CUSTOMERINFO> segment
	*/
	declare @v_orderid int;
	declare @v_amazonOrderID varchar(50);
    declare @v_number_of_amazonorderstxt int;
    
    /*
	** Fix data in the string holding table prior to moving it into the production tables.
	*/
	update amazondb.dbo.amazonorderstxt set ship_service_level = upper(replace(ship_service_level,' ',''));
	update amazondb.dbo.amazonorderstxt set ship_service_level = 'NGSPS' where ship_service_level='STANDARD'
	and ship_country = 'US';
	update amazondb.dbo.amazonorderstxt set ship_service_level = 'UPS2D' where ship_service_level='2DAY'
	and ship_country = 'US';
	update amazondb.dbo.amazonorderstxt set ship_service_level = 'UPS1S' where ship_service_level='1DAY'
	and ship_country = 'US';
	update amazondb.dbo.amazonorderstxt set ship_service_level = 'MSIIP' where ship_service_level='STANDARD'
	and ship_country = 'CA';
	update amazondb.dbo.amazonorderstxt set ship_service_level = 'UPSWS' where ship_service_level='EXPEDITED'
	and ship_country = 'CA';
	update amazondb.dbo.amazonorderstxt set ship_service_level = 'UPSWS' where 
	ship_country not in ('US','CA');

    
    select @v_number_of_amazonorderstxt = isnull(count(distinct order_id),0) from amazondb.dbo.amazonorderstxt;
	while @v_number_of_amazonorderstxt >0
	begin
		/*
		** New records -- load them into the temp orders table
		*/
		select top 1 @v_amazonOrderID = left(order_id,50) from amazondb.dbo.amazonorderstxt 
			where order_id not in 
			(select amazonOrderid from production.dbo.orders  where amazonorderid is not null)
		print @v_amazonOrderID
		insert into production.dbo.orders (amazonOrderID,OrderType,custId,orderDate,secureId,shippingType,
			shipping, tax, shippingAddressType,
		   shippingFirstName,shippingLastName,shippingAddress,shippingAddress2,shippingCity,shippingState,
			shippingZipCode,shippingCountry,shippingPhone,email,statusId,NgShipmentId,approved)
			select top 1 order_id, 'amazonfbttb', order_id as custid, cast(left(purchase_date,10) as date),
				order_id as secureId, ship_service_level, cast(shipping_price as money), 0.00,'Residential',' ',
				left(recipient_name, 100), left(ship_address_1,100), left(ship_address_2,100),
				left(ship_city,100), left(ship_state,50), left(ship_postal_code,50),left(ship_country,50),
				left(ship_phone_number,50), left(buyer_email,100), 1, 20, 0
				from amazondb.dbo.amazonorderstxt where order_id = @v_amazonOrderID
		set @v_number_of_amazonorderstxt = @v_number_of_amazonorderstxt - 1
	end

	
	/*
	** Orders in place, add orderitems
	*/
	select o.id as orderid, a.sku, cast('' as varchar(100)) as productnumber,
	a.quantity_purchased as quantity, 
	a.product_name as productdescription, 
	a.item_price as price, o.secureid, 0 as term,0 as periodid
	into #tmp_amazonorderitems
	from production.dbo.orders o join amazondb.dbo.amazonORDERSTXT a
	on o.amazonorderid = a.order_id
	and o.id not in (select orderid from production.dbo.orderitems);
	/*
	** Replace Product Numbers
	*/
	update o
	set productnumber = pv.sku
	from #tmp_amazonorderitems o left join 
	production.dbo.productvariant pv on o.sku = pv.amazonsku;
	
	insert into production.dbo.orderitems
	(orderid, productnumber, quantity, productDescription,
	price, secureId, term, periodid)
	select orderid, isnull(productnumber,'AMAZONUNKNOWN'), quantity, productDescription,
	price, secureId, term, periodid
	from #tmp_amazonorderitems	
end
