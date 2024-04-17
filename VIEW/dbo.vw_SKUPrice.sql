
create view dbo.vw_SKUPrice 
as
	select 
		s.ID as 'Идентификатор',
		s.Code as 'Код продукта',
		s.Name as 'Название продукта',
		dbo.udf_GetSKUPrice(s.ID) as 'Стоимость единицы продукта'
	from dbo.SKU as s

