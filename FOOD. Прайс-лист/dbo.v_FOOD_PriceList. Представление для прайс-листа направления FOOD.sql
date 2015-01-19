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
		CAST(Price._������ AS date) AS Date																		-- ���� ����
		,Price.������������ AS GoodID																			-- ID ������
		,PriceType.������������ AS PriceType																	-- ID ���� ����
		,Price.���� AS Price																					-- ����
	FROM dbo.���������������_���������������� AS Price													-- ���������������.����������������
	INNER JOIN dbo.����������_������������������� AS PriceType ON PriceType.������ = Price.�������		-- .����������_�������������������
																AND PriceType.������������������ = 0x829508606E88610311E4843B1F21A0A6
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
		������������.������ AS GoodID
		,������������.�������� AS ParentID
		,������������.������� AS GoodArticle
		,�����.EAN AS EAN
		,������������.������������ AS GoodDescription
		,MAX(�������.�����������) AS UnitsInBox
		,PriceType AS PriceType
		,Price AS Price
	FROM PriceCalculation
	LEFT JOIN dbo.����������_������������ AS ������������ ON ������������.������ = GoodID AND ������������.��������������� = 0x00
	LEFT JOIN dbo.����������_���������������� AS ������� ON �������.�������� = ������������.������ AND �������.������������ LIKE '%���%'
	LEFT JOIN dbo.����������_���������������� AS ����� ON �����.������ = ������������.�����������������������
	GROUP BY ������������.������, ������������.��������, ������������.�������, �����.EAN, ������������.������������, PriceType, Price
	)
	SELECT
		Hierarchy.Level1	AS '������� �������� 1'
		,Hierarchy.Level2	AS '������� �������� 2'
		,Hierarchy.Level3	AS '������� �������� 3'
		,Hierarchy.Level4	AS '������� �������� 4'
		,GoodArticle		AS '�������'
		,EAN				AS '�����-���'
		,GoodDescription	AS '������������'
		,UnitsInBox			AS '���� � �������'
		,PriceType			AS '��� ����'
		,Price				AS '����'
		,IIF(�������.���������� < 0, 0, �������.����������) AS '������� �� ������'
	FROM Price
	LEFT JOIN olap.v_GoodsHierarchy AS Hierarchy ON Hierarchy.UID_1C = Price.ParentID AND Hierarchy.Level0 LIKE 'FOOD'
	LEFT JOIN (	SELECT
					������.��� AS �����
					,�������.������������ AS ������������
					,SUM(�������.����������) AS ����������
				FROM dbo.�����������������_������������_������� AS �������
				INNER JOIN dbo.����������_������ AS ������ ON ������.������ = �������.����� AND ������.��� IN ('CB000000087')
				WHERE �������._������ = CAST('3999-01-11' AS datetime)
				GROUP BY ������.���, �������.������������) AS ������� ON �������.������������ = Price.GoodID


GO


