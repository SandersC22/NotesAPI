USE [master]
GO
/****** Object:  Database [NotesDatabase]    Script Date: 03/28/2018 2:45:20 PM ******/
CREATE DATABASE [NotesDatabase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NotesDatabase', FILENAME = N'C:\NotesDB\NotesDatabase.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NotesDatabase_log', FILENAME = N'C:\NotesDB\NotesDatabase_log.ldf' , SIZE = 816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NotesDatabase] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NotesDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NotesDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NotesDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NotesDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NotesDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NotesDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [NotesDatabase] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [NotesDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NotesDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NotesDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NotesDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NotesDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NotesDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NotesDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NotesDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NotesDatabase] SET  ENABLE_BROKER 
GO
ALTER DATABASE [NotesDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NotesDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NotesDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NotesDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NotesDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NotesDatabase] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [NotesDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NotesDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NotesDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [NotesDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NotesDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NotesDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NotesDatabase] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [NotesDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
USE [NotesDatabase]
GO
/****** Object:  Schema [Entities]   ******/
CREATE SCHEMA [Entities]
GO
/****** Object:  Table [Entities].[User]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Entities].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [Entities].[Note] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Entities].[Notes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Note] [nvarchar](150) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[IsDeleted] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_Notes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[__EFMigrationsHistory] ******/
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
/****** Object:  Table [Entities].[Category] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Entities].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [Entities].[Notes]
	ADD FOREIGN KEY (UserId) REFERENCES [Entities].[User] (Id);
GO

ALTER TABLE [Entities].[Notes]
	ADD FOREIGN KEY (CategoryId) REFERENCES [Entities].[Category] (Id);
GO

USE [master]
GO
ALTER DATABASE [NotesDatabase] SET  READ_WRITE 
GO