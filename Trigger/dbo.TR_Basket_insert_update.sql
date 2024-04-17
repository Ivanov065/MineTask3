
create trigger dbo.TR_Basket_insert_update on dbo.Basket
after insert 
as
begin
	update b
	set b.DiscountValue = b.Value * 0.05
	from inserted as i,
		dbo.Basket as b
	where i.ID = b.ID
		and b.ID_SKU in (
			select i_repeat.ID_SKU
			from inserted as i_repeat
			group by i_repeat.ID_SKU
			having count(i_repeat.ID) >= 2
		)

	update b
	set b.DiscountValue = 0
	from inserted as i,
		dbo.Basket as b
	where i.ID = b.ID
		and b.ID_SKU not in (
			select i_repeat.ID_SKU
			from inserted as i_repeat
			group by i_repeat.ID_SKU
			having count(i_repeat.ID) >= 2
		)
end

