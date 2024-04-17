/*
	Конечно уже поздно у вас спрашивать до сдачи этого задания, но
	почему в данной процедуре в качестве входного параметра выступает 
	фамилия семьи? Ведь фамилия не может точно идентифицировать конкретную семью. 
	Создавая таблицу Family я не видел в техническом задании указания на уникальность поля
	SurName, а значит у нас может быть две семьи Ивановых, например, что может создать ошибку
	при вычислении, поскольку инструкции внутри процедуры могут достать не ту семью. 
	Если в вашем представлении SurName содержит в себе больше информации, чем "Иванов", то
	можете просто игнорировать этот вопрос. Я выполнял это задание с представлением, что 
	dbo.Family.SurName в теоретической базе данных и в теоретических бизнес процессах уникально,
	и по нему я смогу найти уникальное значение dbo.Family.ID, которое нужно для
	извлечения информации из dbo.Basket
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
			set @ErrorMessage = 'Ошибка при оформлении. Проверьте корректность данных'
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