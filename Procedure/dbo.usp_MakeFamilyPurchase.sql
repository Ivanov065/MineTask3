/*
	������� ��� ������ � ��� ���������� �� ����� ����� �������, ��
	������ � ������ ��������� � �������� �������� ��������� ��������� 
	������� �����? ���� ������� �� ����� ����� ���������������� ���������� �����. 
	�������� ������� Family � �� ����� � ����������� ������� �������� �� ������������ ����
	SurName, � ������ � ��� ����� ���� ��� ����� ��������, ��������, ��� ����� ������� ������
	��� ����������, ��������� ���������� ������ ��������� ����� ������� �� �� �����. 
	���� � ����� ������������� SurName �������� � ���� ������ ����������, ��� "������", ��
	������ ������ ������������ ���� ������. � �������� ��� ������� � ��������������, ��� 
	dbo.Family.SurName � ������������� ���� ������ � � ������������� ������ ��������� ���������,
	� �� ���� � ����� ����� ���������� �������� dbo.Family.ID, ������� ����� ���
	���������� ���������� �� dbo.Basket
*/


create procedure dbo.usp_MakeFamilyPurchase (
	@FamilySurName varchar(255)
)
as
begin
	declare @ErrorMessage varchar(255)
	declare @FamilyId int

	if not exists (
		select 1
		from dbo.Family as f
		where f.SurName = @FamilySurName
	)
		begin
			set @ErrorMessage = '������ ��� ����������. ��������� ������������ ������'
			raiserror(@ErrorMessage, 3, 1)
			return
		end

	select @FamilyId = f.ID
	from dbo.Family as f
	where f.SurName = @FamilySurName

	update Family
	set BudgetValue = BudgetValue - (
		select sum(b.Value)
		from dbo.Basket as b
		where b.ID_Family = @FamilyId
	)
	where SurName = @FamilySurName
end