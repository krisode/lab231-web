USE [master]
GO
/****** Object:  Database [Lab3]    Script Date: 7/19/2020 12:02:20 AM ******/
CREATE DATABASE [Lab3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Lab3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.HUYSQL\MSSQL\DATA\Lab3.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Lab3_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.HUYSQL\MSSQL\DATA\Lab3_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Lab3] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Lab3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Lab3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Lab3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Lab3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Lab3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Lab3] SET ARITHABORT OFF 
GO
ALTER DATABASE [Lab3] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Lab3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Lab3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Lab3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Lab3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Lab3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Lab3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Lab3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Lab3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Lab3] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Lab3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Lab3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Lab3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Lab3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Lab3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Lab3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Lab3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Lab3] SET RECOVERY FULL 
GO
ALTER DATABASE [Lab3] SET  MULTI_USER 
GO
ALTER DATABASE [Lab3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Lab3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Lab3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Lab3] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Lab3] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Lab3', N'ON'
GO
ALTER DATABASE [Lab3] SET QUERY_STORE = OFF
GO
USE [Lab3]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 7/19/2020 12:02:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[BookingID] [int] IDENTITY(1,1) NOT NULL,
	[BookingDate] [date] NOT NULL,
	[StatusID] [int] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK__Booking__73951ACDD8507B79] PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookingDetail]    Script Date: 7/19/2020 12:02:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingDetail](
	[BookingDetailID] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [int] NOT NULL,
	[UsingDate] [date] NULL,
	[ReturnDate] [date] NULL,
	[ResourceID] [int] NOT NULL,
	[ResourceName] [nvarchar](200) NULL,
	[BookingID] [int] NOT NULL,
 CONSTRAINT [PK__BookingD__8136D47AD84A38C1] PRIMARY KEY CLUSTERED 
(
	[BookingDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 7/19/2020 12:02:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK__Category__19093A2BCC0B2E89] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registration]    Script Date: 7/19/2020 12:02:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registration](
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NULL,
	[GoogleID] [varchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[CreateDate] [date] NULL,
	[Fullname] [nvarchar](50) NOT NULL,
	[StatusID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	[Code] [varchar](50) NULL,
 CONSTRAINT [PK__Registra__536C85E57FCE4752] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resource]    Script Date: 7/19/2020 12:02:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resource](
	[ResourceID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](500) NOT NULL,
	[Color] [varchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Image] [varchar](200) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK__Resource__4ED1814F61B8469C] PRIMARY KEY CLUSTERED 
(
	[ResourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 7/19/2020 12:02:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Role__8AFACE3AB08A14CE] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 7/19/2020 12:02:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Status__C8EE20434DBBB433] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Booking] ON 

INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (1, CAST(N'2020-07-03' AS Date), 4, N'anonymousetudiante@gmail.com', N'Dang Huy')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (4, CAST(N'2020-07-03' AS Date), 5, N'anonymousetudiante@gmail.com', N'Dang Huy')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (5, CAST(N'2020-07-03' AS Date), 2, N'anonymousetudiante@gmail.com', N'Dang Huy')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (6, CAST(N'2020-07-03' AS Date), 5, N'anonymousetudiante@gmail.com', N'Dang Huy')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (10, CAST(N'2020-07-05' AS Date), 4, N'anonymousetudiante@gmail.com', N'Dang Huy')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (12, CAST(N'2020-07-05' AS Date), 2, N'anonymousetudiante@gmail.com', N'Dang Huy')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (13, CAST(N'2020-07-05' AS Date), 5, N'anonymousetudiante@gmail.com', N'Dang Huy')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (14, CAST(N'2020-07-05' AS Date), 2, N'anonymousetudiante@gmail.com', N'Dang Huy')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (15, CAST(N'2020-07-05' AS Date), 5, N'leeminhha2506@gmail.com', N'Le Minh Ha')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (16, CAST(N'2020-07-05' AS Date), 5, N'trantrinhdanghuy1406@gmail.com', N'Ðăng Huy Trần Trịnh')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (17, CAST(N'2020-07-05' AS Date), 4, N'trantrinhdanghuy1406@gmail.com', N'Ðăng Huy Trần Trịnh')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (19, CAST(N'2020-07-06' AS Date), 2, N'trantrinhdanghuy1406@gmail.com', N'Ðăng Huy Trần Trịnh')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (20, CAST(N'2020-07-06' AS Date), 4, N'anonymousetudiante@gmail.com', N'Dang Huy')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (21, CAST(N'2020-07-06' AS Date), 4, N'anonymousetudiante@gmail.com', N'Dang Huy')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (22, CAST(N'2020-07-11' AS Date), 5, N'leminhha2506@icloud.com', N'Alice')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (23, CAST(N'2020-07-11' AS Date), 5, N'leminhha2506@icloud.com', N'Alice')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (24, CAST(N'2020-07-14' AS Date), 5, N'anonymousetudiante@gmail.com', N'Dang Huy')
INSERT [dbo].[Booking] ([BookingID], [BookingDate], [StatusID], [Username], [Name]) VALUES (25, CAST(N'2020-07-14' AS Date), 5, N'anonymousetudiante@gmail.com', N'Dang Huy')
SET IDENTITY_INSERT [dbo].[Booking] OFF
SET IDENTITY_INSERT [dbo].[BookingDetail] ON 

INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (1, 3, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-04' AS Date), 2, N'Dining table', 1)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (3, 2, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-04' AS Date), 3, N'Wayfair', 1)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (4, 2, CAST(N'2020-07-01' AS Date), CAST(N'2020-07-04' AS Date), 4, N'ASUS TUF Gaming', 1)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (5, 1, CAST(N'2020-07-16' AS Date), CAST(N'2020-07-24' AS Date), 2, N'Dining table', 4)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (6, 1, CAST(N'2020-07-16' AS Date), CAST(N'2020-07-30' AS Date), 3, N'Wayfair', 4)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (7, 1, CAST(N'2020-07-16' AS Date), CAST(N'2020-07-18' AS Date), 6, N'Solid Wood Table', 4)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (8, 1, CAST(N'2020-07-30' AS Date), CAST(N'2020-08-01' AS Date), 3, N'Wayfair', 5)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (9, 1, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-23' AS Date), 3, N'Wayfair', 6)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (10, 1, CAST(N'2020-07-23' AS Date), CAST(N'2020-07-24' AS Date), 3, N'Wayfair', 10)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (12, 2, CAST(N'2020-07-23' AS Date), CAST(N'2020-07-30' AS Date), 3, N'Wayfair', 12)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (13, 1, CAST(N'2020-07-23' AS Date), CAST(N'2020-07-30' AS Date), 3, N'Wayfair', 13)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (14, 1, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-23' AS Date), 2, N'Dining table', 14)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (15, 1, CAST(N'2020-07-17' AS Date), CAST(N'2020-07-23' AS Date), 1, N'Villa Gallici', 15)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (16, 1, CAST(N'2020-07-22' AS Date), CAST(N'2020-07-30' AS Date), 2, N'Dining table', 16)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (17, 1, CAST(N'2020-08-05' AS Date), CAST(N'2020-08-12' AS Date), 3, N'Wayfair', 16)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (18, 1, CAST(N'2020-07-22' AS Date), CAST(N'2020-07-30' AS Date), 6, N'Solid Wood Table', 16)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (19, 1, CAST(N'2020-07-04' AS Date), CAST(N'2020-07-23' AS Date), 3, N'Wayfair', 17)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (20, 1, CAST(N'2020-07-06' AS Date), CAST(N'2020-07-29' AS Date), 6, N'Solid Wood Table', 19)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (21, 1, CAST(N'2020-09-24' AS Date), CAST(N'2020-09-30' AS Date), 3, N'Wayfair', 20)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (22, 1, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-30' AS Date), 2, N'Dining table', 21)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (23, 1, CAST(N'2020-07-10' AS Date), CAST(N'2020-07-16' AS Date), 6, N'Solid Wood Table', 21)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (24, 1, CAST(N'2020-07-13' AS Date), CAST(N'2020-07-18' AS Date), 9, N'ACER Predator Triton', 22)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (25, 1, CAST(N'2020-07-19' AS Date), CAST(N'2020-07-25' AS Date), 2, N'Dining table', 23)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (26, 1, CAST(N'2020-07-15' AS Date), CAST(N'2020-07-18' AS Date), 11, N'Stefan Chair', 24)
INSERT [dbo].[BookingDetail] ([BookingDetailID], [Amount], [UsingDate], [ReturnDate], [ResourceID], [ResourceName], [BookingID]) VALUES (27, 1, CAST(N'2020-07-24' AS Date), CAST(N'2020-07-30' AS Date), 11, N'Stefan Chair', 25)
SET IDENTITY_INSERT [dbo].[BookingDetail] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [Name], [RoleID]) VALUES (1, N'Chair', 3)
INSERT [dbo].[Category] ([CategoryID], [Name], [RoleID]) VALUES (2, N'Table', 3)
INSERT [dbo].[Category] ([CategoryID], [Name], [RoleID]) VALUES (3, N'Room', 2)
INSERT [dbo].[Category] ([CategoryID], [Name], [RoleID]) VALUES (4, N'Laptop', 3)
SET IDENTITY_INSERT [dbo].[Category] OFF
INSERT [dbo].[Registration] ([Username], [Password], [GoogleID], [Address], [Phone], [CreateDate], [Fullname], [StatusID], [RoleID], [Code]) VALUES (N'anonymousetudiante@gmail.com', N'123', NULL, N'Vietnam', N'0948974979', CAST(N'2020-07-01' AS Date), N'Dang Huy', 1, 3, N'399010')
INSERT [dbo].[Registration] ([Username], [Password], [GoogleID], [Address], [Phone], [CreateDate], [Fullname], [StatusID], [RoleID], [Code]) VALUES (N'huyttdse140080@fpt.edu.vn', N'123', NULL, N'Vietnam', N'0123456789', CAST(N'2020-07-01' AS Date), N'Tran Trinh Dang Huy', 1, 1, N'456792')
INSERT [dbo].[Registration] ([Username], [Password], [GoogleID], [Address], [Phone], [CreateDate], [Fullname], [StatusID], [RoleID], [Code]) VALUES (N'leeminhha2506@gmail.com', N'123', NULL, N'Vietnam', N'0566491629', CAST(N'2020-07-02' AS Date), N'Le Minh Ha', 1, 2, N'154889')
INSERT [dbo].[Registration] ([Username], [Password], [GoogleID], [Address], [Phone], [CreateDate], [Fullname], [StatusID], [RoleID], [Code]) VALUES (N'leminhha2506@icloud.com', N'Minhha256', NULL, N'Viet Nam', N'0566491629', CAST(N'2020-07-11' AS Date), N'Alice', 1, 3, N'260378')
INSERT [dbo].[Registration] ([Username], [Password], [GoogleID], [Address], [Phone], [CreateDate], [Fullname], [StatusID], [RoleID], [Code]) VALUES (N'trantrinhdanghuy1406@gmail.com', NULL, N'100776077273525689529', NULL, NULL, CAST(N'2020-07-01' AS Date), N'Ðăng Huy Trần Trịnh', 1, 3, NULL)
INSERT [dbo].[Registration] ([Username], [Password], [GoogleID], [Address], [Phone], [CreateDate], [Fullname], [StatusID], [RoleID], [Code]) VALUES (N'votantai4899@gmail.com', N'123', NULL, N'Italy', N'0322300922', CAST(N'2020-07-01' AS Date), N'Vo Tan Tai', 2, 1, N'178953')
SET IDENTITY_INSERT [dbo].[Resource] ON 

