
create table dbo.SKU (
	ID int identity,
	Code as 's' + CAST(ID as varchar),
	Name varchar(255) not null,
	constraint PK_SKU primary key (ID), 
	constraint UK_SKU_Code unique (Code)
)

create table dbo.Family (
	ID int identity,
	SurName varchar(255) not null,
	BudgetValue int not null,
	constraint PK_Family primary key (ID), 
)

create table dbo.Basket (
	ID int identity,
	ID_SKU int not null,
	ID_Family int not null,
	Quantity int not null,
	Value decimal(18,2) not null,
	PurchaseDate date not null constraint DF_Basket_PurchaseDate DEFAULT getdate(),
	DiscountValue int,
	constraint PK_Basket primary key (ID), 
	constraint CK_Basket_Quantity_Value check (Quantity >= 0 AND Value >= 0),
	constraint FK_Basket_ID_SKU_SKU_ID foreign key (ID_SKU) references SKU(ID),
	constraint FK_Basket_ID_Family_Family_ID foreign key (ID_Family) references Family(ID)
)

