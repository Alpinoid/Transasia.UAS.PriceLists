SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[v_FOOD_PriceList]','V') IS NOT NULL
	DROP VIEW [dbo].[v_FOOD_PriceList]
GO

CREATE VIEW [dbo].[v_FOOD_PriceList]
AS

	WITH PriceAll AS
	(
	SELECT
		CAST(Price._Период AS date) AS Date																		-- Дата цены
		,Price.Номенклатура AS GoodID																			-- ID товара
		,PriceType.Наименование AS PriceType																	-- ID типа цены
		,Price.Цена AS Price																					-- Цена
	FROM dbo.РегистрСведений_ЦеныНоменклатуры AS Price													-- РегистрСведений.ЦеныНоменклатуры
	INNER JOIN dbo.Справочник_ТипыЦенНоменклатуры AS PriceType ON PriceType.Ссылка = Price.ТипЦены		-- .Справочник_ТипыЦенНоменклатуры
																AND PriceType.НаправлениеБизнеса = 0x829508606E88610311E4843B1F21A0A6
	)
	,PriceCalculation AS
	(
	SELECT
		GoodID AS GoodID
		,PriceType AS PriceType
		,FIRST_VALUE(Price) OVER (PARTITION BY GoodID, PriceType ORDER BY Date DESC) AS Price
	FROM PriceAll
	WHERE Date <= GETDATE()
	)
	,Price AS
	(
	SELECT
		Номенклатура.Ссылка AS GoodID
		,Номенклатура.Родитель AS ParentID
		,Номенклатура.Артикул AS GoodArticle
		,Штуки.EAN AS EAN
		,Номенклатура.Наименование AS GoodDescription
		,MAX(Коробки.Коэффициент) AS UnitsInBox
		,PriceType AS PriceType
		,Price AS Price
	FROM PriceCalculation
	LEFT JOIN dbo.Справочник_Номенклатура AS Номенклатура ON Номенклатура.Ссылка = GoodID AND Номенклатура.ПометкаУдаления = 0x00
	LEFT JOIN dbo.Справочник_ЕдиницыИзмерения AS Коробки ON Коробки.Владелец = Номенклатура.Ссылка AND Коробки.Наименование LIKE '%кор%'
	LEFT JOIN dbo.Справочник_ЕдиницыИзмерения AS Штуки ON Штуки.Ссылка = Номенклатура.БазоваяЕдиницаИзмерения
	GROUP BY Номенклатура.Ссылка, Номенклатура.Родитель, Номенклатура.Артикул, Штуки.EAN, Номенклатура.Наименование, PriceType, Price
	)
	SELECT
		Hierarchy.Level1	AS 'Уровень иерархии 1'
		,Hierarchy.Level2	AS 'Уровень иерархии 2'
		,Hierarchy.Level3	AS 'Уровень иерархии 3'
		,Hierarchy.Level4	AS 'Уровень иерархии 4'
		,GoodArticle		AS 'Артикул'
		,EAN				AS 'Штрих-код'
		,GoodDescription	AS 'Наименование'
		,UnitsInBox			AS 'Штук в коробке'
		,PriceType			AS 'Тип цены'
		,Price				AS 'Цена'
		,IIF(Остатки.Количество < 0, 0, Остатки.Количество) AS 'Остатки на складе'
	FROM Price
	LEFT JOIN olap.v_GoodsHierarchy AS Hierarchy ON Hierarchy.UID_1C = Price.ParentID AND Hierarchy.Level0 LIKE 'FOOD'
	LEFT JOIN (	SELECT
					Склады.Код AS Склад
					,Остатки.Номенклатура AS Номенклатура
					,SUM(Остатки.Количество) AS Количество
				FROM dbo.РегистрНакопления_ОбщиеОстатки_Остатки AS Остатки
				INNER JOIN dbo.Справочник_Склады AS Склады ON Склады.Ссылка = Остатки.Склад AND Склады.Код IN ('CB000000087')
				WHERE Остатки._Период = CAST('3999-01-11' AS datetime)
				GROUP BY Склады.Код, Остатки.Номенклатура) AS Остатки ON Остатки.Номенклатура = Price.GoodID


GO


