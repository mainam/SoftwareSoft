USE [master]
GO
/****** Object:  Database [MNSHOP]    Script Date: 11/27/2016 11:55:47 PM ******/
CREATE DATABASE [MNSHOP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MNSHOP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\MNSHOP.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MNSHOP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\MNSHOP_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MNSHOP] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MNSHOP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MNSHOP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MNSHOP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MNSHOP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MNSHOP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MNSHOP] SET ARITHABORT OFF 
GO
ALTER DATABASE [MNSHOP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MNSHOP] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [MNSHOP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MNSHOP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MNSHOP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MNSHOP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MNSHOP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MNSHOP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MNSHOP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MNSHOP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MNSHOP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MNSHOP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MNSHOP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MNSHOP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MNSHOP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MNSHOP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MNSHOP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MNSHOP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MNSHOP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MNSHOP] SET  MULTI_USER 
GO
ALTER DATABASE [MNSHOP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MNSHOP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MNSHOP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MNSHOP] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [MNSHOP]
GO
/****** Object:  Table [dbo].[tbCategory]    Script Date: 11/27/2016 11:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ParentId] [int] NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Order] [int] NOT NULL,
 CONSTRAINT [PK_tbCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbInvoke]    Script Date: 11/27/2016 11:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbInvoke](
	[Id] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[SoftwareId] [int] NOT NULL,
	[Price] [decimal](18, 0) NOT NULL,
	[Discount] [int] NOT NULL,
	[RealPrice] [decimal](18, 0) NOT NULL,
	[Note] [nvarchar](max) NOT NULL,
	[BoughtBy] [nvarchar](50) NOT NULL,
	[AutoGenLink] [nvarchar](255) NOT NULL,
	[ExpirationDateForLink] [datetime] NOT NULL,
 CONSTRAINT [PK_tbInvoke] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbSoftwaraStatus]    Script Date: 11/27/2016 11:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbSoftwaraStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tbSoftwaraStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbSoftware]    Script Date: 11/27/2016 11:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbSoftware](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ImageUrl] [nvarchar](50) NOT NULL,
	[UpBy] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[ShortDescription] [nvarchar](500) NOT NULL,
	[Status] [int] NOT NULL,
	[NumberGuaranteeDate] [int] NOT NULL,
	[Price] [decimal](18, 0) NOT NULL,
	[Discount] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Link] [nvarchar](255) NOT NULL,
	[CloseDate] [datetime] NULL,
 CONSTRAINT [PK_tbSoftware] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbTransaction]    Script Date: 11/27/2016 11:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbTransaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[Type] [int] NOT NULL,
	[Value] [decimal](18, 0) NOT NULL,
	[InvokeId] [int] NULL,
	[Source] [nvarchar](50) NULL,
	[Destination] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbTypeTransaction]    Script Date: 11/27/2016 11:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbTypeTransaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tbTypeTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbTypeUser]    Script Date: 11/27/2016 11:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbTypeUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tbTypeUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbUser]    Script Date: 11/27/2016 11:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbUser](
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[TypeUser] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[Money] [decimal](18, 0) NOT NULL,
	[LastLogin] [datetime] NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](14) NOT NULL,
 CONSTRAINT [PK_tbUser] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tbCategory] ON 

INSERT [dbo].[tbCategory] ([Id], [Name], [ParentId], [Description], [Order]) VALUES (10, N'mai ngoc nam', NULL, N'1', 1)
SET IDENTITY_INSERT [dbo].[tbCategory] OFF
SET IDENTITY_INSERT [dbo].[tbSoftwaraStatus] ON 

INSERT [dbo].[tbSoftwaraStatus] ([Id], [Name]) VALUES (1, N'Open')
INSERT [dbo].[tbSoftwaraStatus] ([Id], [Name]) VALUES (2, N'Close')
SET IDENTITY_INSERT [dbo].[tbSoftwaraStatus] OFF
SET IDENTITY_INSERT [dbo].[tbSoftware] ON 

INSERT [dbo].[tbSoftware] ([Id], [Name], [ImageUrl], [UpBy], [Description], [ShortDescription], [Status], [NumberGuaranteeDate], [Price], [Discount], [CategoryId], [Link], [CloseDate]) VALUES (5, N'Sắp xếp lịch thi', N' ', N'ngoc.nam', N' ', N' ', 1, 12, CAST(1000000 AS Decimal(18, 0)), 20, 10, N' ', NULL)
INSERT [dbo].[tbSoftware] ([Id], [Name], [ImageUrl], [UpBy], [Description], [ShortDescription], [Status], [NumberGuaranteeDate], [Price], [Discount], [CategoryId], [Link], [CloseDate]) VALUES (6, N'Phần mềm kế toán', N' ', N'ngoc.nam', N' ', N' ', 2, 12, CAST(1000000 AS Decimal(18, 0)), 20, 10, N' ', CAST(N'2016-11-27 00:00:00.000' AS DateTime))
INSERT [dbo].[tbSoftware] ([Id], [Name], [ImageUrl], [UpBy], [Description], [ShortDescription], [Status], [NumberGuaranteeDate], [Price], [Discount], [CategoryId], [Link], [CloseDate]) VALUES (7, N'Phần mềm doanh nghiệp', N' ', N'admin', N' ', N' ', 2, 12, CAST(1000000 AS Decimal(18, 0)), 20, 10, N' ', CAST(N'2016-11-27 00:00:00.000' AS DateTime))
INSERT [dbo].[tbSoftware] ([Id], [Name], [ImageUrl], [UpBy], [Description], [ShortDescription], [Status], [NumberGuaranteeDate], [Price], [Discount], [CategoryId], [Link], [CloseDate]) VALUES (8, N'Phần mềm test', N' ', N'ngoc.nam', N' ', N' ', 1, 12, CAST(1000000 AS Decimal(18, 0)), 20, 10, N' ', NULL)
INSERT [dbo].[tbSoftware] ([Id], [Name], [ImageUrl], [UpBy], [Description], [ShortDescription], [Status], [NumberGuaranteeDate], [Price], [Discount], [CategoryId], [Link], [CloseDate]) VALUES (9, N'Phần mềm nghe nhac', N' ', N'admin', N' ', N' ', 2, 12, CAST(1000000 AS Decimal(18, 0)), 20, 10, N' ', CAST(N'2016-11-27 00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[tbSoftware] OFF
SET IDENTITY_INSERT [dbo].[tbTransaction] ON 

INSERT [dbo].[tbTransaction] ([Id], [CreatedDate], [Description], [Type], [Value], [InvokeId], [Source], [Destination]) VALUES (10, CAST(N'2016-11-26 00:16:36.363' AS DateTime), N'test', 1, CAST(10000 AS Decimal(18, 0)), NULL, N'admin', N'admin')
INSERT [dbo].[tbTransaction] ([Id], [CreatedDate], [Description], [Type], [Value], [InvokeId], [Source], [Destination]) VALUES (13, CAST(N'2016-11-26 00:20:11.763' AS DateTime), N'ewetwr', 1, CAST(20000 AS Decimal(18, 0)), NULL, N'admin', N'admin')
SET IDENTITY_INSERT [dbo].[tbTransaction] OFF
SET IDENTITY_INSERT [dbo].[tbTypeTransaction] ON 

INSERT [dbo].[tbTypeTransaction] ([Id], [Name]) VALUES (1, N'Hệ thống')
INSERT [dbo].[tbTypeTransaction] ([Id], [Name]) VALUES (2, N'Mua Hàng')
INSERT [dbo].[tbTypeTransaction] ([Id], [Name]) VALUES (3, N'Hoàn tiền')
SET IDENTITY_INSERT [dbo].[tbTypeTransaction] OFF
SET IDENTITY_INSERT [dbo].[tbTypeUser] ON 

INSERT [dbo].[tbTypeUser] ([Id], [Name]) VALUES (1, N'Admin')
INSERT [dbo].[tbTypeUser] ([Id], [Name]) VALUES (2, N'Seller')
INSERT [dbo].[tbTypeUser] ([Id], [Name]) VALUES (3, N'Member')
SET IDENTITY_INSERT [dbo].[tbTypeUser] OFF
INSERT [dbo].[tbUser] ([UserName], [Password], [FullName], [TypeUser], [Active], [Money], [LastLogin], [Email], [Phone]) VALUES (N'admin', N'21-23-2F-29-7A-57-A5-A7-43-89-4A-0E-4A-80-1F-C3', N'MAI NGOC NAM', 1, 1, CAST(397000 AS Decimal(18, 0)), CAST(N'2015-01-01 00:00:00.000' AS DateTime), N'mainam.ctk33@gmail.com', N'01656214791')
INSERT [dbo].[tbUser] ([UserName], [Password], [FullName], [TypeUser], [Active], [Money], [LastLogin], [Email], [Phone]) VALUES (N'mainam', N'94-B4-03-04-93-8C-74-DE-70-BB-30-69-25-57-A3-0C', N'mai ngoc nam 2222', 1, 0, CAST(0 AS Decimal(18, 0)), CAST(N'2016-11-27 15:01:04.360' AS DateTime), N'mainam12a@gmail.com', N'0123456')
INSERT [dbo].[tbUser] ([UserName], [Password], [FullName], [TypeUser], [Active], [Money], [LastLogin], [Email], [Phone]) VALUES (N'mainam12a', N'E1-0A-DC-39-49-BA-59-AB-BE-56-E0-57-F2-0F-88-3E', N'otiuwoer', 3, 1, CAST(0 AS Decimal(18, 0)), CAST(N'2016-11-27 15:30:16.597' AS DateTime), N'rtertueor2@gert.ert', N'')
INSERT [dbo].[tbUser] ([UserName], [Password], [FullName], [TypeUser], [Active], [Money], [LastLogin], [Email], [Phone]) VALUES (N'na452o3475028towiueywoeiuyu', N'E1-0A-DC-39-49-BA-59-AB-BE-56-E0-57-F2-0F-88-3E', N'rtweoruytwieuy', 2, 1, CAST(0 AS Decimal(18, 0)), CAST(N'2016-11-27 15:16:57.077' AS DateTime), N'weuiytwoieury@gdfgrte.rer', N'woeiurytw')
INSERT [dbo].[tbUser] ([UserName], [Password], [FullName], [TypeUser], [Active], [Money], [LastLogin], [Email], [Phone]) VALUES (N'ngoc.nam', N'21-23-2F-29-7A-57-A5-A7-43-89-4A-0E-4A-80-1F-C3', N'NGOC NAM', 1, 1, CAST(0 AS Decimal(18, 0)), CAST(N'2016-11-27 15:17:31.897' AS DateTime), N'wrtwe@ggert.ert', N'')
INSERT [dbo].[tbUser] ([UserName], [Password], [FullName], [TypeUser], [Active], [Money], [LastLogin], [Email], [Phone]) VALUES (N'TOWIERUT', N'E1-0A-DC-39-49-BA-59-AB-BE-56-E0-57-F2-0F-88-3E', N'WR', 1, 1, CAST(0 AS Decimal(18, 0)), CAST(N'2016-11-27 15:18:08.650' AS DateTime), N'TOIEWRU@RTETERT.ERTER', N'')
INSERT [dbo].[tbUser] ([UserName], [Password], [FullName], [TypeUser], [Active], [Money], [LastLogin], [Email], [Phone]) VALUES (N'wtweurtoewiru', N'E1-0A-DC-39-49-BA-59-AB-BE-56-E0-57-F2-0F-88-3E', N'reoutero', 1, 1, CAST(0 AS Decimal(18, 0)), CAST(N'2016-11-27 15:17:50.373' AS DateTime), N'tertert@ert.ertert', N'rtiuwoeirut')
ALTER TABLE [dbo].[tbCategory]  WITH CHECK ADD  CONSTRAINT [FK_tbCategory_tbCategory] FOREIGN KEY([ParentId])
REFERENCES [dbo].[tbCategory] ([Id])
GO
ALTER TABLE [dbo].[tbCategory] CHECK CONSTRAINT [FK_tbCategory_tbCategory]
GO
ALTER TABLE [dbo].[tbInvoke]  WITH CHECK ADD  CONSTRAINT [FK_tbInvoke_tbSoftware] FOREIGN KEY([SoftwareId])
REFERENCES [dbo].[tbSoftware] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbInvoke] CHECK CONSTRAINT [FK_tbInvoke_tbSoftware]
GO
ALTER TABLE [dbo].[tbInvoke]  WITH CHECK ADD  CONSTRAINT [FK_tbInvoke_tbUser] FOREIGN KEY([BoughtBy])
REFERENCES [dbo].[tbUser] ([UserName])
GO
ALTER TABLE [dbo].[tbInvoke] CHECK CONSTRAINT [FK_tbInvoke_tbUser]
GO
ALTER TABLE [dbo].[tbSoftware]  WITH CHECK ADD  CONSTRAINT [FK_tbSoftware_tbCategory] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[tbCategory] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbSoftware] CHECK CONSTRAINT [FK_tbSoftware_tbCategory]
GO
ALTER TABLE [dbo].[tbSoftware]  WITH CHECK ADD  CONSTRAINT [FK_tbSoftware_tbSoftwaraStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[tbSoftwaraStatus] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbSoftware] CHECK CONSTRAINT [FK_tbSoftware_tbSoftwaraStatus]
GO
ALTER TABLE [dbo].[tbSoftware]  WITH CHECK ADD  CONSTRAINT [FK_tbSoftware_tbUser] FOREIGN KEY([UpBy])
REFERENCES [dbo].[tbUser] ([UserName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbSoftware] CHECK CONSTRAINT [FK_tbSoftware_tbUser]
GO
ALTER TABLE [dbo].[tbTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tbTransaction_tbInvoke] FOREIGN KEY([InvokeId])
REFERENCES [dbo].[tbInvoke] ([Id])
GO
ALTER TABLE [dbo].[tbTransaction] CHECK CONSTRAINT [FK_tbTransaction_tbInvoke]
GO
ALTER TABLE [dbo].[tbTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tbTransaction_tbTypeTransaction] FOREIGN KEY([Type])
REFERENCES [dbo].[tbTypeTransaction] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbTransaction] CHECK CONSTRAINT [FK_tbTransaction_tbTypeTransaction]
GO
ALTER TABLE [dbo].[tbTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tbTransaction_tbUser] FOREIGN KEY([Source])
REFERENCES [dbo].[tbUser] ([UserName])
GO
ALTER TABLE [dbo].[tbTransaction] CHECK CONSTRAINT [FK_tbTransaction_tbUser]
GO
ALTER TABLE [dbo].[tbTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tbTransaction_tbUser1] FOREIGN KEY([Destination])
REFERENCES [dbo].[tbUser] ([UserName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbTransaction] CHECK CONSTRAINT [FK_tbTransaction_tbUser1]
GO
ALTER TABLE [dbo].[tbUser]  WITH CHECK ADD  CONSTRAINT [FK_tbUser_tbTypeUser] FOREIGN KEY([TypeUser])
REFERENCES [dbo].[tbTypeUser] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbUser] CHECK CONSTRAINT [FK_tbUser_tbTypeUser]
GO
USE [master]
GO
ALTER DATABASE [MNSHOP] SET  READ_WRITE 
GO
