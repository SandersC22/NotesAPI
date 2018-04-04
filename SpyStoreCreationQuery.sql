USE [master]
GO
/****** Object:  Database [SpyStoreDatabase]    Script Date: 10/27/2016 2:45:20 PM ******/
CREATE DATABASE [SpyStoreDatabase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SpyStoreDatabase', FILENAME = N'C:\SpyStoreDB\SpyStoreDatabase.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SpyStoreDatabase_log', FILENAME = N'C:\SpyStoreDB\SpyStoreDatabase_log.ldf' , SIZE = 816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SpyStoreDatabase] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SpyStoreDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SpyStoreDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SpyStoreDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SpyStoreDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SpyStoreDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SpyStoreDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SpyStoreDatabase] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [SpyStoreDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SpyStoreDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [SpyStoreDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SpyStoreDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SpyStoreDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SpyStoreDatabase] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SpyStoreDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SpyStoreDatabase]
GO
/****** Object:  Schema [Store]    Script Date: 10/27/2016 2:45:20 PM ******/
CREATE SCHEMA [Store]
GO
/****** Object:  Table [Store].[OrderDetails]    Script Date: 10/27/2016 2:45:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LineItemTotal]  AS ([Quantity]*[UnitCost]),
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
	[UnitCost] [money] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [Store].[GetOrderTotal]    Script Date: 10/27/2016 2:45:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Store].[GetOrderTotal] ( @OrderId INT ) RETURNS MONEY WITH SCHEMABINDING BEGIN DECLARE @Result MONEY; SELECT  @Result = SUM([Quantity]*[UnitCost]) FROM Store.OrderDetails  WHERE OrderId = @OrderId; RETURN @Result END;

GO
/****** Object:  Table [Store].[Orders]    Script Date: 10/27/2016 2:45:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[ShipDate] [datetime] NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
	[OrderTotalComputed]  AS ([Store].[GetOrderTotal]([Id])),
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 10/27/2016 2:45:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Store].[Categories]    Script Date: 10/27/2016 2:45:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NULL,
	[TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Store].[Customers]    Script Date: 10/27/2016 2:45:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Store].[Products]    Script Date: 10/27/2016 2:45:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[CurrentPrice] [money] NOT NULL,
	[Description] [nvarchar](3800) NULL,
	[IsFeatured] [bit] NOT NULL,
	[ModelName] [nvarchar](50) NULL,
	[ModelNumber] [nvarchar](50) NULL,
	[ProductImage] [nvarchar](150) NULL,
	[ProductImageLarge] [nvarchar](150) NULL,
	[ProductImageThumb] [nvarchar](150) NULL,
	[TimeStamp] [timestamp] NOT NULL,
	[UnitCost] [money] NOT NULL,
	[UnitsInStock] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Store].[ShoppingCartRecords]    Script Date: 10/27/2016 2:45:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Store].[ShoppingCartRecords](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[DateCreated] [datetime] NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_ShoppingCartRecords] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Customers]    Script Date: 10/27/2016 2:45:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Customers] ON [Store].[Customers]
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetails_OrderId]    Script Date: 10/27/2016 2:45:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_OrderId] ON [Store].[OrderDetails]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetails_ProductId]    Script Date: 10/27/2016 2:45:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_ProductId] ON [Store].[OrderDetails]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_CustomerId]    Script Date: 10/27/2016 2:45:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_CustomerId] ON [Store].[Orders]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_CategoryId]    Script Date: 10/27/2016 2:45:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_CategoryId] ON [Store].[Products]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShoppingCart]    Script Date: 10/27/2016 2:45:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingCart] ON [Store].[ShoppingCartRecords]
(
	[Id] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShoppingCartRecords_CustomerId]    Script Date: 10/27/2016 2:45:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingCartRecords_CustomerId] ON [Store].[ShoppingCartRecords]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShoppingCartRecords_ProductId]    Script Date: 10/27/2016 2:45:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingCartRecords_ProductId] ON [Store].[ShoppingCartRecords]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [Store].[Orders] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [Store].[Orders] ADD  DEFAULT (getdate()) FOR [ShipDate]
GO
ALTER TABLE [Store].[ShoppingCartRecords] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [Store].[ShoppingCartRecords] ADD  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [Store].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [Store].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [Store].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders_OrderId]
GO
ALTER TABLE [Store].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [Store].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [Store].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products_ProductId]
GO
ALTER TABLE [Store].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [Store].[Customers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [Store].[Orders] CHECK CONSTRAINT [FK_Orders_Customers_CustomerId]
GO
ALTER TABLE [Store].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [Store].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [Store].[Products] CHECK CONSTRAINT [FK_Products_Categories_CategoryId]
GO
ALTER TABLE [Store].[ShoppingCartRecords]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCartRecords_Customers_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [Store].[Customers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [Store].[ShoppingCartRecords] CHECK CONSTRAINT [FK_ShoppingCartRecords_Customers_CustomerId]
GO
ALTER TABLE [Store].[ShoppingCartRecords]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCartRecords_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [Store].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [Store].[ShoppingCartRecords] CHECK CONSTRAINT [FK_ShoppingCartRecords_Products_ProductId]
GO
/****** Object:  StoredProcedure [Store].[PurchaseItemsInCart]    Script Date: 10/27/2016 2:45:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Store].[PurchaseItemsInCart](@customerId INT = 0) AS BEGIN  SET NOCOUNT ON;  DECLARE @orderId INT; INSERT INTO Store.Orders (CustomerId, OrderDate, ShipDate)     VALUES(@customerId, GETDATE(), GETDATE());  SET @orderId = SCOPE_IDENTITY();  DECLARE @TranName VARCHAR(20);SELECT @TranName = 'CommitOrder';    BEGIN TRANSACTION @TranName;    BEGIN TRY        INSERT INTO Store.OrderDetails (OrderId, ProductId, Quantity, UnitCost)        SELECT @orderId, ProductId, Quantity, p.CurrentPrice        FROM Store.ShoppingCartRecords scr           INNER JOIN Store.Products p ON p.Id = scr.ProductId        WHERE CustomerId = @customerId;        DELETE FROM Store.ShoppingCartRecords WHERE CustomerId = @customerId;        COMMIT TRANSACTION @TranName;        SELECT @orderId;    END TRY    BEGIN CATCH        ROLLBACK TRANSACTION @TranName;        SELECT -1;    END CATCH; END;;

GO
USE [master]
GO
ALTER DATABASE [SpyStoreDatabase] SET  READ_WRITE 
GO