USE [master]
GO
/****** Object:  Database [Lab2]    Script Date: 6/21/2020 10:45:21 PM ******/
CREATE DATABASE [Lab2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Lab2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.HUYSQL\MSSQL\DATA\Lab2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Lab2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.HUYSQL\MSSQL\DATA\Lab2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Lab2] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Lab2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Lab2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Lab2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Lab2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Lab2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Lab2] SET ARITHABORT OFF 
GO
ALTER DATABASE [Lab2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Lab2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Lab2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Lab2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Lab2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Lab2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Lab2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Lab2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Lab2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Lab2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Lab2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Lab2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Lab2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Lab2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Lab2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Lab2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Lab2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Lab2] SET RECOVERY FULL 
GO
ALTER DATABASE [Lab2] SET  MULTI_USER 
GO
ALTER DATABASE [Lab2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Lab2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Lab2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Lab2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Lab2] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Lab2', N'ON'
GO
ALTER DATABASE [Lab2] SET QUERY_STORE = OFF
GO
USE [Lab2]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 6/21/2020 10:45:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[BookingID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [date] NOT NULL,
	[Total] [float] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[DiscountID] [varchar](50) NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK__Booking__73951ACD3CC899CE] PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookingDetails]    Script Date: 6/21/2020 10:45:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingDetails](
	[BookingDetailID] [int] IDENTITY(1,1) NOT NULL,
	[FromDate] [date] NULL,
	[ToDate] [date] NULL,
	[Amount] [int] NOT NULL,
	[TourID] [int] NOT NULL,
	[BookingID] [int] NOT NULL,
 CONSTRAINT [PK__BookingD__8136D47A8A935E3D] PRIMARY KEY CLUSTERED 
(
	[BookingDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 6/21/2020 10:45:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[DiscountID] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Percent] [float] NOT NULL,
	[ExpiredDate] [date] NOT NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registration]    Script Date: 6/21/2020 10:45:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registration](
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NULL,
	[FacebookID] [varchar](50) NULL,
	[Fullname] [varchar](50) NOT NULL,
	[RoleID] [int] NOT NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK__Registra__536C85E563B7F17F] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 6/21/2020 10:45:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Role__8AFACE3AC7A346A9] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 6/21/2020 10:45:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Status__C8EE2043F77F0EC3] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tour]    Script Date: 6/21/2020 10:45:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tour](
	[TourID] [int] IDENTITY(1,1) NOT NULL,
	[TourName] [varchar](100) NOT NULL,
	[FromDate] [date] NOT NULL,
	[ToDate] [date] NOT NULL,
	[Price] [float] NOT NULL,
	[Quota] [int] NOT NULL,
	[Image] [varchar](200) NOT NULL,
	[DateImport] [date] NOT NULL,
	[Place] [varchar](50) NOT NULL,
	[StatusID] [int] NOT NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK__Tour__604CEA102A955F5C] PRIMARY KEY CLUSTERED 
