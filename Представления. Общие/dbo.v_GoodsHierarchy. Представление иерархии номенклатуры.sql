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
	Level0.������ AS UID_1C
	,Level0.������������ AS Level0
	,NULL AS Level1
	,NULL AS Level2
	,NULL AS Level3
	,NULL AS Level4
FROM dbo.����������_������������ AS Level0
WHERE Level0.�������� = 0x00
UNION
SELECT
	CASE
		WHEN SUM(1) OVER (PARTITION BY Level0.������) = 1 THEN Level0.������
		WHEN SUM(1) OVER (PARTITION BY Level1.������) = 1 THEN Level1.������
	END AS UID_1C
	,Level0.������������ AS Level0
	,Level1.������������ AS Level1
	,NULL AS Level2
	,NULL AS Level3
	,NULL AS Level4
FROM dbo.����������_������������ AS Level0
LEFT JOIN dbo.����������_������������ AS Level1 ON Level1.�������� = Level0.������ AND Level1.��������� = 0
WHERE Level0.�������� = 0x00
UNION
SELECT
	CASE
		WHEN SUM(1) OVER (PARTITION BY Level0.������) = 1 THEN Level0.������
		WHEN SUM(1) OVER (PARTITION BY Level1.������) = 1 THEN Level1.������
		WHEN SUM(1) OVER (PARTITION BY Level2.������) = 1 THEN Level2.������
	END
	,Level0.������������ AS Level0
	,Level1.������������ AS Level1
	,Level2.������������ AS Level2
	,NULL AS Level3
	,NULL AS Level4
FROM dbo.����������_������������ AS Level0
LEFT JOIN dbo.����������_������������ AS Level1 ON Level1.�������� = Level0.������ AND Level1.��������� = 0
LEFT JOIN dbo.����������_������������ AS Level2 ON Level2.�������� = Level1.������ AND Level2.��������� = 0
WHERE Level0.�������� = 0x00
UNION
SELECT
	CASE
		WHEN SUM(1) OVER (PARTITION BY Level0.������) = 1 THEN Level0.������
		WHEN SUM(1) OVER (PARTITION BY Level1.������) = 1 THEN Level1.������
		WHEN SUM(1) OVER (PARTITION BY Level2.������) = 1 THEN Level2.������
		WHEN SUM(1) OVER (PARTITION BY Level3.������) = 1 THEN Level3.������
	END AS UID_1C
	,Level0.������������ AS Level0
	,Level1.������������ AS Level1
	,Level2.������������ AS Level2
	,Level3.������������ AS Level3
	,NULL AS Level4
FROM dbo.����������_������������ AS Level0
LEFT JOIN dbo.����������_������������ AS Level1 ON Level1.�������� = Level0.������ AND Level1.��������� = 0
LEFT JOIN dbo.����������_������������ AS Level2 ON Level2.�������� = Level1.������ AND Level2.��������� = 0
LEFT JOIN dbo.����������_������������ AS Level3 ON Level3.�������� = Level2.������ AND Level3.��������� = 0
WHERE Level0.�������� = 0x00
UNION
SELECT
	CASE
		WHEN SUM(1) OVER (PARTITION BY Level0.������) = 1 THEN Level0.������
		WHEN SUM(1) OVER (PARTITION BY Level1.������) = 1 THEN Level1.������
		WHEN SUM(1) OVER (PARTITION BY Level2.������) = 1 THEN Level2.������
		WHEN SUM(1) OVER (PARTITION BY Level3.������) = 1 THEN Level3.������
		WHEN SUM(1) OVER (PARTITION BY Level4.������) = 1 THEN Level4.������
		--WHEN SUM(1) OVER (PARTITION BY Level5.������) = 1 THEN Level5.������
	END AS UID_1C
	,Level0.������������ AS Level0
	,Level1.������������ AS Level1
	,Level2.������������ AS Level2
	,Level3.������������ AS Level3
	,Level4.������������ AS Level4
	--,Level5.������������ AS Level5
	--,Level6.������������ AS Level6
	--,Level7.������������ AS Level7
	--,Level8.������������ AS Level8
	--,Level9.������������ AS Level9
FROM dbo.����������_������������ AS Level0
LEFT JOIN dbo.����������_������������ AS Level1 ON Level1.�������� = Level0.������ AND Level1.��������� = 0
LEFT JOIN dbo.����������_������������ AS Level2 ON Level2.�������� = Level1.������ AND Level2.��������� = 0
LEFT JOIN dbo.����������_������������ AS Level3 ON Level3.�������� = Level2.������ AND Level3.��������� = 0
LEFT JOIN dbo.����������_������������ AS Level4 ON Level4.�������� = Level3.������ AND Level4.��������� = 0
--LEFT JOIN dbo.����������_������������ AS Level5 ON Level5.�������� = Level4.������ AND Level5.��������� = 0
--LEFT JOIN dbo.����������_������������ AS Level6 ON Level6.�������� = Level5.������ AND Level6.��������� = 0
--LEFT JOIN dbo.����������_������������ AS Level7 ON Level7.�������� = Level6.������ AND Level7.��������� = 0
--LEFT JOIN dbo.����������_������������ AS Level8 ON Level8.�������� = Level7.������ AND Level8.��������� = 0
--LEFT JOIN dbo.����������_������������ AS Level9 ON Level9.�������� = Level8.������ AND Level9.��������� = 0
WHERE Level0.�������� = 0x00

GO