INSERT [dbo].[Resource] ([ResourceID], [Name], [Description], [Color], [Quantity], [Image], [CategoryID], [StatusID], [RoleID]) VALUES (1, N'Villa Gallici', N'The rooms in Ca'' Pisani hotel have been realised completely using original pieces of design and are taken care of down to the last detail.
Refined style, play of colours and precious materials make the hotel a real jewel of contemporary design. The presence of marbles, precious fabrics and inlaid wood furniture has been designed to guarantee guests maximum comfort and relaxation.', N'Green', 1, N'images/room-2.jpg', 3, 1, 2)
INSERT [dbo].[Resource] ([ResourceID], [Name], [Description], [Color], [Quantity], [Image], [CategoryID], [StatusID], [RoleID]) VALUES (2, N'Dining table', N'A table is an arrangement of data in rows and columns, or possibly in a more complex structure. Tables are widely used in communication, research, and data analysis. Tables appear in print media, handwritten notes, computer software, architectural ornamentation, traffic signs, and many other places.', N'Brown', 20, N'images/restaurant-4.jpg', 2, 1, 3)
INSERT [dbo].[Resource] ([ResourceID], [Name], [Description], [Color], [Quantity], [Image], [CategoryID], [StatusID], [RoleID]) VALUES (3, N'Wayfair', N'A chair is a piece of furniture. It is used for sitting on and it can also be used for standing on, if you can''t reach something. They usually have four legs to support the weight. Some types of chairs, such as the bar-stool, have only one leg in the center.', N'Pink', 15, N'images/signup-image.jpg', 1, 1, 3)
INSERT [dbo].[Resource] ([ResourceID], [Name], [Description], [Color], [Quantity], [Image], [CategoryID], [StatusID], [RoleID]) VALUES (4, N'ASUS TUF Gaming', N'A laptop (also laptop computer), often called a notebook, is a small, portable personal computer (PC) with a "clamshell" form factor, typically having a thin LCD or LED computer screen mounted on the inside of the upper lid of the clamshell and an alphanumeric keyboard on the inside of the lower lid', N'Black', 12, N'images/asus_tuf_gaming_fx504ge-en047t__1__grande.png', 4, 1, 3)
INSERT [dbo].[Resource] ([ResourceID], [Name], [Description], [Color], [Quantity], [Image], [CategoryID], [StatusID], [RoleID]) VALUES (6, N'Solid Wood Table', N'D?R ??is an executive desk designed by the architect Claudio Bellini??. Frezza''s DR table is the result of a deep passion for artisan? ?traditions and refined materials, like wood. The elegance of the DR desk is characterized by a? solid wood structure, whos lines, curves and thicknesses capture the best details of historic design culture??, always maintaining a modern style.', N'Brown', 10, N'images/wooden-table.jpg', 2, 1, 3)
INSERT [dbo].[Resource] ([ResourceID], [Name], [Description], [Color], [Quantity], [Image], [CategoryID], [StatusID], [RoleID]) VALUES (9, N'ACER Predator Triton', N'A laptop computer is a portable personal computer powered by a battery, or an AC cord plugged into an electrical outlet, which is also used to charge the battery. Laptops have an attached keyboard and a touchpad, trackball, or isometric joystick used for navigation.', N'Black', 2, N'images/acer_predator_triton_900_3dedec60b3664ac49b0358eca855d381_large.jpg', 4, 1, 3)
INSERT [dbo].[Resource] ([ResourceID], [Name], [Description], [Color], [Quantity], [Image], [CategoryID], [StatusID], [RoleID]) VALUES (10, N'La Maison d''Aix', N'La Maison is the perfect introducton to Aix-en-Provence. Perfectly located just a couple blocks from the historic city center filled with great shopping, restaurants and cafés. The hotel is very charming and personal. Don''t expect your typical hotel, expect instead a very home experience stay. It''s very historic and comfortable and you''ll feel like a local staying there. It has an underground spa which is quirte cozy and romantic. Fresh flowers are everywere', N'White', 2, N'images/room-4.jpg', 3, 1, 2)
INSERT [dbo].[Resource] ([ResourceID], [Name], [Description], [Color], [Quantity], [Image], [CategoryID], [StatusID], [RoleID]) VALUES (11, N'Stefan Chair', N'A sturdy chair with a solid wood construction that can handle the challenges of everyday life! Combines nicely with most styles, and if you’re looking for extra comfort, simply add a chair pad.', N'Black', 18, N'images/chair-2.jpg', 1, 1, 3)
SET IDENTITY_INSERT [dbo].[Resource] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [Name]) VALUES (1, N'manager')
INSERT [dbo].[Role] ([RoleID], [Name]) VALUES (2, N'leader')
INSERT [dbo].[Role] ([RoleID], [Name]) VALUES (3, N'employee')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([StatusID], [Name]) VALUES (1, N'active')
INSERT [dbo].[Status] ([StatusID], [Name]) VALUES (2, N'deactive')
INSERT [dbo].[Status] ([StatusID], [Name]) VALUES (3, N'new')
INSERT [dbo].[Status] ([StatusID], [Name]) VALUES (4, N'delete')
INSERT [dbo].[Status] ([StatusID], [Name]) VALUES (5, N'accept')
SET IDENTITY_INSERT [dbo].[Status] OFF
ALTER TABLE [dbo].[Booking] ADD  CONSTRAINT [DF_Booking_BookingDate]  DEFAULT (getdate()) FOR [BookingDate]
GO
ALTER TABLE [dbo].[Registration] ADD  CONSTRAINT [DF_Registration_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK__Booking__StatusI__45F365D3] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK__Booking__StatusI__45F365D3]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK__Booking__Usernam__46E78A0C] FOREIGN KEY([Username])
REFERENCES [dbo].[Registration] ([Username])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK__Booking__Usernam__46E78A0C]
GO
ALTER TABLE [dbo].[BookingDetail]  WITH CHECK ADD  CONSTRAINT [FK__BookingDe__Booki__4AB81AF0] FOREIGN KEY([BookingID])
REFERENCES [dbo].[Booking] ([BookingID])
GO
ALTER TABLE [dbo].[BookingDetail] CHECK CONSTRAINT [FK__BookingDe__Booki__4AB81AF0]
GO
ALTER TABLE [dbo].[BookingDetail]  WITH CHECK ADD  CONSTRAINT [FK__BookingDe__Resou__49C3F6B7] FOREIGN KEY([ResourceID])
REFERENCES [dbo].[Resource] ([ResourceID])
GO
ALTER TABLE [dbo].[BookingDetail] CHECK CONSTRAINT [FK__BookingDe__Resou__49C3F6B7]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Role]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK__Registrat__RoleI__3E52440B] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK__Registrat__RoleI__3E52440B]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK__Registrat__Statu__3D5E1FD2] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK__Registrat__Statu__3D5E1FD2]
GO
ALTER TABLE [dbo].[Resource]  WITH CHECK ADD  CONSTRAINT [FK__Resource__Catego__412EB0B6] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Resource] CHECK CONSTRAINT [FK__Resource__Catego__412EB0B6]
GO
ALTER TABLE [dbo].[Resource]  WITH CHECK ADD  CONSTRAINT [FK__Resource__RoleID__4316F928] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[Resource] CHECK CONSTRAINT [FK__Resource__RoleID__4316F928]
GO
ALTER TABLE [dbo].[Resource]  WITH CHECK ADD  CONSTRAINT [FK__Resource__Status__4222D4EF] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[Resource] CHECK CONSTRAINT [FK__Resource__Status__4222D4EF]
GO
USE [master]
GO
ALTER DATABASE [Lab3] SET  READ_WRITE 
GO
