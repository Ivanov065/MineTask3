
create view dbo.vw_SKUPrice 
as
	select 
		s.ID as '�������������',
		s.Code as '��� ��������',
		s.Name as '�������� ��������',
		dbo.udf_GetSKUPrice(s.ID) as '��������� ������� ��������'
	from dbo.SKU as s