(
	[TourID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Booking] ON 

INSERT [dbo].[Booking] ([BookingID], [OrderDate], [Total], [Username], [DiscountID], [Status]) VALUES (14, CAST(N'2020-06-16' AS Date), 24650, N'user', NULL, 4)
INSERT [dbo].[Booking] ([BookingID], [OrderDate], [Total], [Username], [DiscountID], [Status]) VALUES (15, CAST(N'2020-06-16' AS Date), 11378, N'danghuy', NULL, 4)
INSERT [dbo].[Booking] ([BookingID], [OrderDate], [Total], [Username], [DiscountID], [Status]) VALUES (18, CAST(N'2020-06-17' AS Date), 1000, N'user', NULL, 4)
INSERT [dbo].[Booking] ([BookingID], [OrderDate], [Total], [Username], [DiscountID], [Status]) VALUES (19, CAST(N'2020-06-17' AS Date), 6000, N'user', NULL, 4)
INSERT [dbo].[Booking] ([BookingID], [OrderDate], [Total], [Username], [DiscountID], [Status]) VALUES (20, CAST(N'2020-06-20' AS Date), 8000, N'user', NULL, 4)
INSERT [dbo].[Booking] ([BookingID], [OrderDate], [Total], [Username], [DiscountID], [Status]) VALUES (21, CAST(N'2020-06-20' AS Date), 2500, N'user', N'PM3T0Z', 4)
INSERT [dbo].[Booking] ([BookingID], [OrderDate], [Total], [Username], [DiscountID], [Status]) VALUES (22, CAST(N'2020-06-20' AS Date), 2000, N'user', N'VRZ6ES', 4)
INSERT [dbo].[Booking] ([BookingID], [OrderDate], [Total], [Username], [DiscountID], [Status]) VALUES (23, CAST(N'2020-06-20' AS Date), 2500, N'danghuy', N'PM3T0Z', 4)
INSERT [dbo].[Booking] ([BookingID], [OrderDate], [Total], [Username], [DiscountID], [Status]) VALUES (24, CAST(N'2020-06-21' AS Date), 3000, N'user', N'DX838Y', 4)
SET IDENTITY_INSERT [dbo].[Booking] OFF
SET IDENTITY_INSERT [dbo].[BookingDetails] ON 

INSERT [dbo].[BookingDetails] ([BookingDetailID], [FromDate], [ToDate], [Amount], [TourID], [BookingID]) VALUES (3, CAST(N'2020-06-10' AS Date), CAST(N'2020-06-16' AS Date), 30, 2, 14)
INSERT [dbo].[BookingDetails] ([BookingDetailID], [FromDate], [ToDate], [Amount], [TourID], [BookingID]) VALUES (4, CAST(N'2020-06-16' AS Date), CAST(N'2020-06-20' AS Date), 4, 5, 14)
INSERT [dbo].[BookingDetails] ([BookingDetailID], [FromDate], [ToDate], [Amount], [TourID], [BookingID]) VALUES (5, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-17' AS Date), 10, 3, 15)
INSERT [dbo].[BookingDetails] ([BookingDetailID], [FromDate], [ToDate], [Amount], [TourID], [BookingID]) VALUES (6, CAST(N'2020-06-19' AS Date), CAST(N'2020-06-23' AS Date), 20, 10, 15)
INSERT [dbo].[BookingDetails] ([BookingDetailID], [FromDate], [ToDate], [Amount], [TourID], [BookingID]) VALUES (12, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-17' AS Date), 1, 3, 18)
INSERT [dbo].[BookingDetails] ([BookingDetailID], [FromDate], [ToDate], [Amount], [TourID], [BookingID]) VALUES (13, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-17' AS Date), 1, 3, 19)
INSERT [dbo].[BookingDetails] ([BookingDetailID], [FromDate], [ToDate], [Amount], [TourID], [BookingID]) VALUES (14, CAST(N'2020-06-16' AS Date), CAST(N'2020-06-20' AS Date), 1, 5, 19)
INSERT [dbo].[BookingDetails] ([BookingDetailID], [FromDate], [ToDate], [Amount], [TourID], [BookingID]) VALUES (15, CAST(N'2020-06-13' AS Date), CAST(N'2020-06-17' AS Date), 8, 3, 20)
INSERT [dbo].[BookingDetails] ([BookingDetailID], [FromDate], [ToDate], [Amount], [TourID], [BookingID]) VALUES (16, CAST(N'2020-06-16' AS Date), CAST(N'2020-06-20' AS Date), 1, 5, 21)
INSERT [dbo].[BookingDetails] ([BookingDetailID], [FromDate], [ToDate], [Amount], [TourID], [BookingID]) VALUES (17, CAST(N'2020-06-16' AS Date), CAST(N'2020-06-20' AS Date), 1, 5, 22)
INSERT [dbo].[BookingDetails] ([BookingDetailID], [FromDate], [ToDate], [Amount], [TourID], [BookingID]) VALUES (18, CAST(N'2020-06-16' AS Date), CAST(N'2020-06-20' AS Date), 1, 5, 23)
INSERT [dbo].[BookingDetails] ([BookingDetailID], [FromDate], [ToDate], [Amount], [TourID], [BookingID]) VALUES (19, CAST(N'2020-06-16' AS Date), CAST(N'2020-06-20' AS Date), 3, 5, 24)
SET IDENTITY_INSERT [dbo].[BookingDetails] OFF
INSERT [dbo].[Discount] ([DiscountID], [Name], [Percent], [ExpiredDate], [Status]) VALUES (N'DX838Y', N'Discount', 0.8, CAST(N'2020-06-26' AS Date), 1)
INSERT [dbo].[Discount] ([DiscountID], [Name], [Percent], [ExpiredDate], [Status]) VALUES (N'PM3T0Z', N'Discount Tour', 0.5, CAST(N'2020-06-23' AS Date), 1)
INSERT [dbo].[Discount] ([DiscountID], [Name], [Percent], [ExpiredDate], [Status]) VALUES (N'VRZ6ES', N'Discount Booking', 0.6, CAST(N'2020-06-25' AS Date), 1)
INSERT [dbo].[Registration] ([Username], [Password], [FacebookID], [Fullname], [RoleID], [Status]) VALUES (N'admin', N'admin', NULL, N'Tran Trinh Dang Huy', 1, 1)
INSERT [dbo].[Registration] ([Username], [Password], [FacebookID], [Fullname], [RoleID], [Status]) VALUES (N'danghuy', N'danghuy', NULL, N'Kris Tran', 2, 1)
INSERT [dbo].[Registration] ([Username], [Password], [FacebookID], [Fullname], [RoleID], [Status]) VALUES (N'duong', N'duong', NULL, N'Tran Duc Duong', 2, 2)
INSERT [dbo].[Registration] ([Username], [Password], [FacebookID], [Fullname], [RoleID], [Status]) VALUES (N'user', N'user', NULL, N'Le Minh Ha', 2, 1)
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [Name]) VALUES (1, N'admin')
INSERT [dbo].[Role] ([RoleID], [Name]) VALUES (2, N'user')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([StatusID], [StatusName]) VALUES (1, N'active')
INSERT [dbo].[Status] ([StatusID], [StatusName]) VALUES (2, N'deActive')
INSERT [dbo].[Status] ([StatusID], [StatusName]) VALUES (3, N'purchased')
INSERT [dbo].[Status] ([StatusID], [StatusName]) VALUES (4, N'confirmed')
INSERT [dbo].[Status] ([StatusID], [StatusName]) VALUES (5, N'canceled')
SET IDENTITY_INSERT [dbo].[Status] OFF
SET IDENTITY_INSERT [dbo].[Tour] ON 

INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (2, N'Memorable Traveling', CAST(N'2020-06-10' AS Date), CAST(N'2020-06-16' AS Date), 1550, 30, N'images/destination-3.jpg', CAST(N'2020-06-11' AS Date), N'Los Angeles', 1, N'Far far away, behind the word mountains, far from the countries')
INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (3, N'Singapore City Tour', CAST(N'2020-06-13' AS Date), CAST(N'2020-06-17' AS Date), 1000, 20, N'images/destination-4.jpg', CAST(N'2020-06-11' AS Date), N'Singapore', 1, N'On this tour, take a half-day to orient yourself by seeing some of the city’s most popular attractions by bus. Get a nice introduction to the city and be better able to explore it on your own afterward. ')
INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (5, N'Lion City Bike Tour of Singapore', CAST(N'2020-06-16' AS Date), CAST(N'2020-06-20' AS Date), 5000, 40, N'images/destination-5.jpg', CAST(N'2020-06-16' AS Date), N'Singapore', 1, N'Get the perfect introduction to downtown Singapore and learn how the city fits together on this intimate guided bike tour, capped at just 10 travelers. Soak up the sights of Little India, Chinatown, Marina Bay, the Singapore River, and more as you pedal around 12 miles (20 kilometers) over the course of the morning. Besides a bike, helmet if required, and a raincoat, your tour includes Wi-Fi and cold drinks.')
INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (6, N'The London West Hollywood at Beverly Hills', CAST(N'2020-06-18' AS Date), CAST(N'2020-06-22' AS Date), 7025, 15, N'images/destination-6.jpg', CAST(N'2020-06-16' AS Date), N'London', 1, N'The London West Hollywood at Beverly Hills is an excellent choice for travelers visiting West Hollywood, offering a luxury environment alongside many helpful amenities designed to enhance your stay.')
INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (8, N'Hilton Paris Charles de Gaulle Airport', CAST(N'2020-06-20' AS Date), CAST(N'2020-06-24' AS Date), 6045, 20, N'images/hotel-2.jpg', CAST(N'2020-06-16' AS Date), N'Paris', 1, N'Ideally located steps away from Terminal 3 but also CDGVAL shuttle train station to TGV railway station or Terminal 1 and 2 (in 5 minutes), as well as next to RER high speed metro to downtown Paris (40 minutes) or Villepinte Exhibition Center (10 minutes), the hotel sets in a brightly lit atrium with a magnificent glass roof arching above the panoramic elevators.')
INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (10, N'Universal Studios Florida', CAST(N'2020-06-19' AS Date), CAST(N'2020-06-23' AS Date), 4689, 20, N'images/hotel-6.jpg', CAST(N'2020-06-16' AS Date), N'America', 1, N'Hang on tight. Your heroes are about to burst through the screen and yank you into the story. You’re the star here and you’ll disappear into one jaw-dropping adventure after another. Dodge evil villains. Defend the earth. Face a fire-breathing dragon. Wander into animated worlds where characters you love are suddenly right beside you. Go beyond the screen, behind the scenes and jump into the action of your favorite films at the world’s premier movie and TV based theme park.')
INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (11, N'Small-Group Tour: Jiufen, Yehliu Geopark, and Shifen from Taipei', CAST(N'2020-06-23' AS Date), CAST(N'2020-06-29' AS Date), 1235, 30, N'images/hotel-6.jpg', CAST(N'2020-06-20' AS Date), N'China', 1, N'Escape the city and see some of Taipei’s best natural and historical attractions during a small-group tour of Jiufen Village, Yehliu Geopark, and Shifen Waterfall. Included round-trip transfers mean that you won’t have to worry about car hire or navigating, while letting someone else drive gives you more time to enjoy the scenery.')
INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (12, N'Colosseum, Palatine Hill and Roman Forum Guided Tour', CAST(N'2020-06-24' AS Date), CAST(N'2020-06-29' AS Date), 2569, 15, N'images/hotel-4.jpg', CAST(N'2020-06-20' AS Date), N'Italy', 1, N'Discover the top landmarks of ancient Rome on a guided tour including skip-the-line access. Enter the Colosseum quickly with premium access tickets and explore the amphitheater with a guide to learn about its history. Hear stories about fierce gladiator battles and the architecture of the ancient structure. Complete the tour with a visit to Palatine Hill and the Roman Forum.')
INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (13, N'Full Day Dubai Shopping Tours', CAST(N'2020-06-24' AS Date), CAST(N'2020-06-29' AS Date), 8973, 10, N'images/restaurant-5.jpg', CAST(N'2020-06-20' AS Date), N'United Arab Emirates', 1, N'Home to more than 20 major malls and markets, Dubai is a top retail hotspot for fashion, gold, jewelry, and handicrafts. This private full-day tour lets you take advantage of the opportunities without lugging bags or using buses or cabs. Travel by private vehicle to your choice of shopping spots recommended by your driver-guide, and enjoy them while your transport waits. Pickup and drop-off anywhere you choose in Dubai adds extra ease.')
INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (16, N'Kobe Steak Restaurant Mouriya Lin', CAST(N'2020-06-25' AS Date), CAST(N'2020-06-30' AS Date), 4999, 20, N'images/restaurant-7.jpg', CAST(N'2020-06-20' AS Date), N'Japan', 1, N'In the Land of the Rising Sun, ancient temples sit alongside neon wonderlands and shinto shrines offer pockets of peace amid metropolises. Add tea ceremonies, snow monkeys, sushi, kimonos, and karaoke to the mix, and you have got one of the world''s most fascinating countries.')
INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (17, N'JW Marriott Hotel Seoul', CAST(N'2020-06-26' AS Date), CAST(N'2020-06-30' AS Date), 4723, 15, N'images/restaurant-2.jpg', CAST(N'2020-06-20' AS Date), N'Korea', 1, N'While only 60 years ago South Korea was considered a developing country, itâ??s now one of Asiaâ??s economic and cultural leaders. Super-chic Seoul combines modernism with ancient history; coastal Busan serves up rugged beach spots; and Jeju Island wows with volcanic landscapes and towering mountains.')
INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (18, N'Memorable trip', CAST(N'2020-06-25' AS Date), CAST(N'2020-07-31' AS Date), 3000, 1, N'images/image_3.jpg', CAST(N'2020-06-21' AS Date), N'Da Nang', 1, N'hihihihi')
INSERT [dbo].[Tour] ([TourID], [TourName], [FromDate], [ToDate], [Price], [Quota], [Image], [DateImport], [Place], [StatusID], [Description]) VALUES (25, N'The Strip', CAST(N'2020-06-30' AS Date), CAST(N'2020-07-09' AS Date), 12064, 25, N'images/bg_1.jpg', CAST(N'2020-06-21' AS Date), N'Las Vegas', 1, N'While the strip is just beginning to reopen, it was a great time visit as it was not so crowded, especially for a first-timer. The views and buildings here are amazing and there is so much to see. Worth a stroll or a few down to see as much as you can.')
SET IDENTITY_INSERT [dbo].[Tour] OFF
ALTER TABLE [dbo].[Booking] ADD  CONSTRAINT [DF_Booking_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Tour] ADD  CONSTRAINT [DF_Tour_DateImport]  DEFAULT (getdate()) FOR [DateImport]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK__Booking__Discoun__440B1D61] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[Discount] ([DiscountID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK__Booking__Discoun__440B1D61]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK__Booking__Usernam__4316F928] FOREIGN KEY([Username])
REFERENCES [dbo].[Registration] ([Username])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK__Booking__Usernam__4316F928]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Status]
GO
ALTER TABLE [dbo].[BookingDetails]  WITH CHECK ADD  CONSTRAINT [FK__BookingDe__Booki__47DBAE45] FOREIGN KEY([BookingID])
REFERENCES [dbo].[Booking] ([BookingID])
GO
ALTER TABLE [dbo].[BookingDetails] CHECK CONSTRAINT [FK__BookingDe__Booki__47DBAE45]
GO
ALTER TABLE [dbo].[BookingDetails]  WITH CHECK ADD  CONSTRAINT [FK__BookingDe__TourI__46E78A0C] FOREIGN KEY([TourID])
REFERENCES [dbo].[Tour] ([TourID])
GO
ALTER TABLE [dbo].[BookingDetails] CHECK CONSTRAINT [FK__BookingDe__TourI__46E78A0C]
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD  CONSTRAINT [FK_Discount_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[Discount] CHECK CONSTRAINT [FK_Discount_Status]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK__Registrat__RoleI__3D5E1FD2] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK__Registrat__RoleI__3D5E1FD2]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Status] FOREIGN KEY([Status])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Status]
GO
ALTER TABLE [dbo].[Tour]  WITH CHECK ADD  CONSTRAINT [FK__Tour__StatusID__403A8C7D] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([StatusID])
GO
ALTER TABLE [dbo].[Tour] CHECK CONSTRAINT [FK__Tour__StatusID__403A8C7D]
GO
USE [master]
GO
ALTER DATABASE [Lab2] SET  READ_WRITE 
GO
