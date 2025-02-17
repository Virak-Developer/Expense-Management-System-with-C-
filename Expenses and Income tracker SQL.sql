
/****** Object:  Table [dbo].[categories]    Script Date: 11/28/2024 1:16:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](255) NULL,
	[Status] [varchar](255) NULL,
	[Date] [datetime] NULL,
	[Type] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[expenses]    Script Date: 11/28/2024 1:16:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[expenses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [int] NULL,
	[Item] [varchar](max) NULL,
	[Expense] [float] NULL,
	[Description] [text] NULL,
	[Date_expenses] [date] NULL,
	[Date_insert] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[viewExpenses]    Script Date: 11/28/2024 1:16:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewExpenses]
AS
SELECT        dbo.expenses.Id, dbo.categories.Category, dbo.expenses.Item, dbo.expenses.Expense, dbo.expenses.Description, dbo.expenses.Date_expenses, dbo.expenses.Date_insert
FROM            dbo.categories INNER JOIN
                         dbo.expenses ON dbo.categories.ID = dbo.expenses.Category
GO
/****** Object:  Table [dbo].[income]    Script Date: 11/28/2024 1:16:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[income](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NULL,
	[Item] [varchar](max) NULL,
	[Income] [float] NULL,
	[Description] [text] NULL,
	[Date_income] [date] NULL,
	[Date_insert] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewIncome]    Script Date: 11/28/2024 1:16:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewIncome]
AS
SELECT        dbo.income.Id, dbo.categories.Category, dbo.income.Item, dbo.income.Income, dbo.income.Description, dbo.income.Date_income, dbo.income.Date_insert
FROM            dbo.income INNER JOIN
                         dbo.categories ON dbo.income.CategoryID = dbo.categories.ID
GO
/****** Object:  Table [dbo].[users]    Script Date: 11/28/2024 1:16:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[Passwords] [varchar](50) NULL,
	[dates] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[categories] ON 

INSERT [dbo].[categories] ([ID], [Category], [Status], [Date], [Type]) VALUES (9, N'Allownce', N'Active', CAST(N'2024-11-27T17:33:38.927' AS DateTime), N'Income')
SET IDENTITY_INSERT [dbo].[categories] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([ID], [UserName], [Passwords], [dates]) VALUES (1, N'lux', N'1234', CAST(N'2024-11-22' AS Date))
INSERT [dbo].[users] ([ID], [UserName], [Passwords], [dates]) VALUES (2, N'luxx', N'344', CAST(N'2024-11-22' AS Date))
SET IDENTITY_INSERT [dbo].[users] OFF
GO
ALTER TABLE [dbo].[categories] ADD  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[expenses] ADD  DEFAULT (CONVERT([date],getdate())) FOR [Date_expenses]
GO
ALTER TABLE [dbo].[expenses] ADD  DEFAULT (CONVERT([date],getdate())) FOR [Date_insert]
GO
ALTER TABLE [dbo].[income] ADD  DEFAULT (CONVERT([date],getdate())) FOR [Date_income]
GO
ALTER TABLE [dbo].[income] ADD  DEFAULT (CONVERT([date],getdate())) FOR [Date_insert]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (CONVERT([date],getdate())) FOR [dates]
GO
ALTER TABLE [dbo].[expenses]  WITH CHECK ADD  CONSTRAINT [FK_expenses_categories] FOREIGN KEY([Category])
REFERENCES [dbo].[categories] ([ID])
GO
ALTER TABLE [dbo].[expenses] CHECK CONSTRAINT [FK_expenses_categories]
GO
ALTER TABLE [dbo].[income]  WITH CHECK ADD  CONSTRAINT [FK_income_categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[categories] ([ID])
GO
ALTER TABLE [dbo].[income] CHECK CONSTRAINT [FK_income_categories]
GO
/****** Object:  StoredProcedure [dbo].[DeleteCategory]    Script Date: 11/28/2024 1:16:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteCategory]  
    @ID INT  
AS  
BEGIN  
    DELETE FROM [dbo].[categories]  
    WHERE [ID] = @ID;  
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteExpense]    Script Date: 11/28/2024 1:16:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteExpense]  
    @GetID INT  
AS  
BEGIN  
    DELETE FROM [dbo].[expenses]  
    WHERE ID = @GetID;  
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteIncome]    Script Date: 11/28/2024 1:16:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteIncome]  
    @GetID INT  
AS  
BEGIN  
    DELETE FROM [dbo].[income]  
    WHERE ID = @GetID;  
END;
GO
/****** Object:  StoredProcedure [dbo].[GetViewExpensesWithCategories]    Script Date: 11/28/2024 1:16:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetViewExpensesWithCategories]
AS
BEGIN
    SELECT 
        dbo.expenses.Id AS ExpenseID,          -- Expense ID
        dbo.categories.Category,               -- Category (Displayed)
        dbo.expenses.Item, 
        dbo.expenses.Expense, 
        dbo.expenses.Description, 
        dbo.expenses.Date_expenses, 
        dbo.expenses.Date_insert,
        dbo.categories.ID AS CategoryID       -- Category ID (Hidden)
    FROM 
        dbo.categories
    INNER JOIN 
        dbo.expenses ON dbo.categories.ID = dbo.expenses.Category;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetViewIncomeWithCategories]    Script Date: 11/28/2024 1:16:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetViewIncomeWithCategories]
AS
BEGIN
    SELECT 
        dbo.income.Id AS IncomeID,       -- Income ID
        dbo.categories.Category,         -- Category (Displayed)
        dbo.income.Item, 
        dbo.income.Income, 
        dbo.income.Description, 
        dbo.income.Date_income, 
        dbo.income.Date_insert,
        dbo.categories.ID AS CategoryID  -- Category ID (Hidden)
    FROM 
        dbo.income
    INNER JOIN 
        dbo.categories ON dbo.income.CategoryID = dbo.categories.ID;
END;

GO
/****** Object:  StoredProcedure [dbo].[InsertExpense]    Script Date: 11/28/2024 1:16:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertExpense]  
    @Category INT,  
    @Item NVARCHAR(255),  
    @Expense DECIMAL(18, 2),  
    @Description NVARCHAR(MAX),  
    @Date_expenses DATE  
AS  
BEGIN  
    INSERT INTO [dbo].[expenses] ([Category], [Item], [Expense], [Description], [Date_expenses])  
    VALUES (@Category, @Item, @Expense, @Description, @Date_expenses);  
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertIncome]    Script Date: 11/28/2024 1:16:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertIncome]  
    @CategoryID INT,  
    @Item NVARCHAR(255),  
    @Income DECIMAL(18, 2),  
    @Description NVARCHAR(MAX),  
    @DateIncome DATE  
AS  
BEGIN  
    INSERT INTO [dbo].[income] ([CategoryID], [Item], [Income], [Description], [Date_income])  
    VALUES (@CategoryID, @Item, @Income, @Description, @DateIncome);  
END;
GO
/****** Object:  StoredProcedure [dbo].[Proc_InsertCategory]    Script Date: 11/28/2024 1:16:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_InsertCategory]  
    @Category NVARCHAR(255),  
    @Status NVARCHAR(50),  
    @Type NVARCHAR(50)  
AS  
BEGIN  
    INSERT INTO [dbo].[categories] ([Category], [Status], [Type])  
    VALUES (@Category, @Status, @Type);  
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateCategory]    Script Date: 11/28/2024 1:16:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCategory]  
    @ID INT,  
    @Category NVARCHAR(255),  
    @Status NVARCHAR(50),  
    @Type NVARCHAR(50)  
AS  
BEGIN  
    UPDATE [dbo].[categories]  
    SET [Category] = @Category,  
        [Status] = @Status,  
        [Type] = @Type  
    WHERE [ID] = @ID;  
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateExpenses]    Script Date: 11/28/2024 1:16:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[UpdateExpenses]
    @Id INT,
    @Category INT,
    @Item VARCHAR(MAX),
    @Expense FLOAT,
    @Description TEXT,
    @Date_expenses DATE,
    @Date_insert DATE
AS
BEGIN
    UPDATE [dbo].[expenses]
    SET 
        [Category] = @Category,
        [Item] = @Item,
        [Expense] = @Expense,
        [Description] = @Description,
        [Date_expenses] = @Date_expenses,
        [Date_insert] = @Date_insert
    WHERE 
        [Id] = @id;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateIncome]    Script Date: 11/28/2024 1:16:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateIncome]
    @Id INT,
    @CategoryID INT,
    @Item VARCHAR(MAX),
    @Income FLOAT,
    @Description TEXT,
    @Date_income DATE,
    @Date_insert DATE
AS
BEGIN
    UPDATE [dbo].[income]
    SET 
        [CategoryID] = @CategoryID,
        [Item] = @Item,
        [Income] = @Income,
        [Description] = @Description,
        [Date_income] = @Date_income,
        [Date_insert] = @Date_insert
    WHERE 
        [Id] = @id;
END;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "categories"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "expenses"
            Begin Extent = 
               Top = 5
               Left = 289
               Bottom = 135
               Right = 459
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'viewExpenses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'viewExpenses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "income"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "categories"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewIncome'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewIncome'


