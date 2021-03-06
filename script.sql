USE [master]
GO
/****** Object:  Database [db_employee]    Script Date: 5/11/2015 11:25:12 AM ******/
CREATE DATABASE [db_employee]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db_employee', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\db_employee.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'db_employee_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\db_employee_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [db_employee] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_employee].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db_employee] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db_employee] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db_employee] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db_employee] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db_employee] SET ARITHABORT OFF 
GO
ALTER DATABASE [db_employee] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [db_employee] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [db_employee] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db_employee] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db_employee] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db_employee] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db_employee] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db_employee] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db_employee] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db_employee] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db_employee] SET  DISABLE_BROKER 
GO
ALTER DATABASE [db_employee] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db_employee] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db_employee] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db_employee] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db_employee] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db_employee] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db_employee] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db_employee] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [db_employee] SET  MULTI_USER 
GO
ALTER DATABASE [db_employee] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db_employee] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db_employee] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db_employee] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [db_employee]
GO
/****** Object:  Table [dbo].[tbl_employee]    Script Date: 5/11/2015 11:25:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_employee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](150) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[address] [varchar](250) NULL,
	[salary] [int] NOT NULL,
 CONSTRAINT [PK_tbl_employee] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_employee] ON 

INSERT [dbo].[tbl_employee] ([id], [name], [email], [address], [salary]) VALUES (1, N'Nayan', N'nayan.cmt@gmail.com', N'Dhaka', 50000)
INSERT [dbo].[tbl_employee] ([id], [name], [email], [address], [salary]) VALUES (2, N'vishnu', N'vishnudas704@yahool.com', N'Mirpur', 60000)
SET IDENTITY_INSERT [dbo].[tbl_employee] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_tbl_employee]    Script Date: 5/11/2015 11:25:12 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tbl_employee] ON [dbo].[tbl_employee]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [db_employee] SET  READ_WRITE 
GO
