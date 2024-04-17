
create function dbo.udf_GetSKUPrice(
	@ID_SKU int
)
returns decimal(18,2)
as
begin
	-- ���� ���������� ����������
	declare @Value int
	declare @Quantity int

	-- ���� ����������
	select 
		@Value = b.Value,
		@Quantity = b.Quantity
	from dbo.Basket as b
	where b.ID_SKU = @ID_SKU

	return @value / @Quantity
end

