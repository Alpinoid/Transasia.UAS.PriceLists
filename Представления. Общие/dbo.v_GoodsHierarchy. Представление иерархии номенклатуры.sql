SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[v_GoodsHierarchy]','V') IS NOT NULL
	DROP VIEW [dbo].[v_GoodsHierarchy]
GO

CREATE VIEW [dbo].[v_GoodsHierarchy]
AS

SELECT
	Level0.Ссылка AS UID_1C
	,Level0.Наименование AS Level0
	,NULL AS Level1
	,NULL AS Level2
	,NULL AS Level3
	,NULL AS Level4
FROM dbo.Справочник_Номенклатура AS Level0
WHERE Level0.Родитель = 0x00
UNION
SELECT
	CASE
		WHEN SUM(1) OVER (PARTITION BY Level0.Ссылка) = 1 THEN Level0.Ссылка
		WHEN SUM(1) OVER (PARTITION BY Level1.Ссылка) = 1 THEN Level1.Ссылка
	END AS UID_1C
	,Level0.Наименование AS Level0
	,Level1.Наименование AS Level1
	,NULL AS Level2
	,NULL AS Level3
	,NULL AS Level4
FROM dbo.Справочник_Номенклатура AS Level0
LEFT JOIN dbo.Справочник_Номенклатура AS Level1 ON Level1.Родитель = Level0.Ссылка AND Level1.ЭтоГруппа = 0
WHERE Level0.Родитель = 0x00
UNION
SELECT
	CASE
		WHEN SUM(1) OVER (PARTITION BY Level0.Ссылка) = 1 THEN Level0.Ссылка
		WHEN SUM(1) OVER (PARTITION BY Level1.Ссылка) = 1 THEN Level1.Ссылка
		WHEN SUM(1) OVER (PARTITION BY Level2.Ссылка) = 1 THEN Level2.Ссылка
	END
	,Level0.Наименование AS Level0
	,Level1.Наименование AS Level1
	,Level2.Наименование AS Level2
	,NULL AS Level3
	,NULL AS Level4
FROM dbo.Справочник_Номенклатура AS Level0
LEFT JOIN dbo.Справочник_Номенклатура AS Level1 ON Level1.Родитель = Level0.Ссылка AND Level1.ЭтоГруппа = 0
LEFT JOIN dbo.Справочник_Номенклатура AS Level2 ON Level2.Родитель = Level1.Ссылка AND Level2.ЭтоГруппа = 0
WHERE Level0.Родитель = 0x00
UNION
SELECT
	CASE
		WHEN SUM(1) OVER (PARTITION BY Level0.Ссылка) = 1 THEN Level0.Ссылка
		WHEN SUM(1) OVER (PARTITION BY Level1.Ссылка) = 1 THEN Level1.Ссылка
		WHEN SUM(1) OVER (PARTITION BY Level2.Ссылка) = 1 THEN Level2.Ссылка
		WHEN SUM(1) OVER (PARTITION BY Level3.Ссылка) = 1 THEN Level3.Ссылка
	END AS UID_1C
	,Level0.Наименование AS Level0
	,Level1.Наименование AS Level1
	,Level2.Наименование AS Level2
	,Level3.Наименование AS Level3
	,NULL AS Level4
FROM dbo.Справочник_Номенклатура AS Level0
LEFT JOIN dbo.Справочник_Номенклатура AS Level1 ON Level1.Родитель = Level0.Ссылка AND Level1.ЭтоГруппа = 0
LEFT JOIN dbo.Справочник_Номенклатура AS Level2 ON Level2.Родитель = Level1.Ссылка AND Level2.ЭтоГруппа = 0
LEFT JOIN dbo.Справочник_Номенклатура AS Level3 ON Level3.Родитель = Level2.Ссылка AND Level3.ЭтоГруппа = 0
WHERE Level0.Родитель = 0x00
UNION
SELECT
	CASE
		WHEN SUM(1) OVER (PARTITION BY Level0.Ссылка) = 1 THEN Level0.Ссылка
		WHEN SUM(1) OVER (PARTITION BY Level1.Ссылка) = 1 THEN Level1.Ссылка
		WHEN SUM(1) OVER (PARTITION BY Level2.Ссылка) = 1 THEN Level2.Ссылка
		WHEN SUM(1) OVER (PARTITION BY Level3.Ссылка) = 1 THEN Level3.Ссылка
		WHEN SUM(1) OVER (PARTITION BY Level4.Ссылка) = 1 THEN Level4.Ссылка
		--WHEN SUM(1) OVER (PARTITION BY Level5.Ссылка) = 1 THEN Level5.Ссылка
	END AS UID_1C
	,Level0.Наименование AS Level0
	,Level1.Наименование AS Level1
	,Level2.Наименование AS Level2
	,Level3.Наименование AS Level3
	,Level4.Наименование AS Level4
	--,Level5.Наименование AS Level5
	--,Level6.Наименование AS Level6
	--,Level7.Наименование AS Level7
	--,Level8.Наименование AS Level8
	--,Level9.Наименование AS Level9
FROM dbo.Справочник_Номенклатура AS Level0
LEFT JOIN dbo.Справочник_Номенклатура AS Level1 ON Level1.Родитель = Level0.Ссылка AND Level1.ЭтоГруппа = 0
LEFT JOIN dbo.Справочник_Номенклатура AS Level2 ON Level2.Родитель = Level1.Ссылка AND Level2.ЭтоГруппа = 0
LEFT JOIN dbo.Справочник_Номенклатура AS Level3 ON Level3.Родитель = Level2.Ссылка AND Level3.ЭтоГруппа = 0
LEFT JOIN dbo.Справочник_Номенклатура AS Level4 ON Level4.Родитель = Level3.Ссылка AND Level4.ЭтоГруппа = 0
--LEFT JOIN dbo.Справочник_Номенклатура AS Level5 ON Level5.Родитель = Level4.Ссылка AND Level5.ЭтоГруппа = 0
--LEFT JOIN dbo.Справочник_Номенклатура AS Level6 ON Level6.Родитель = Level5.Ссылка AND Level6.ЭтоГруппа = 0
--LEFT JOIN dbo.Справочник_Номенклатура AS Level7 ON Level7.Родитель = Level6.Ссылка AND Level7.ЭтоГруппа = 0
--LEFT JOIN dbo.Справочник_Номенклатура AS Level8 ON Level8.Родитель = Level7.Ссылка AND Level8.ЭтоГруппа = 0
--LEFT JOIN dbo.Справочник_Номенклатура AS Level9 ON Level9.Родитель = Level8.Ссылка AND Level9.ЭтоГруппа = 0
WHERE Level0.Родитель = 0x00

GO


