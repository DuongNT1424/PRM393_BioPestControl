USE [master]
GO
/****** Object:  Database [BioPestControlDb]    Script Date: 5/11/2026 3:30:14 PM ******/
CREATE DATABASE [BioPestControlDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BioPestControlDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BioPestControlDb.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BioPestControlDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BioPestControlDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BioPestControlDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BioPestControlDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BioPestControlDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BioPestControlDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BioPestControlDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BioPestControlDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BioPestControlDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [BioPestControlDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BioPestControlDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BioPestControlDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BioPestControlDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BioPestControlDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BioPestControlDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BioPestControlDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BioPestControlDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BioPestControlDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BioPestControlDb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BioPestControlDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BioPestControlDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BioPestControlDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BioPestControlDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BioPestControlDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BioPestControlDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BioPestControlDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BioPestControlDb] SET RECOVERY FULL 
GO
ALTER DATABASE [BioPestControlDb] SET  MULTI_USER 
GO
ALTER DATABASE [BioPestControlDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BioPestControlDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BioPestControlDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BioPestControlDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BioPestControlDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BioPestControlDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BioPestControlDb', N'ON'
GO
ALTER DATABASE [BioPestControlDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [BioPestControlDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BioPestControlDb]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 5/11/2026 3:30:14 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Admins]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[PasswordHash] [nvarchar](200) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](20) NULL,
	[AvatarUrl] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Admins] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArticleImages]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticleImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [nvarchar](max) NOT NULL,
	[IsMain] [bit] NOT NULL,
	[ArticleId] [int] NOT NULL,
 CONSTRAINT [PK_ArticleImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Articles]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Summary] [nvarchar](500) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Type] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[LastUpdatedAt] [datetime2](7) NOT NULL,
	[CreatedByAdminId] [int] NULL,
	[ManagedByStaffId] [int] NULL,
 CONSTRAINT [PK_Articles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItems]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CartId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_CartItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Carts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[CreatedByAdminId] [int] NULL,
	[ManagedByStaffId] [int] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChemicalConflicts]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChemicalConflicts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ChemicalAId] [int] NOT NULL,
	[ChemicalBId] [int] NOT NULL,
	[ConflictType] [nvarchar](max) NOT NULL,
	[Details] [nvarchar](max) NULL,
 CONSTRAINT [PK_ChemicalConflicts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChemicalProfiles]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChemicalProfiles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CommonName] [nvarchar](200) NOT NULL,
	[CasNumber] [nvarchar](20) NULL,
	[SignalWord] [nvarchar](20) NULL,
	[HazardStatement] [nvarchar](1000) NULL,
	[PrecautionaryStatement] [nvarchar](1000) NULL,
	[FirstAidMeasures] [nvarchar](1000) NULL,
	[PrimaryHazardSymbol] [int] NULL,
	[IsBanned] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[CreatedByAdminId] [int] NULL,
	[ManagedByStaffId] [int] NULL,
 CONSTRAINT [PK_ChemicalProfiles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Crops]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Crops](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Crops] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[Phone] [nvarchar](20) NULL,
	[AvatarUrl] [nvarchar](500) NULL,
	[MembershipLevel] [nvarchar](50) NULL,
	[Address] [nvarchar](500) NULL,
	[DistrictId] [int] NULL,
	[Gender] [nvarchar](20) NULL,
	[PasswordHash] [nvarchar](200) NULL,
	[PasswordSalt] [nvarchar](200) NULL,
	[IsLocked] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[ResetToken] [nvarchar](10) NULL,
	[ResetTokenExpiry] [datetime2](7) NULL,
	[ManagedByStaffId] [int] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discounts]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[DiscountPercent] [float] NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ProductId] [int] NOT NULL,
	[CreatedByAdminId] [int] NULL,
 CONSTRAINT [PK_Discounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Districts]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Districts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ProvinceId] [int] NOT NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
 CONSTRAINT [PK_Districts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeedbackImages]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeedbackImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [nvarchar](max) NOT NULL,
	[FeedbackId] [int] NOT NULL,
 CONSTRAINT [PK_FeedbackImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeedbackReplies]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeedbackReplies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Reply] [nvarchar](1000) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[FeedbackId] [int] NOT NULL,
	[StaffId] [int] NOT NULL,
 CONSTRAINT [PK_FeedbackReplies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeedbackReviewTags]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeedbackReviewTags](
	[FeedbackId] [int] NOT NULL,
	[ReviewTagId] [int] NOT NULL,
 CONSTRAINT [PK_FeedbackReviewTags] PRIMARY KEY CLUSTERED 
(
	[FeedbackId] ASC,
	[ReviewTagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedbacks]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedbacks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Rating] [int] NOT NULL,
	[Comment] [nvarchar](1000) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
	[ProductId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
 CONSTRAINT [PK_Feedbacks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime2](7) NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[ShippingFee] [decimal](18, 2) NOT NULL,
	[FinalAmount] [decimal](18, 2) NOT NULL,
	[ReceiverName] [nvarchar](100) NOT NULL,
	[ReceiverPhone] [nvarchar](20) NOT NULL,
	[ShippingAddress] [nvarchar](500) NOT NULL,
	[Note] [nvarchar](500) NULL,
	[IsHazardousOrder] [bit] NOT NULL,
	[TrackingNumber] [nvarchar](50) NULL,
	[Status] [int] NOT NULL,
	[PaymentMethod] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ManagedByStaffId] [int] NULL,
	[IsRefunded] [bit] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TransactionId] [nvarchar](100) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[PaymentMethod] [int] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[CompletedAt] [datetime2](7) NULL,
	[OrderId] [int] NOT NULL,
 CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pests]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pests](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Pests] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductChemicals]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductChemicals](
	[ProductId] [int] NOT NULL,
	[ChemicalProfileId] [int] NOT NULL,
	[Concentration] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_ProductChemicals] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[ChemicalProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [nvarchar](500) NOT NULL,
	[ImageName] [nvarchar](200) NULL,
	[DisplayOrder] [int] NOT NULL,
	[IsMainImage] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[ProductId] [int] NOT NULL,
 CONSTRAINT [PK_ProductImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SKU] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](2000) NULL,
	[UsageInstructions] [nvarchar](max) NULL,
	[Formulation] [nvarchar](400) NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[ExpirationDays] [int] NULL,
	[ExpirationDate] [datetime2](7) NULL,
	[UsageTarget] [nvarchar](100) NULL,
	[ToxicityLevel] [int] NOT NULL,
	[PreHarvestInterval] [int] NOT NULL,
	[DoseRate] [decimal](18, 2) NULL,
	[SafetyInformation] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[CreatedByAdminId] [int] NULL,
	[ManagedByStaffId] [int] NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provinces]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provinces](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Code] [nvarchar](max) NULL,
 CONSTRAINT [PK_Provinces] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReviewTags]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewTags](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ReviewTags] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staffs]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staffs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[Phone] [nvarchar](20) NULL,
	[Role] [nvarchar](100) NULL,
	[AvatarUrl] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
	[PasswordHash] [nvarchar](200) NOT NULL,
	[CreatedByAdminId] [int] NULL,
 CONSTRAINT [PK_Staffs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsageInstructions]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsageInstructions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[CropId] [int] NOT NULL,
	[PestId] [int] NOT NULL,
	[DosageAmount] [decimal](18, 2) NOT NULL,
	[DosageUnit] [nvarchar](max) NOT NULL,
	[WaterLiters] [decimal](18, 2) NOT NULL,
	[AmountPerHectare] [decimal](18, 2) NULL,
 CONSTRAINT [PK_UsageInstructions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wards]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wards](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DistrictId] [int] NOT NULL,
 CONSTRAINT [PK_Wards] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WarehouseLogs]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WarehouseLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[QuantityChange] [int] NOT NULL,
	[Note] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[StaffId] [int] NULL,
	[AdminId] [int] NULL,
 CONSTRAINT [PK_WarehouseLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WarehouseProducts]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WarehouseProducts](
	[WarehouseId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_WarehouseProducts] PRIMARY KEY CLUSTERED 
(
	[WarehouseId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouses]    Script Date: 5/11/2026 3:30:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Location] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[CreatedByAdminId] [int] NULL,
	[ManagedByStaffId] [int] NULL,
 CONSTRAINT [PK_Warehouses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251225140355_InitialCreate', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251227095115_AddResetTokenToCustomer', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251227104438_AddFeedbackReplyAndPaymentEntities', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251227114559_AddRelationshipsBetweenAdminStaffCustomer', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251227122400_UpdateCategorySeedData', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251227132145_AddChemicalSchema', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251227132859_AddMissingColumnsToAdmins', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251227133540_AddAdminsTable', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251227171803_Add_RowVersion_To_Product', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251228041212_InsertProductData', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251228045624_InsertSecondProductData', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251228163620_UpdateFormulationLength', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251228163656_InsertProductDataBatch', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251228164355_InsertTwentyyProductData', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251229054959_InsertNProductData', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251230151919_AddProductBatch3', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251230152728_InsertFourthProductData', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251231015214_InsertProductData50', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251231020126_InsertProductData80', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251231020209_InsertProductData81', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251231020847_InsertProductData100', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251231021404_InsertProductData130', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251231022312_InsertProductData160', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251231023628_Insert160', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20251231024036_Insert160', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260106043922_SeedAdminData', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260106045856_RemoveAdminSeeding', N'8.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260125172134_AddIsRefundedToOrder', N'8.0.11')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260129184244_AddChemicalTable', N'8.0.11')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260130081045_updateDB', N'8.0.11')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260130090401_AddChemicalTableFix', N'8.0.11')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260202021939_updateDBbien', N'8.0.11')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260307074043_UpdateAdminStaffEmail2026', N'8.0.11')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260307074411_UpdateAdminStaffEmail_Gmail', N'8.0.11')
GO
SET IDENTITY_INSERT [dbo].[Admins] ON 

INSERT [dbo].[Admins] ([Id], [Email], [PasswordHash], [FirstName], [LastName], [Phone], [AvatarUrl], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (1, N'admin@gamil.com', N'$2a$11$mj6WTgzQe7uX3G2ByAf.1.5y5YC2c8W1yuKyQn3xf6GLotMLAP5CO', N'System', N'Admin', N'0123456789', NULL, CAST(N'2026-01-01T00:00:00.0000000' AS DateTime2), NULL, 0)
INSERT [dbo].[Admins] ([Id], [Email], [PasswordHash], [FirstName], [LastName], [Phone], [AvatarUrl], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (1001, N'hlcongbien2004@gmail.com', N'$2a$12$KOBi9t2aQmiqPbUd2VroteBM5dRcyvtWK2o/gEQSiqf4JY0iicfhm', N'Huỳnh', N'Biên', NULL, NULL, CAST(N'2025-01-06T00:00:00.0000000' AS DateTime2), NULL, 0)
SET IDENTITY_INSERT [dbo].[Admins] OFF
GO
SET IDENTITY_INSERT [dbo].[ArticleImages] ON 

INSERT [dbo].[ArticleImages] ([Id], [ImageUrl], [IsMain], [ArticleId]) VALUES (2, N'https://res.cloudinary.com/dnnz4ze3b/image/upload/v1772858389/%E1%BA%A3nh_1_tdmk14.jpg', 1, 3)
INSERT [dbo].[ArticleImages] ([Id], [ImageUrl], [IsMain], [ArticleId]) VALUES (3, N'https://res.cloudinary.com/dnnz4ze3b/image/upload/v1772859189/dan-y-thuyet-minh-ve-cay-lua-viet-nam-3-696x392_bzonrq.jpg', 1, 2)
INSERT [dbo].[ArticleImages] ([Id], [ImageUrl], [IsMain], [ArticleId]) VALUES (4, N'https://res.cloudinary.com/dnnz4ze3b/image/upload/v1772859401/banner-thuoc-bao-ve-thuc-vat_cwiymk.png', 1, 4)
INSERT [dbo].[ArticleImages] ([Id], [ImageUrl], [IsMain], [ArticleId]) VALUES (5, N'https://res.cloudinary.com/dnnz4ze3b/image/upload/v1772859400/bvtv-16911439765031236703362-33-0-426-628-crop-16911441258591667090911_ywdw7c.png', 1, 5)
SET IDENTITY_INSERT [dbo].[ArticleImages] OFF
GO
SET IDENTITY_INSERT [dbo].[Articles] ON 

INSERT [dbo].[Articles] ([Id], [Title], [Summary], [Content], [Type], [IsActive], [CreatedAt], [LastUpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (2, N'Quản lý thuốc bảo vệ thực vật và phân bón Lỗ hổng minh bạch, nỗi lo dài hạn', N'Lỗ hổng minh bạch, nỗi lo dài hạn', N'Một người dân hấp thụ khoảng 1,1 kg thuốc BVTV/năm
Tại Lễ khai mạc Triển lãm Quốc tế Công nghiệp Hóa chất lần thứ 20 (VINACHEM EXPO 2024) tổ chức ở TP.HCM, Thứ trưởng Bộ Nông nghiệp & Phát triển Nông thôn Hoàng Trung đã công bố con số khiến nhiều người không khỏi giật mình: mỗi năm Việt Nam tiêu thụ khoảng 100.000 tấn thuốc bảo vệ thực vật (BVTV), tức bình quân mỗi người dân đang hấp thụ gián tiếp khoảng 1,1 kg thuốc BVTV mỗi năm thông qua thực phẩm hoặc môi trường.

Hiện nay, Việt Nam đang cho phép sử dụng hơn 4.000 loại thuốc BVTV, cao gấp nhiều lần so với các nước trong khu vực. Cụ thể, Trung Quốc chỉ phê duyệt khoảng 630 loại, trong khi Thái Lan và Malaysia giới hạn ở mức 400-600 loại. Việc tồn tại một “rừng thuốc” như vậy không chỉ khiến nông dân hoang mang trong lựa chọn sản phẩm, mà còn tạo kẽ hở cho việc nhập lậu, hàng giả, pha trộn hoạt chất sai quy chuẩn.

Trong nỗ lực hướng tới một nền nông nghiệp xanh, sạch và bền vững, Việt Nam đang đối mặt với nghịch lý, lượng thuốc BVTV và phân bón nhập khẩu mỗi năm lên tới hàng triệu tấn, nhưng công tác quản lý, kiểm soát chất lượng lại thiếu minh bạch, rời rạc và phản ứng chậm.

Đáng nói hơn, trong khi danh mục được mở rộng liên tục, thì hoạt động kiểm nghiệm, hậu kiểm và công khai kết quả lại rất hạn chế. Từ năm 2020 đến tháng 7/2023, Việt Nam đã nhập khẩu hơn 122.000 tấn DAP Hàn Quốc, trị giá 74,4 triệu USD. Tuy nhiên, sau khi có phản ánh về dấu hiệu hàm lượng Cadimi vượt mức cho phép, năm 2023, Cục Trồng trọt và Bảo vệ thực vật đã tiến hành lấy mẫu kiểm tra tại một số lô hàng DAP tại Bà Rịa - Vũng Tàu, Đồng Nai và kho tập kết hàng tại Khu công nghiệp Biên hòa 1 song đơn vị này không công bố kết quả.

Cần xem xét lại quy trình quản lý, cấp phép
Dư luận và báo chí nhiều lần đặt câu hỏi về kết quả tái kiểm Cadimi, cũng như quy trình xử lý đối với lượng DAP đã được doanh nghiệp “tự thu hồi” và phần còn tồn lưu thông trên thị trường, nhưng đến nay, tất cả đều rơi vào im lặng. Không có bất kỳ thông báo nào từ cơ quan quản lý về kết quả phân tích, hướng xử lý hay mức độ an toàn của lô hàng bị nghi ngờ.

Câu hỏi đặt ra, nếu kiểm tra không phát hiện vi phạm, tại sao không công khai để trấn an người dân? Nếu có phát hiện dư lượng Cadimi vượt ngưỡng thì lý do gì khiến việc xử lý bị trì hoãn hoặc giấu kín? Trong khi người nông dân đang loay hoay tìm loại phân bón phù hợp, thì sự không minh bạch trong thông tin kiểm định khiến họ càng hoang mang, dễ bị dẫn dụ bởi quảng cáo sai lệch hoặc tiếp tục sử dụng sản phẩm không an toàn.

Tình trạng thiếu minh bạch trong quản lý chất lượng đầu vào nông nghiệp, từ thuốc BVTV đến phân bón – đang để lại nhiều hệ lụy. Một mặt, nó tạo ra lỗ hổng cho hàng giả, hàng kém chất lượng len lỏi vào sản xuất, gây tổn thất mùa vụ và ảnh hưởng đến an toàn thực phẩm. Mặt khác, nó còn làm xói mòn niềm tin vào hệ thống kiểm soát chất lượng nhà nước, vốn phải là tấm khiên bảo vệ người nông dân và người tiêu dùng.

Đã đến lúc, các cơ quan chức năng cần xem xét lại toàn bộ quy trình quản lý, từ cấp phép, hậu kiểm đến công khai dữ liệu đối với các loại thuốc và phân bón nông nghiệp. Danh mục thuốc BVTV cần được sàng lọc lại theo hướng rút gọn, tránh trùng lặp và loại bỏ những hoạt chất lạc hậu, chưa được quốc tế công nhận. Các kết quả kiểm nghiệm, nhất là với những sản phẩm bị nghi ngờ gây hại, phải được công bố kịp thời, chính xác và đầy đủ.

Một nền nông nghiệp bền vững không thể được xây dựng trên nền tảng thông tin mập mờ. Nếu không minh bạch từ gốc, từ chất lượng vật tư đầu vào thì những nỗ lực chuyển đổi sang canh tác hữu cơ, hướng tới một nền nông nghiệp xanh, sạch và bền vững sẽ mãi chỉ dừng lại ở khẩu hiệu.', 1, 1, CAST(N'2026-03-05T02:16:19.2833281' AS DateTime2), CAST(N'2026-03-07T04:53:28.3786189' AS DateTime2), NULL, NULL)
INSERT [dbo].[Articles] ([Id], [Title], [Summary], [Content], [Type], [IsActive], [CreatedAt], [LastUpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (3, N'CropLife Việt Nam thúc đẩy sử dụng thuốc BVTV sinh học, công nghệ phun thuốc bằng drone', N'CropLife Việt Nam thúc đẩy sử dụng thuốc BVTV sinh học, công nghệ phun thuốc bằng drone', N'Cục Trồng trọt và Bảo vệ thực vật (TT-BVTV), Hiệp hội CropLife Việt Nam ký kết hợp tác năm 2026 tiếp tục thúc đẩy sử dụng thuốc bảo vệ thực vật (BVTV) an toàn, hiệu quả và có trách nhiệm bảo vệ sức khỏe con người, môi trường và nâng cao chất lượng, năng lực cạnh tranh cho nông sản Việt Nam.
Thúc đẩy ứng dụng công nghệ phun thuốc BVTV bằng drone
Ngày 14.1, tại Hà Nội, Cục TT-BVTV và Hiệp hội CropLife Việt Nam ký hợp tác năm 2026, trong khuôn khổ Chương trình khung quản lý thuốc bảo vệ thực vật bền vững được Cục Trồng trọt và Bảo vệ thực vật, Hiệp hội CropLife châu Á ký kết trước đó, có hiệu lực 5 năm (2023 - 2028).
Cùng ngày, hai đơn vị và Sở Nông nghiệp và Môi trường Đồng Tháp ký phụ lục nội dung hợp tác năm thứ 5 - năm cuối cùng triển khai Chương trình hướng dẫn sử dụng thuốc BVTV an toàn, hiệu quả và có trách nhiệm tại Đồng Tháp.

Chương trình tiếp tục bám sát Khung quản lý thuốc BVTV bền vững giai đoạn 2023 - 2028, tập trung vào 4 định hướng: hỗ trợ rà soát, hoàn thiện chính sách và nâng cao năng lực quản lý thuốc BVTV; thúc đẩy ứng dụng các giải pháp BVTV tiên tiến, trong đó chú trọng vào thuốc BVTV sinh học thông qua việc tham gia Chương trình Khung quản lý thuốc BVTV sinh học tại khu vực ASEAN; hoàn thiện và vận hành các nền tảng đào tạo, tập huấn, đổi mới phương thức tiếp cận nhằm nâng cao hiệu quả sử dụng thuốc BVTV có trách nhiệm; tăng cường truyền thông chính sách và truyền thông mô hình, lan tỏa các kết quả hợp tác tới cộng đồng.

Năm 2025, Cục TT - BVTV và CropLife Việt Nam đã triển khai hiệu quả nhiều hoạt động trọng tâm: nâng cao năng lực chuyên môn cho cơ quan quản lý, đặc biệt trong lĩnh vực đánh giá rủi ro môi trường của thuốc BVTV và quản lý dư lượng thuốc BVTV (MRL), với sự hỗ trợ của các tổ chức và chuyên gia quốc tế nhằm hỗ trợ quá trình xây dựng và quản lý các quy định liên quan đến thuốc BVTV tại Việt Nam.
Hai bên thúc đẩy ứng dụng các giải pháp BVTV tiên tiến, bao gồm thuốc BVTV sinh học và công nghệ phun thuốc bằng thiết bị bay không người lái (drone); mở rộng đào tạo, tập huấn và thúc đẩy truyền thông về sử dụng thuốc BVTV an toàn, hiệu quả và có trách nhiệm thông qua các nền tảng trực tiếp, trực tuyến.

Tại Đồng Tháp, chương trình tiếp cận hơn 1.000 nông dân và 250 đại lý, xây dựng 2 mô hình sử dụng thuốc bền vững, cung cấp trang bị bảo hộ và thanh kiểm tra các cơ sở kinh doanh. Chương trình phối hợp với các đơn vị nghiên cứu để đánh giá tác động về thay đổi nhận thức và hành vi, tạo cơ sở khoa học cho việc tổng kết và nhân rộng mô hình trong thời gian tới.

Cũng theo đại diện Cục TT-BVTV, năm 2026 cũng là năm tổng kết chương trình, đánh dấu giai đoạn chuyển từ triển khai sang đúc kết và lan tỏa mô hình. Theo đó, chương trình được mở rộng về quy mô và phạm vi, với việc tăng số lượng nông dân và đại lý tham gia, mở rộng địa bàn triển khai theo địa giới hành chính mới; xây dựng các mô hình sử dụng thuốc BVTV bền vững gắn với ứng dụng công nghệ phun bằng thiết bị bay không người lái (drone).

Hai bên sẽ tổng kết tổng kết chương trình, rút ra những bài học kinh nghiệm, giải pháp đề xuất nhân rộng tại các địa phương trong những năm tới.

Lan tỏa mạnh mẽ thông điệp sử dụng thuốc BVTV có trách nhiệm
Ông Đặng Văn Bảo, Chủ tịch CropLife Việt Nam, khẳng định hợp tác giữa Cục TT-BVTV đã đi vào chiều sâu kỹ thuật, nâng cao năng lực quản lý dựa trên khoa học và đánh giá rủi ro, hỗ trợ quá trình rà soát và hoàn thiện khung pháp lý, thúc đẩy ứng dụng giải pháp BVTV tiên tiến, từ thuốc BVTV sinh học đến công nghệ phun bằng thiết bị bay không người lái.

CropLife Việt Nam đặc biệt đánh giá cao cách tiếp cận của Cục TT-BVTV trong kết nối chính sách với thực tiễn, thông qua các chương trình đào tạo, mô hình trình diễn và truyền thông thay đổi hành vi, giúp các quy định không chỉ "đúng" về mặt kỹ thuật mà còn khả thi và có tác động thực sự tới nông dân, đại lý.

"Chúng tôi tin rằng, sự hợp tác giữa Cục TT-BVTV và CropLife Việt Nam đóng góp tích cực vào các mục tiêu dài hạn của ngành nông nghiệp, từ bảo vệ sức khỏe con người và môi trường, đến nâng cao năng lực cạnh tranh và tính bền vững của nông sản Việt Nam trong bối cảnh hội nhập sâu rộng", ông Bảo nói.

Còn theo ông Trần Thanh Vũ, đồng Chủ tịch CropLife Việt Nam, chương trình tại Đồng Tháp từ thí điểm nay đã trở thành mô hình thực hành tốt trong đào tạo nông dân, đại lý, xây dựng mô hình trên cây trồng và thúc đẩy thay đổi hành vi sử dụng thuốc BVTV.', 1, 1, CAST(N'2026-03-07T04:40:21.2223593' AS DateTime2), CAST(N'2026-03-07T04:50:08.0684155' AS DateTime2), NULL, NULL)
INSERT [dbo].[Articles] ([Id], [Title], [Summary], [Content], [Type], [IsActive], [CreatedAt], [LastUpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (4, N'Thêm nhiều thuốc bảo vệ thực vật mới cho hoa quả, độ độc thấp', N'Danh mục thuốc bảo vệ thực vật được phép sử dụng tại Việt Nam vừa ban hành có thêm nhiều loại thuốc mới, có hiệu lực tốt, dạng thuốc tiên tiến, đặc biệt là các thuốc đăng ký sử dụng trên rau, quả, chè đều có thời gian cách ly ngắn, độ độc thấp.', N' trưởng Bộ Nông nghiệp và Phát triển nông thôn Hoàng Trung vừa ký ban hành thông tư số 09-2023 về danh mục thuốc bảo vệ thực vật được phép sử dụng tại Việt Nam và danh mục thuốc bảo vệ thực vật cấm sử dụng tại Việt Nam (gọi tắt thông tư 09-2023).

Danh mục thuốc bảo vệ thực vật được phép sử dụng tại Việt Nam năm 2023 bao gồm 1.820 hoạt chất với 4.537 tên thương phẩm (loại thuốc).

Trong đó nhóm thuốc trừ sâu chiếm nhiều nhất với 712 hoạt chất và 1.725 tên thương phẩm. Tiếp đến là thuốc trừ bệnh có 683 hoạt chất với 1.561 loại thuốc, thuốc trừ cỏ có 260 hoạt chất với 791 tên thương phẩm...

Thêm 79 hoạt chất thuốc bảo vệ thực vật được phép sử dụng tại Việt Nam
CropLife ''bắt tay'' Việt Nam giảm phụ thuộc thuốc bảo vệ thực vật độc hại
Công bố tiêu chuẩn phun thuốc bảo vệ thực vật bằng thiết bị bay không người lái
So với thông tư 19-2022, thông tư mới tăng thêm 69 hoạt chất và 163 loại thuốc được phép sử dụng tại Việt Nam, chủ yếu nằm trong nhóm thuốc trừ sâu, thuốc trừ bệnh và thuốc trừ cỏ.

Thông tư 09-2023 vẫn giữ nguyên 31 hoạt chất thuốc bảo vệ thực vật bị cấm sử dụng tại Việt Nam, bao gồm các hoạt chất: 2.4.5 T, Captan, Captafol, Methamidophos, Aldrin, Carbofuran, Chlordane, Methyl Parathion, Parathion Ethyl, BHC, Lindane...

Thông tư này thay thế thông tư số 19-2022 và có hiệu lực kể từ ngày 8-12-2023.
Ngày 27-10, thông tin với Tuổi Trẻ Online về điểm mới của thông tư 09-2023, Cục Bảo vệ thực vật cho biết danh mục thuốc bảo vệ thực vật được phép sử dụng tại Việt Nam năm 2023 được bổ sung thêm 12 hoạt chất mới, trong đó có 6 hoạt chất là thuốc sinh học, còn lại là các hoạt chất mới an toàn và hiệu quả.

Số thuốc bảo vệ thực vật sinh học được đăng ký vào danh mục là 26 loại thuốc, chiếm 10,79% trên tổng số thuốc đã được đăng ký vào danh mục.

Ngoài ra, các tổ chức, cá nhân đăng ký thuốc bảo vệ thực vật đã tự nguyện rút khỏi danh mục được phép sử dụng tại Việt Nam 15 loại thuốc.

"Danh mục thuốc bảo vệ thực vật được phép sử dụng tại Việt Nam năm 2023 bổ sung thêm một số loại thuốc phòng trừ các sinh vật gây hại trên một số cây trồng có giá trị xuất khẩu cao như bưởi, sầu riêng, thanh long…

Bên cạnh đó, danh mục này cũng bổ sung thêm nhiều loại thuốc có hiệu lực tốt, dạng thuốc tiên tiến như OD, EW, WG…, đặc biệt là các thuốc đăng ký sử dụng trên rau, quả, chè đều có thời gian cách ly ngắn, độ độc thấp" - Cục Bảo vệ thực vật cho hay.

Đối với danh mục thuốc cấm sử dụng tại Việt Nam, Cục Bảo vệ thực vật cho biết danh mục tuân thủ theo các công ước, nghị định thư mà Việt Nam là thành viên tham gia như Công ước Stockholm, Công ước Rotterdam, Công ước Basel….

Trong thời gian tới, Bộ Nông nghiệp và Phát triển nông thôn sẽ tiếp tục rà soát loại bỏ các thuốc bảo vệ thực vật có nguy cơ cao ảnh hưởng đến sức khỏe con người, vật nuôi, hệ sinh thái và môi trường ra khỏi danh mục được phép sử dụng tại Việt Nam.', 3, 1, CAST(N'2026-03-07T04:57:02.5572856' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL, NULL)
INSERT [dbo].[Articles] ([Id], [Title], [Summary], [Content], [Type], [IsActive], [CreatedAt], [LastUpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (5, N'Tác hại thuốc trừ sau đến sức khỏe con người và hệ sinh thái', N'Thuốc trừ sâu ảnh hưởng đến sức khỏe con người và hệ sinh thái ở châu Âu như thế nào?', N'Hệ thống sản xuất lương thực ở châu Âu phụ thuộc vào thuốc trừ sâu hóa học để duy trì năng suất cây trồng. Tuy nhiên, việc sử dụng thuốc trừ sâu tràn lan là nguồn gây ô nhiễm chính – làm ô nhiễm nước, đất và không khí, dẫn đến mất đa dạng sinh học và gây ra hiện tượng kháng thuốc ở sâu bệnh. Việc con người tiếp xúc với thuốc trừ sâu hóa học có liên quan đến các bệnh mãn tính như ung thư, bệnh tim mạch, hô hấp và thần kinh. Bản tóm tắt này tổng hợp những kiến ​​thức mới nhất về tác động của thuốc trừ sâu hóa học đến sức khỏe con người và môi trường, đồng thời trình bày các biện pháp thực hành tốt để giảm thiểu việc sử dụng và rủi ro của chúng trên khắp châu Âu.

Thông điệp chính
Sản xuất nông nghiệp ở châu Âu phụ thuộc vào lượng lớn thuốc trừ sâu hóa học để duy trì năng suất cây trồng. Từ năm 2011 đến năm 2020, doanh số bán thuốc trừ sâu tại EU-27 duy trì tương đối ổn định ở mức khoảng 350.000 tấn mỗi năm.

Năm 2020, một hoặc nhiều loại thuốc trừ sâu được phát hiện vượt quá ngưỡng đáng lo ngại tại 22% tổng số điểm giám sát ở các sông và hồ trên khắp châu Âu. 83% đất nông nghiệp được kiểm tra trong một nghiên cứu năm 2019 có chứa dư lượng thuốc trừ sâu.

Ô nhiễm thuốc trừ sâu là nguyên nhân chính gây mất đa dạng sinh học ở châu Âu. Nó dẫn đến sự suy giảm đáng kể số lượng côn trùng, đe dọa vai trò quan trọng của chúng trong sản xuất lương thực.

Một nghiên cứu giám sát sinh học quy mô lớn trên người được tiến hành từ năm 2014 đến năm 2021 tại năm quốc gia châu Âu cho thấy ít nhất hai loại thuốc trừ sâu có mặt trong cơ thể của 84% người tham gia khảo sát. Nồng độ thuốc trừ sâu luôn cao hơn ở trẻ em so với người lớn.

Việc đạt được các mục tiêu liên quan đến thuốc trừ sâu được đặt ra trong chiến lược "từ nông trại đến bàn ăn" sẽ đòi hỏi những nỗ lực bổ sung đáng kể. Chúng ta có thể giảm sự phụ thuộc vào thuốc trừ sâu hóa học để duy trì năng suất cây trồng và tổng lượng thuốc trừ sâu sử dụng bằng cách chuyển sang các mô hình nông nghiệp thay thế, chẳng hạn như nông nghiệp sinh thái.

Việc sử dụng thuốc trừ sâu ở châu Âu
Hệ thống sản xuất lương thực hiện đại dựa vào lượng lớn thuốc trừ sâu hóa học [Hộp 1] để đảm bảo sự ổn định và số lượng năng suất cây trồng, cũng như duy trì an ninh lương thực (EEA, 2017, 2019). Thuốc trừ sâu cũng được sử dụng trong các lĩnh vực phi nông nghiệp; ví dụ, trong lâm nghiệp, dọc theo đường bộ và đường sắt, và trong các khu vực đô thị như công viên công cộng, sân chơi hoặc vườn. Một số khu vực này, đặc biệt là không gian xanh đô thị, được công chúng sử dụng rộng rãi — đặc biệt là trẻ em và người già, những người có sức khỏe nhạy cảm hơn với thuốc trừ sâu. Rủi ro mà thuốc trừ sâu gây ra cho sức khỏe con người và hệ sinh thái không chỉ phụ thuộc vào các đặc tính vốn có của các thành phần của chúng (ví dụ: hoạt chất, chất phụ gia, chất bổ trợ), mà còn phụ thuộc vào cách sử dụng — bao gồm tần suất, khối lượng và phương pháp sử dụng, cũng như loại cây trồng và đất.

Hiện tại, dữ liệu về việc sử dụng thuốc trừ sâu chưa có sẵn ở cấp độ EU, nhưng việc thu thập dữ liệu này sẽ bắt buộc từ năm 2028 trở đi theo  Quy định về thống kê đầu vào và đầu ra nông nghiệp . Đồng thời, dữ liệu hài hòa hàng năm về doanh số bán thuốc trừ sâu trong EU đã được thu thập từ năm 2011. Tại EU-27,  doanh số bán thuốc trừ sâu  duy trì tương đối ổn định ở mức khoảng 350.000 tấn mỗi năm từ năm 2011 đến năm 2020 (xem Hình 1). Tại 11 quốc gia thành viên, doanh số bán hàng giảm trong giai đoạn này, với mức giảm mạnh nhất ở Cộng hòa Séc, Bồ Đào Nha và Đan Mạch. Trong khi Latvia và Áo chứng kiến ​​tốc độ tăng trưởng doanh số bán thuốc trừ sâu mạnh nhất , thì tổng mức tăng trưởng về khối lượng bán ra lớn nhất lại thuộc về Đức và Pháp. Hai quốc gia này, cùng với Tây Ban Nha và Ý, chiếm khối lượng bán ra cao nhất trong hầu hết các nhóm hoạt chất, và cũng là bốn nhà sản xuất nông nghiệp hàng đầu trong EU (Eurostat, 2022a).', 2, 1, CAST(N'2026-03-07T04:58:15.7658461' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Articles] OFF
GO
SET IDENTITY_INSERT [dbo].[CartItems] ON 

INSERT [dbo].[CartItems] ([Id], [CartId], [ProductId], [Quantity]) VALUES (13, 4, 20, 50)
SET IDENTITY_INSERT [dbo].[CartItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Carts] ON 

INSERT [dbo].[Carts] ([Id], [CustomerId], [UpdatedAt]) VALUES (3, 5, CAST(N'2026-03-18T23:37:49.4703303' AS DateTime2))
INSERT [dbo].[Carts] ([Id], [CustomerId], [UpdatedAt]) VALUES (4, 11, CAST(N'2026-03-23T07:25:12.7399443' AS DateTime2))
INSERT [dbo].[Carts] ([Id], [CustomerId], [UpdatedAt]) VALUES (5, 12, CAST(N'2026-03-23T07:59:36.3800089' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Carts] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [Description], [CreatedByAdminId], [ManagedByStaffId]) VALUES (1, N'Phân bón và hóa chất', N'', NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Description], [CreatedByAdminId], [ManagedByStaffId]) VALUES (2, N'Thuốc trừ bệnh', NULL, NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Description], [CreatedByAdminId], [ManagedByStaffId]) VALUES (3, N'Thuốc trừ cỏ', NULL, NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Description], [CreatedByAdminId], [ManagedByStaffId]) VALUES (4, N'Thuốc trừ sâu', NULL, NULL, NULL)
INSERT [dbo].[Categories] ([Id], [Name], [Description], [CreatedByAdminId], [ManagedByStaffId]) VALUES (34, N'Biên', N'Test2', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[ChemicalConflicts] ON 

INSERT [dbo].[ChemicalConflicts] ([Id], [ChemicalAId], [ChemicalBId], [ConflictType], [Details]) VALUES (1, 1, 17, N'Precipitation risk', N'Boron and Copper can precipitate, reducing effectiveness.')
INSERT [dbo].[ChemicalConflicts] ([Id], [ChemicalAId], [ChemicalBId], [ConflictType], [Details]) VALUES (2, 6, 17, N'Phytotoxicity risk', N'Organophosphate with Copper can increase leaf burn risk on sensitive crops.')
INSERT [dbo].[ChemicalConflicts] ([Id], [ChemicalAId], [ChemicalBId], [ConflictType], [Details]) VALUES (3, 5, 8, N'Toxicity stacking', N'Both are highly toxic; mixing increases operator and crop safety risks.')
INSERT [dbo].[ChemicalConflicts] ([Id], [ChemicalAId], [ChemicalBId], [ConflictType], [Details]) VALUES (4, 2, 19, N'pH instability', N'Mix can destabilize in alkaline conditions and reduce field performance.')
SET IDENTITY_INSERT [dbo].[ChemicalConflicts] OFF
GO
SET IDENTITY_INSERT [dbo].[ChemicalProfiles] ON 

INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (1, N'Boron (Bo)', N'7440-42-8', N'Cảnh báo', N'H360FD: Có thể gây tổn hại khả năng sinh sản.', N'P201: Nhận chỉ dẫn đặc biệt trước khi sử dụng. P280: Mang bảo hộ.', N'Nếu tiếp xúc: Rửa sạch với nhiều nước. Nếu nuốt phải: Gọi y tế.', 8, 0, CAST(N'2026-03-07T07:44:10.6387435' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (2, N'Zinc Sulfate (Kẽm)', N'7733-02-0', N'Nguy hiểm', N'H318: Gây tổn thương mắt nghiêm trọng. H410: Rất độc với sinh vật thủy sinh.', N'P273: Tránh thải ra môi trường. P280: Đeo kính bảo vệ mắt.', N'Nếu dính vào mắt: Rửa cẩn thận bằng nước trong vài phút.', 5, 0, CAST(N'2026-03-07T07:44:10.6387501' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (3, N'Ethephon', N'16672-87-0', N'Nguy hiểm', N'H311: Độc khi tiếp xúc với da. H314: Gây bỏng da nghiêm trọng.', N'P280: Mang găng tay/quần áo bảo hộ/kính bảo vệ mắt.', N'Nếu dính vào da: Cởi bỏ quần áo nhiễm bẩn. Rửa da bằng nước.', 5, 0, CAST(N'2026-03-07T07:44:10.6387504' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (4, N'Paclobutrazol', N'76738-62-0', N'Cảnh báo', N'H302: Có hại nếu nuốt phải. H319: Gây kích ứng mắt.', N'P264: Rửa tay kỹ sau khi xử lý.', N'Nếu nuốt phải: Gọi trung tâm chống độc. Súc miệng.', 7, 0, CAST(N'2026-03-07T07:44:10.6387506' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (5, N'Fipronil', N'120068-37-3', N'Nguy hiểm', N'H301: Độc nếu nuốt phải. H372: Tổn thương thần kinh trung ương.', N'P260: Không hít phải bụi/sương. P273: Tránh thải ra môi trường.', N'Nếu nuốt phải: Gọi ngay trung tâm y tế. KHÔNG gây nôn.', 6, 0, CAST(N'2026-03-07T07:44:10.6387507' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (6, N'Chlorpyrifos Methyl', N'5598-13-0', N'Cảnh báo', N'H400: Rất độc đối với sinh vật thủy sinh.', N'P273: Tránh thải ra môi trường.', N'Di chuyển nạn nhân đến nơi thoáng khí. Hô hấp nhân tạo nếu ngừng thở.', 9, 0, CAST(N'2026-03-07T07:44:10.6387509' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (7, N'Imidacloprid', N'138261-41-3', N'Cảnh báo', N'H302: Có hại nếu nuốt phải. H410: Rất độc với sinh vật thủy sinh.', N'P270: Không ăn uống khi sử dụng.', N'Nếu nuốt phải: Gọi bác sĩ. Rửa sạch da bằng xà phòng.', 7, 0, CAST(N'2026-03-07T07:44:10.6387510' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (8, N'Emamectin Benzoate', N'155569-91-8', N'Nguy hiểm', N'H301: Độc nếu nuốt phải. H315: Gây kích ứng da. H370: Tổn thương cơ quan.', N'P260: Không hít phải bụi. P280: Mang đồ bảo hộ.', N'Nếu tiếp xúc da: Rửa với nhiều nước. Nếu hít phải: Ra nơi thoáng khí.', 6, 0, CAST(N'2026-03-07T07:44:10.6387512' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (9, N'Cartap Hydrochloride', N'15263-53-3', N'Cảnh báo', N'H302: Có hại nếu nuốt phải. H410: Rất độc với sinh vật thủy sinh.', N'P273: Tránh thải ra môi trường.', N'Uống nhiều nước hoặc nước muối loãng để gây nôn. Đưa đi cấp cứu.', 7, 0, CAST(N'2026-03-07T07:44:10.6387513' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (10, N'Propargite', N'2312-35-8', N'Nguy hiểm', N'H315: Gây kích ứng da. H318: Tổn thương mắt. H351: Nghi ngờ ung thư.', N'P201: Nhận chỉ dẫn đặc biệt. P280: Mang bảo hộ mắt.', N'Rửa mắt ngay lập tức với nước sạch 15 phút. Không dùng thuốc nhỏ mắt.', 8, 0, CAST(N'2026-03-07T07:44:10.6387515' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (11, N'Tricyclazole', N'41814-78-2', N'Cảnh báo', N'H302: Có hại nếu nuốt phải.', N'P264: Rửa tay kỹ sau khi xử lý.', N'Kích thích gây nôn nếu nuốt lượng lớn. Gọi y tế.', 7, 0, CAST(N'2026-03-07T07:44:10.6387516' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (12, N'Mancozeb', N'8018-01-7', N'Cảnh báo', N'H317: Có thể gây dị ứng da. H361d: Nghi ngờ hại cho trẻ chưa sinh.', N'P280: Mang găng tay. P261: Tránh hít bụi thuốc.', N'Rửa sạch vùng da tiếp xúc bằng xà phòng.', 8, 0, CAST(N'2026-03-07T07:44:10.6387517' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (13, N'Hexaconazole', N'79983-71-4', N'Cảnh báo', N'H302: Có hại nếu nuốt phải. H411: Độc với thủy sinh.', N'P273: Tránh thải ra môi trường.', N'Súc miệng, uống than hoạt tính. Không gây nôn.', 7, 0, CAST(N'2026-03-07T07:44:10.6387519' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (14, N'Kasugamycin', N'6980-18-3', N'Thận trọng', N'Độc tính thấp. Không phân loại nguy hiểm theo GHS.', N'P102: Để xa tầm tay trẻ em.', N'Rửa sạch với nước nếu dính vào da hoặc mắt.', 10, 0, CAST(N'2026-03-07T07:44:10.6387520' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (15, N'Difenoconazole', N'119446-68-3', N'Cảnh báo', N'H302: Có hại nếu nuốt phải. H319: Gây kích ứng mắt.', N'P280: Mang kính bảo vệ mắt.', N'Rửa mắt ngay lập tức. Uống nhiều nước nếu nuốt phải.', 7, 0, CAST(N'2026-03-07T07:44:10.6387522' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (16, N'Bismerthiazol', N'85038-74-8', N'Cảnh báo', N'H319: Gây kích ứng mắt nghiêm trọng.', N'P264: Rửa tay sau khi sử dụng.', N'Rửa mắt với nước sạch. Đưa đến y tế nếu kích ứng kéo dài.', 7, 0, CAST(N'2026-03-07T07:44:10.6387523' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (17, N'Copper Hydroxide (Đồng)', N'20427-59-2', N'Nguy hiểm', N'H330: Chết người nếu hít phải. H318: Tổn thương mắt.', N'P260: Không hít bụi. P284: Mang thiết bị bảo vệ hô hấp.', N'Đưa nạn nhân ra nơi thoáng khí. Hô hấp nhân tạo nếu cần.', 6, 0, CAST(N'2026-03-07T07:44:10.6387525' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (18, N'Isoprothiolane', N'50512-35-1', N'Cảnh báo', N'H412: Có hại cho sinh vật thủy sinh.', N'P273: Tránh thải ra môi trường.', N'Điều trị triệu chứng. Rửa sạch da và mắt.', 9, 0, CAST(N'2026-03-07T07:44:10.6387526' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (19, N'Glufosinate Ammonium', N'77182-82-2', N'Nguy hiểm', N'H360Fd: Có thể tổn hại sinh sản. H373: Tổn thương cơ quan.', N'P201: Nhận hướng dẫn đặc biệt. P280: Mang bảo hộ.', N'Nếu nuốt phải: Rửa dạ dày ngay lập tức.', 8, 0, CAST(N'2026-03-07T07:44:10.6387528' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (20, N'Atrazine', N'1912-24-9', N'Cảnh báo', N'H317: Gây dị ứng da. H373: Tổn thương nội tạng.', N'P280: Mang găng tay bảo hộ.', N'Rửa da bằng xà phòng và nước. Thay quần áo nhiễm bẩn.', 8, 0, CAST(N'2026-03-07T07:44:10.6387529' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (21, N'Pretilachlor', N'51218-49-6', N'Cảnh báo', N'H317: Gây dị ứng da. H410: Rất độc với sinh vật thủy sinh.', N'P273: Tránh thải ra môi trường. P280: Mang găng tay.', N'Rửa sạch vùng da tiếp xúc. Điều trị triệu chứng.', 9, 0, CAST(N'2026-03-07T07:44:10.6387530' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (22, N'Diuron', N'330-54-1', N'Cảnh báo', N'H351: Nghi ngờ gây ung thư. H373: Tổn thương cơ quan.', N'P201: Nhận hướng dẫn đặc biệt. P273: Tránh thải môi trường.', N'Đưa đến cơ sở y tế nếu có triệu chứng. Rửa sạch da.', 8, 0, CAST(N'2026-03-07T07:44:10.6387532' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (23, N'Niclosamide', N'50-65-7', N'Cảnh báo', N'H400: Rất độc đối với sinh vật thủy sinh.', N'P273: Tránh thải ra môi trường (ao hồ nuôi cá).', N'Rửa sạch da/mắt. Nếu nuốt: uống nhiều nước và gây nôn.', 9, 0, CAST(N'2026-03-07T07:44:10.6387533' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (24, N'Brodifacoum', N'56073-10-0', N'Nguy hiểm', N'H300: Chết người nếu nuốt phải. H310: Chết nếu tiếp xúc da. H372: Tổn thương máu.', N'P262: Không để dính vào mắt, da. P280: Mang bảo hộ.', N'Dùng Vitamin K1 giải độc. Đưa ngay đến bệnh viện.', 6, 0, CAST(N'2026-03-07T07:44:10.6387535' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (25, N'Metaldehyde', N'108-62-3', N'Cảnh báo', N'H228: Chất rắn dễ cháy. H302: Có hại nếu nuốt phải.', N'P210: Tránh xa nguồn nhiệt. P270: Không ăn uống khi dùng.', N'Rửa dạ dày bằng bicarbonate natri. Theo dõi co giật.', 2, 0, CAST(N'2026-03-07T07:44:10.6387536' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[ChemicalProfiles] ([Id], [CommonName], [CasNumber], [SignalWord], [HazardStatement], [PrecautionaryStatement], [FirstAidMeasures], [PrimaryHazardSymbol], [IsBanned], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (26, N'Annonin', N'Unknown', N'An toàn', N'Không có nguy hiểm đáng kể (Sinh học).', N'P102: Để xa tầm tay trẻ em.', N'Rửa sạch với nước.', 10, 0, CAST(N'2026-03-07T07:44:10.6387544' AS DateTime2), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[ChemicalProfiles] OFF
GO
SET IDENTITY_INSERT [dbo].[Crops] ON 

INSERT [dbo].[Crops] ([Id], [Name], [Description]) VALUES (1, N'Lua', N'Cay lua')
INSERT [dbo].[Crops] ([Id], [Name], [Description]) VALUES (2, N'Ca chua', N'Cay ca chua')
INSERT [dbo].[Crops] ([Id], [Name], [Description]) VALUES (3, N'Rau cai', N'Nhom rau an la')
INSERT [dbo].[Crops] ([Id], [Name], [Description]) VALUES (4, N'Xoai', N'Cay an trai')
INSERT [dbo].[Crops] ([Id], [Name], [Description]) VALUES (5, N'Lua', N'Cay lua')
INSERT [dbo].[Crops] ([Id], [Name], [Description]) VALUES (6, N'Ca chua', N'Cay ca chua')
INSERT [dbo].[Crops] ([Id], [Name], [Description]) VALUES (7, N'Rau cai', N'Nhom rau an la')
INSERT [dbo].[Crops] ([Id], [Name], [Description]) VALUES (8, N'Xoai', N'Cay an trai')
SET IDENTITY_INSERT [dbo].[Crops] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [AvatarUrl], [MembershipLevel], [Address], [DistrictId], [Gender], [PasswordHash], [PasswordSalt], [IsLocked], [IsDeleted], [CreatedAt], [UpdatedAt], [ResetToken], [ResetTokenExpiry], [ManagedByStaffId]) VALUES (1, N'Nguyễn', N'Văn A', N'testuser@example.com', N'0912365569', NULL, N'Bronze', NULL, NULL, NULL, N'$2a$11$OZCJBllEMVYfgbrGkDpxHOXAcJqRQAk6T7xQdWyrQOWKjUB4yM6k.', NULL, 0, 0, CAST(N'2025-12-31T16:02:58.3968343' AS DateTime2), CAST(N'2026-03-18T15:55:40.1501795' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [AvatarUrl], [MembershipLevel], [Address], [DistrictId], [Gender], [PasswordHash], [PasswordSalt], [IsLocked], [IsDeleted], [CreatedAt], [UpdatedAt], [ResetToken], [ResetTokenExpiry], [ManagedByStaffId]) VALUES (2, N'Huỳnh Lê', N'Công Biên', N'bienhlcce181207@fpt.edu.vn', N'0912365463', NULL, N'Gold', N'An Minh, Kiên GIang', NULL, N'Male', N'$2a$12$xDgCvlpNpjOIw6uRhH8aKOK3snZ976kuUyIgVVTAJ1fIrUyjUtwZC', NULL, 0, 0, CAST(N'2026-01-04T09:35:29.2306374' AS DateTime2), CAST(N'2026-03-05T01:40:02.4904232' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [AvatarUrl], [MembershipLevel], [Address], [DistrictId], [Gender], [PasswordHash], [PasswordSalt], [IsLocked], [IsDeleted], [CreatedAt], [UpdatedAt], [ResetToken], [ResetTokenExpiry], [ManagedByStaffId]) VALUES (3, N'Test', N'User', N'testuser+ts1@example.com', N'0912365467', NULL, N'Silver', NULL, NULL, NULL, N'$2a$11$VdnBOxDiwIQSTP6IUcEO/u9PEI1ZxJWt6tV0hh38aX80.s3u/4c9K', NULL, 0, 0, CAST(N'2026-01-04T09:47:36.7258565' AS DateTime2), CAST(N'2026-01-05T16:22:40.5274118' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [AvatarUrl], [MembershipLevel], [Address], [DistrictId], [Gender], [PasswordHash], [PasswordSalt], [IsLocked], [IsDeleted], [CreatedAt], [UpdatedAt], [ResetToken], [ResetTokenExpiry], [ManagedByStaffId]) VALUES (4, N'Test', N'User', N'test@example.com', NULL, NULL, NULL, NULL, NULL, NULL, N'$2a$11$rpZLYD6XCZkz03307iXfnuAv6ENKMIr/BXiEWpS76sK9nJRaaiwxS', NULL, 0, 0, CAST(N'2026-01-05T10:19:43.9019761' AS DateTime2), NULL, NULL, NULL, NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [AvatarUrl], [MembershipLevel], [Address], [DistrictId], [Gender], [PasswordHash], [PasswordSalt], [IsLocked], [IsDeleted], [CreatedAt], [UpdatedAt], [ResetToken], [ResetTokenExpiry], [ManagedByStaffId]) VALUES (5, N'Nguyen', N'Van A', N'hlcongbien2004.work@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, N'$2a$11$GNvyUXpef9O8wPZ8xlg9BuNUobbFVXrshSWEhptON4fvbOaqE4CCW', NULL, 0, 0, CAST(N'2026-01-05T10:56:47.0344823' AS DateTime2), NULL, NULL, NULL, NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [AvatarUrl], [MembershipLevel], [Address], [DistrictId], [Gender], [PasswordHash], [PasswordSalt], [IsLocked], [IsDeleted], [CreatedAt], [UpdatedAt], [ResetToken], [ResetTokenExpiry], [ManagedByStaffId]) VALUES (6, N'Huỳnh Lê', N'Công Biên', N'hlcongbien2004@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, CAST(N'2026-01-27T08:03:59.3655293' AS DateTime2), NULL, NULL, NULL, NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [AvatarUrl], [MembershipLevel], [Address], [DistrictId], [Gender], [PasswordHash], [PasswordSalt], [IsLocked], [IsDeleted], [CreatedAt], [UpdatedAt], [ResetToken], [ResetTokenExpiry], [ManagedByStaffId]) VALUES (7, N'Bien2', N'Huynh', N'hlcongbien2004@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, CAST(N'2026-01-27T16:32:50.4687076' AS DateTime2), CAST(N'2026-01-27T23:32:56.8993000' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [AvatarUrl], [MembershipLevel], [Address], [DistrictId], [Gender], [PasswordHash], [PasswordSalt], [IsLocked], [IsDeleted], [CreatedAt], [UpdatedAt], [ResetToken], [ResetTokenExpiry], [ManagedByStaffId]) VALUES (8, N'Huỳnh Lê', N'Công Biên', N'hlcongbien2004@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, CAST(N'2026-01-28T03:14:45.0932771' AS DateTime2), NULL, NULL, NULL, NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [AvatarUrl], [MembershipLevel], [Address], [DistrictId], [Gender], [PasswordHash], [PasswordSalt], [IsLocked], [IsDeleted], [CreatedAt], [UpdatedAt], [ResetToken], [ResetTokenExpiry], [ManagedByStaffId]) VALUES (9, N'Huỳnh Lê', N'Công Biên', N'hlcongbien2004@gmail.com', N'111111111', NULL, NULL, NULL, NULL, NULL, N'$2a$11$0Cx7TiaGD82cn3.dhxB7X.KVBLoac/rgutRXm6e9c1t9IaULm3xOm', NULL, 0, 0, CAST(N'2026-01-28T03:41:13.2121768' AS DateTime2), CAST(N'2026-01-28T04:20:42.3620946' AS DateTime2), NULL, NULL, NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [AvatarUrl], [MembershipLevel], [Address], [DistrictId], [Gender], [PasswordHash], [PasswordSalt], [IsLocked], [IsDeleted], [CreatedAt], [UpdatedAt], [ResetToken], [ResetTokenExpiry], [ManagedByStaffId]) VALUES (10, N'Huỳnh Lê', N'Công Biên', N'hlcongbien2003@gmail.com', N'111111111', NULL, NULL, NULL, NULL, NULL, N'$2a$11$FbWPy1Vch4.mMGg1ozJIAO1ipVcDvqHe7BDbo7YrmRvXlb7vUlgqi', NULL, 0, 1, CAST(N'2026-01-28T04:20:29.3211795' AS DateTime2), NULL, NULL, NULL, NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [AvatarUrl], [MembershipLevel], [Address], [DistrictId], [Gender], [PasswordHash], [PasswordSalt], [IsLocked], [IsDeleted], [CreatedAt], [UpdatedAt], [ResetToken], [ResetTokenExpiry], [ManagedByStaffId]) VALUES (11, N'Tam', N'Nguyen', N'TamNguyen2004@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, N'$2a$11$M3N4B6T9DZT928RAG1ruKOkdl4mHkAFcP96DT.spfEGHoyQu/7Pni', NULL, 0, 0, CAST(N'2026-03-23T07:24:08.1081612' AS DateTime2), NULL, NULL, NULL, NULL)
INSERT [dbo].[Customers] ([Id], [FirstName], [LastName], [Email], [Phone], [AvatarUrl], [MembershipLevel], [Address], [DistrictId], [Gender], [PasswordHash], [PasswordSalt], [IsLocked], [IsDeleted], [CreatedAt], [UpdatedAt], [ResetToken], [ResetTokenExpiry], [ManagedByStaffId]) VALUES (12, N'Tam', N'Nguyen', N'TamNguyen2003@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, N'$2a$11$kskNKaGSUo7G0WXl1kPTKu05lkFr0qqAJ75R/Kocuwy2v4HzF9zpS', NULL, 0, 0, CAST(N'2026-03-23T07:57:32.2807456' AS DateTime2), NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Discounts] ON 

INSERT [dbo].[Discounts] ([Id], [Name], [DiscountPercent], [StartDate], [EndDate], [IsActive], [ProductId], [CreatedByAdminId]) VALUES (1, N'Test', 10, CAST(N'2026-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2026-01-09T00:00:00.0000000' AS DateTime2), 1, 160, NULL)
INSERT [dbo].[Discounts] ([Id], [Name], [DiscountPercent], [StartDate], [EndDate], [IsActive], [ProductId], [CreatedByAdminId]) VALUES (4, N'Test2', 5, CAST(N'2026-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2026-01-09T00:00:00.0000000' AS DateTime2), 1, 154, NULL)
INSERT [dbo].[Discounts] ([Id], [Name], [DiscountPercent], [StartDate], [EndDate], [IsActive], [ProductId], [CreatedByAdminId]) VALUES (6, N'BienTest', 12, CAST(N'2026-01-03T00:00:00.0000000' AS DateTime2), CAST(N'2026-01-21T00:00:00.0000000' AS DateTime2), 1, 156, NULL)
INSERT [dbo].[Discounts] ([Id], [Name], [DiscountPercent], [StartDate], [EndDate], [IsActive], [ProductId], [CreatedByAdminId]) VALUES (7, N'Test6', 15, CAST(N'2026-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2026-01-08T00:00:00.0000000' AS DateTime2), 1, 160, NULL)
INSERT [dbo].[Discounts] ([Id], [Name], [DiscountPercent], [StartDate], [EndDate], [IsActive], [ProductId], [CreatedByAdminId]) VALUES (8, N'Phân bón và hóa chất', 5, CAST(N'2026-03-05T09:13:08.7364447' AS DateTime2), CAST(N'2026-03-06T00:00:00.0000000' AS DateTime2), 1, 160, NULL)
INSERT [dbo].[Discounts] ([Id], [Name], [DiscountPercent], [StartDate], [EndDate], [IsActive], [ProductId], [CreatedByAdminId]) VALUES (9, N'Phân bón và hóa chất', 8, CAST(N'2026-03-09T00:00:00.0000000' AS DateTime2), CAST(N'2026-03-17T15:34:19.2861193' AS DateTime2), 1, 160, NULL)
SET IDENTITY_INSERT [dbo].[Discounts] OFF
GO
SET IDENTITY_INSERT [dbo].[Districts] ON 

INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (1, N'Long Xuyen', 1, 10.3864, 105.4352)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (2, N'Vung Tau', 2, 10.3459, 107.0843)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (3, N'Bac Giang', 3, 21.2731, 106.1946)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (4, N'Bac Kan', 4, 22.147, 105.8348)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (5, N'Bac Lieu', 5, 9.2941, 105.7278)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (6, N'Bac Ninh', 6, 21.1861, 106.0763)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (7, N'Ben Tre', 7, 10.2434, 106.3759)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (8, N'Quy Nhon', 8, 13.7829, 109.2197)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (9, N'Thu Dau Mot', 9, 10.9804, 106.6519)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (10, N'Dong Xoai', 10, 11.5349, 106.8845)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (11, N'Phan Thiet', 11, 10.9289, 108.1021)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (12, N'Ca Mau', 12, 9.1769, 105.1524)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (13, N'Ninh Kieu', 13, 10.0342, 105.7872)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (14, N'Cao Bang', 14, 22.6666, 106.2636)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (15, N'Hai Chau', 15, 16.0544, 108.2022)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (16, N'Buon Ma Thuot', 16, 12.6667, 108.05)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (17, N'Gia Nghia', 17, 12.0042, 107.6874)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (18, N'Dien Bien Phu', 18, 21.386, 103.023)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (19, N'Bien Hoa', 19, 10.9574, 106.8426)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (20, N'Cao Lanh', 20, 10.46, 105.6329)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (21, N'Pleiku', 21, 13.9833, 108)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (22, N'Ha Giang', 22, 22.8233, 104.9836)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (23, N'Phu Ly', 23, 20.5453, 105.9122)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (24, N'Cau Giay', 24, 21.0302, 105.7829)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (25, N'Ha Tinh', 25, 18.3428, 105.9057)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (26, N'Hai Duong', 26, 20.9388, 106.32)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (27, N'Hong Bang', 27, 20.8648, 106.6834)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (28, N'Vi Thanh', 28, 9.7845, 105.4701)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (29, N'Hoa Binh', 29, 20.8172, 105.3376)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (30, N'Hung Yen', 30, 20.6464, 106.0511)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (31, N'Nha Trang', 31, 12.2388, 109.1967)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (32, N'Rach Gia', 32, 10.0125, 105.0809)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (33, N'Kon Tum', 33, 14.3545, 108.0076)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (34, N'Lai Chau', 34, 22.3964, 103.4582)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (35, N'Da Lat', 35, 11.9404, 108.4583)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (36, N'Lang Son', 36, 21.8527, 106.761)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (37, N'Lao Cai', 37, 22.4856, 103.9707)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (38, N'Tan An', 38, 10.5388, 106.412)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (39, N'Nam Dinh', 39, 20.4388, 106.1621)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (40, N'Vinh', 40, 18.6796, 105.6813)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (41, N'Ninh Binh', 41, 20.2506, 105.9744)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (42, N'Phan Rang - Thap Cham', 42, 11.565, 108.9886)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (85, N'Viet Tri', 85, 21.3225, 105.4028)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (86, N'Tuy Hoa', 86, 13.0955, 109.3209)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (87, N'Dong Hoi', 87, 17.4689, 106.6223)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (88, N'Tam Ky', 88, 15.5736, 108.474)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (89, N'Quang Ngai', 89, 15.1214, 108.8044)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (90, N'Ha Long', 90, 20.9714, 107.0448)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (91, N'Dong Ha', 91, 16.8163, 107.1003)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (92, N'Soc Trang', 92, 9.6037, 105.98)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (93, N'Son La', 93, 21.3256, 103.9188)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (94, N'Tay Ninh', 94, 11.3352, 106.1099)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (95, N'Thai Binh', 95, 20.4463, 106.3365)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (96, N'Thai Nguyen', 96, 21.5942, 105.8482)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (97, N'Thanh Hoa', 97, 19.8067, 105.7852)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (98, N'Hue', 98, 16.4637, 107.5909)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (99, N'My Tho', 99, 10.36, 106.3597)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (100, N'Quan 1', 100, 10.7769, 106.7009)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (101, N'Tra Vinh', 101, 9.9347, 106.3453)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (102, N'Tuyen Quang', 102, 21.8236, 105.2142)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (103, N'Vinh Long', 103, 10.2537, 105.9722)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (104, N'Vinh Yen', 104, 21.3089, 105.6049)
INSERT [dbo].[Districts] ([Id], [Name], [ProvinceId], [Latitude], [Longitude]) VALUES (105, N'Yen Bai', 105, 21.7056, 104.8664)
SET IDENTITY_INSERT [dbo].[Districts] OFF
GO
SET IDENTITY_INSERT [dbo].[FeedbackImages] ON 

INSERT [dbo].[FeedbackImages] ([Id], [ImageUrl], [FeedbackId]) VALUES (1, N'/uploads/feedback/f8712d4e-80d8-410f-85d2-eaf5d6aacff5_Anh1.png', 1)
SET IDENTITY_INSERT [dbo].[FeedbackImages] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedbacks] ON 

INSERT [dbo].[Feedbacks] ([Id], [Rating], [Comment], [CreatedAt], [UpdatedAt], [ProductId], [CustomerId], [OrderId]) VALUES (1, 4, N'Test', CAST(N'2026-03-10T08:31:21.8334471' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 160, 2, 1)
SET IDENTITY_INSERT [dbo].[Feedbacks] OFF
GO
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (1, 160, 2, CAST(210000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (2, 160, 2, CAST(210000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (3, 158, 1, CAST(130000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (4, 50, 1, CAST(199000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (4, 155, 1, CAST(310000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (4, 156, 1, CAST(130000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (5, 43, 1, CAST(200000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (6, 43, 1, CAST(200000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (7, 43, 3, CAST(200000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (8, 43, 2, CAST(200000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (9, 101, 1, CAST(220000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (10, 160, 1, CAST(210000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (11, 38, 2, CAST(210000.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [OrderDate], [TotalAmount], [ShippingFee], [FinalAmount], [ReceiverName], [ReceiverPhone], [ShippingAddress], [Note], [IsHazardousOrder], [TrackingNumber], [Status], [PaymentMethod], [CustomerId], [ManagedByStaffId], [IsRefunded]) VALUES (1, CAST(N'2026-03-10T08:28:27.3413122' AS DateTime2), CAST(420000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(470000.00 AS Decimal(18, 2)), N'Huỳnh Lê Công Biên', N'0912365463', N'An Minh, Kiên GIang', NULL, 1, NULL, 5, 4, 2, NULL, 0)
INSERT [dbo].[Orders] ([Id], [OrderDate], [TotalAmount], [ShippingFee], [FinalAmount], [ReceiverName], [ReceiverPhone], [ShippingAddress], [Note], [IsHazardousOrder], [TrackingNumber], [Status], [PaymentMethod], [CustomerId], [ManagedByStaffId], [IsRefunded]) VALUES (2, CAST(N'2026-03-10T08:36:14.8918908' AS DateTime2), CAST(420000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(470000.00 AS Decimal(18, 2)), N'Huỳnh Lê Công Biên', N'0912365463', N'An Minh, Kiên GIang', NULL, 1, NULL, 1, 1, 2, NULL, 0)
INSERT [dbo].[Orders] ([Id], [OrderDate], [TotalAmount], [ShippingFee], [FinalAmount], [ReceiverName], [ReceiverPhone], [ShippingAddress], [Note], [IsHazardousOrder], [TrackingNumber], [Status], [PaymentMethod], [CustomerId], [ManagedByStaffId], [IsRefunded]) VALUES (3, CAST(N'2026-03-18T23:38:34.2566396' AS DateTime2), CAST(130000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(180000.00 AS Decimal(18, 2)), N'Nguyen Van A', N'111111111', N'An Minh, Kiên GIang', NULL, 1, NULL, 6, 1, 5, NULL, 0)
INSERT [dbo].[Orders] ([Id], [OrderDate], [TotalAmount], [ShippingFee], [FinalAmount], [ReceiverName], [ReceiverPhone], [ShippingAddress], [Note], [IsHazardousOrder], [TrackingNumber], [Status], [PaymentMethod], [CustomerId], [ManagedByStaffId], [IsRefunded]) VALUES (4, CAST(N'2026-03-19T04:33:54.2538724' AS DateTime2), CAST(639000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(689000.00 AS Decimal(18, 2)), N'Nguyen Van A', N'111111111', N'An Minh, Kiên GIang', NULL, 1, NULL, 5, 1, 5, NULL, 0)
INSERT [dbo].[Orders] ([Id], [OrderDate], [TotalAmount], [ShippingFee], [FinalAmount], [ReceiverName], [ReceiverPhone], [ShippingAddress], [Note], [IsHazardousOrder], [TrackingNumber], [Status], [PaymentMethod], [CustomerId], [ManagedByStaffId], [IsRefunded]) VALUES (5, CAST(N'2026-03-19T04:36:29.8688155' AS DateTime2), CAST(200000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(230000.00 AS Decimal(18, 2)), N'Nguyen Van A', N'0942004995', N'An Minh, Kiên GIang', NULL, 0, NULL, 6, 1, 5, NULL, 0)
INSERT [dbo].[Orders] ([Id], [OrderDate], [TotalAmount], [ShippingFee], [FinalAmount], [ReceiverName], [ReceiverPhone], [ShippingAddress], [Note], [IsHazardousOrder], [TrackingNumber], [Status], [PaymentMethod], [CustomerId], [ManagedByStaffId], [IsRefunded]) VALUES (6, CAST(N'2026-03-19T04:37:26.0530883' AS DateTime2), CAST(200000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(230000.00 AS Decimal(18, 2)), N'Nguyen Van A', N'0942004995', N'An Minh, Kiên GIang', NULL, 0, NULL, 6, 1, 5, NULL, 0)
INSERT [dbo].[Orders] ([Id], [OrderDate], [TotalAmount], [ShippingFee], [FinalAmount], [ReceiverName], [ReceiverPhone], [ShippingAddress], [Note], [IsHazardousOrder], [TrackingNumber], [Status], [PaymentMethod], [CustomerId], [ManagedByStaffId], [IsRefunded]) VALUES (7, CAST(N'2026-03-19T04:48:53.6901211' AS DateTime2), CAST(600000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(630000.00 AS Decimal(18, 2)), N'Nguyen Van A', N'0912345678', N'An Minh, Kiên GIang', NULL, 0, NULL, 6, 4, 5, NULL, 0)
INSERT [dbo].[Orders] ([Id], [OrderDate], [TotalAmount], [ShippingFee], [FinalAmount], [ReceiverName], [ReceiverPhone], [ShippingAddress], [Note], [IsHazardousOrder], [TrackingNumber], [Status], [PaymentMethod], [CustomerId], [ManagedByStaffId], [IsRefunded]) VALUES (8, CAST(N'2026-03-19T04:50:26.1257008' AS DateTime2), CAST(400000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(430000.00 AS Decimal(18, 2)), N'Nguyen Van A', N'0912345678', N'An Minh, Kiên GIang', NULL, 0, NULL, 6, 1, 5, NULL, 0)
INSERT [dbo].[Orders] ([Id], [OrderDate], [TotalAmount], [ShippingFee], [FinalAmount], [ReceiverName], [ReceiverPhone], [ShippingAddress], [Note], [IsHazardousOrder], [TrackingNumber], [Status], [PaymentMethod], [CustomerId], [ManagedByStaffId], [IsRefunded]) VALUES (9, CAST(N'2026-03-19T07:16:34.3285378' AS DateTime2), CAST(220000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(250000.00 AS Decimal(18, 2)), N'Nguyen Van A', N'0912345678', N'An Minh, Kiên GIang', NULL, 0, NULL, 1, 1, 5, NULL, 0)
INSERT [dbo].[Orders] ([Id], [OrderDate], [TotalAmount], [ShippingFee], [FinalAmount], [ReceiverName], [ReceiverPhone], [ShippingAddress], [Note], [IsHazardousOrder], [TrackingNumber], [Status], [PaymentMethod], [CustomerId], [ManagedByStaffId], [IsRefunded]) VALUES (10, CAST(N'2026-03-19T07:17:47.0904113' AS DateTime2), CAST(210000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(260000.00 AS Decimal(18, 2)), N'Nguyen Van A', N'0912345678', N'An Minh, Kiên GIang', NULL, 1, NULL, 5, 1, 5, NULL, 0)
INSERT [dbo].[Orders] ([Id], [OrderDate], [TotalAmount], [ShippingFee], [FinalAmount], [ReceiverName], [ReceiverPhone], [ShippingAddress], [Note], [IsHazardousOrder], [TrackingNumber], [Status], [PaymentMethod], [CustomerId], [ManagedByStaffId], [IsRefunded]) VALUES (11, CAST(N'2026-03-23T08:00:49.5703717' AS DateTime2), CAST(420000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(450000.00 AS Decimal(18, 2)), N'Tam Nguyen', N'0942004995', N'Kien Giang', NULL, 0, NULL, 6, 4, 12, NULL, 0)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Pests] ON 

INSERT [dbo].[Pests] ([Id], [Name]) VALUES (1, N'Ray nau')
INSERT [dbo].[Pests] ([Id], [Name]) VALUES (2, N'Sau duc qua')
INSERT [dbo].[Pests] ([Id], [Name]) VALUES (3, N'Sau to')
INSERT [dbo].[Pests] ([Id], [Name]) VALUES (4, N'Rep sap')
INSERT [dbo].[Pests] ([Id], [Name]) VALUES (5, N'Ray nau')
INSERT [dbo].[Pests] ([Id], [Name]) VALUES (6, N'Sau duc qua')
INSERT [dbo].[Pests] ([Id], [Name]) VALUES (7, N'Sau to')
INSERT [dbo].[Pests] ([Id], [Name]) VALUES (8, N'Rep sap')
SET IDENTITY_INSERT [dbo].[Pests] OFF
GO
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (1, 1, N'130,000 ppm')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (1, 2, N'40,000 ppm')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (2, 26, N'1% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (3, 23, N'750 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (4, 1, N'160 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (5, 1, N'400 ppm')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (6, 2, N'23.6%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (7, 1, N'Phức hợp NPK')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (8, 26, N'0.1% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (9, 1, N'52% P2O5')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (10, 1, N'12% SiO2')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (11, 26, N'5.0% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (12, 4, N'15% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (13, 3, N'2.5% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (14, 26, N'30% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (15, 17, N'98% (25% Cu)')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (16, 26, N'Chất trợ lực')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (17, 26, N'5% LAS')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (18, 26, N'1 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (19, 3, N'10% HNO3')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (20, 1, N'50% Hữu cơ')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (21, 1, N'60% Hữu cơ')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (22, 1, N'20-20-15')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (23, 1, N'15-15-15')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (24, 2, N'200 ppm Zn')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (25, 1, N'30 ppm B')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (26, 1, N'16-16-8')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (27, 1, N'50% K2O')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (28, 2, N'1000 ppm Zn')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (29, 1, N'310 ppm B')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (30, 1, N'50 ppm B')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (31, 2, N'220 ppm Zn')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (32, 26, N'4 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (33, 26, N'1.8 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (34, 1, N'18-46-0')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (35, 2, N'20%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (36, 1, N'50,000 ppm')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (36, 2, N'50,000 ppm')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (37, 26, N'5.0% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (38, 1, N'52-34')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (39, 26, N'0.11 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (40, 1, N'310 ppm B')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (41, 2, N'80% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (42, 2, N'80% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (43, 15, N'250 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (44, 14, N'5% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (45, 11, N'30% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (45, 14, N'2% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (46, 16, N'250 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (47, 13, N'100 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (48, 16, N'250 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (49, 14, N'40.5% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (50, 5, N'200 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (51, 11, N'400 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (52, 11, N'75% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (53, 11, N'75% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (54, 11, N'75% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (55, 12, N'607 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (56, 13, N'100 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (57, 15, N'120 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (58, 15, N'150 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (59, 15, N'30% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (60, 15, N'250 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (61, 17, N'47.5%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (62, 12, N'64% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (63, 13, N'250 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (64, 15, N'125 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (65, 11, N'6% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (66, 18, N'10% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (67, 18, N'10% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (68, 17, N'17% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (69, 16, N'50% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (70, 13, N'50% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (71, 11, N'40% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (72, 12, N'430 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (73, 12, N'80% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (74, 12, N'75% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (75, 26, N'1.8 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (76, 12, N'80% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (77, 12, N'80% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (78, 2, N'80% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (79, 13, N'5% w/v')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (80, 14, N'2% w/v')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (81, 19, N'10% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (82, 22, N'800 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (83, 21, N'500 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (84, 21, N'300 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (85, 21, N'10% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (86, 19, N'200 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (87, 21, N'150 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (88, 21, N'800 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (89, 21, N'500 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (90, 21, N'2.5% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (91, 20, N'500 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (92, 20, N'80% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (93, 22, N'500 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (94, 21, N'100 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (95, 19, N'200 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (96, 20, N'75 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (97, 19, N'24% w/w')
GO
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (98, 19, N'150 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (99, 19, N'150 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (100, 21, N'250 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (101, 21, N'20% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (102, 19, N'108 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (102, 22, N'160 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (103, 22, N'700 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (104, 21, N'350 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (105, 21, N'200 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (106, 21, N'12% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (107, 21, N'10% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (108, 21, N'28.5% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (109, 21, N'28.5% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (110, 22, N'500 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (111, 26, N'99% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (112, 7, N'30 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (113, 6, N'25% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (114, 10, N'570 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (115, 6, N'15%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (116, 9, N'430 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (117, 7, N'100 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (118, 6, N'3% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (119, 6, N'3% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (120, 6, N'10% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (121, 24, N'0.005%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (122, 24, N'0.005%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (123, 8, N'100 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (124, 7, N'20% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (125, 9, N'90% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (126, 7, N'50% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (127, 8, N'18 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (128, 9, N'95% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (129, 9, N'4% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (130, 8, N'20% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (131, 6, N'25%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (132, 23, N'830 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (133, 23, N'250 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (134, 6, N'20% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (135, 8, N'5% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (136, 8, N'5 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (137, 7, N'400 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (138, 7, N'150 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (139, 25, N'12% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (140, 16, N'250 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (141, 6, N'3.8%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (142, 7, N'50% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (143, 8, N'2.5%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (144, 24, N'20%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (145, 6, N'35% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (146, 7, N'50% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (147, 26, N'Thảo mộc')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (148, 24, N'20%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (149, 16, N'250 g/kg')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (150, 7, N'50% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (151, 7, N'50% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (152, 7, N'50% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (153, 24, N'0.005%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (154, 21, N'50 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (155, 21, N'300 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (156, 7, N'15%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (157, 22, N'500 g/l')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (158, 24, N'0.005%')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (159, 7, N'20% w/w')
INSERT [dbo].[ProductChemicals] ([ProductId], [ChemicalProfileId], [Concentration]) VALUES (160, 24, N'50% w/w')
GO
SET IDENTITY_INSERT [dbo].[ProductImages] ON 

INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (1, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627313/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/a5b2rc0vwrdq1yzexbpi.jpg', N'img0001', 1, 1, CAST(N'2026-03-07T07:44:10.6388684' AS DateTime2), 1)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (2, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627313/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/nc8tebfg4fnrjz1noed1.png', N'img0002', 1, 1, CAST(N'2026-03-07T07:44:10.6388687' AS DateTime2), 2)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (3, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627313/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/i3eebcb0pudmpb12g7st.png', N'img0003', 1, 1, CAST(N'2026-03-07T07:44:10.6388688' AS DateTime2), 3)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (4, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627312/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/tkamq3hklpk4xwplbhjb.jpg', N'img0004', 1, 1, CAST(N'2026-03-07T07:44:10.6388690' AS DateTime2), 4)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (5, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627312/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/kfzzi2ptt0zbsaqjxotf.jpg', N'img0005', 1, 1, CAST(N'2026-03-07T07:44:10.6388691' AS DateTime2), 5)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (6, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627312/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/mju64pqckfjw2p208mqe.png', N'img0006', 1, 1, CAST(N'2026-03-07T07:44:10.6388692' AS DateTime2), 6)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (7, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627312/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/snkvpeu1aol3e0stvqmm.png', N'img0007', 1, 1, CAST(N'2026-03-07T07:44:10.6388694' AS DateTime2), 7)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (8, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627312/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/cszzwy5mp15ziztpade3.webp', N'img0008', 1, 1, CAST(N'2026-03-07T07:44:10.6388695' AS DateTime2), 8)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (9, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627312/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/le0s2ooymlvkl8r73com.jpg', N'img0009', 1, 1, CAST(N'2026-03-07T07:44:10.6388696' AS DateTime2), 9)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (10, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627312/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/ftqxavgzmpayhdiud4y0.png', N'img0010', 1, 1, CAST(N'2026-03-07T07:44:10.6388698' AS DateTime2), 10)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (11, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627311/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/jwkdke6opciq5agtwkhx.png', N'img0011', 1, 1, CAST(N'2026-03-07T07:44:10.6388699' AS DateTime2), 11)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (12, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627311/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/hwz8rdumllo6etpopwt1.png', N'img0012', 1, 1, CAST(N'2026-03-07T07:44:10.6388700' AS DateTime2), 12)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (13, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627311/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/duybejezraf7iwich9gb.png', N'img0013', 1, 1, CAST(N'2026-03-07T07:44:10.6388702' AS DateTime2), 13)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (14, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627311/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/uxqiuhlchdavxzxbijxm.png', N'img0014', 1, 1, CAST(N'2026-03-07T07:44:10.6388703' AS DateTime2), 14)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (15, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627311/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/tub7luoytddan86aoqsv.jpg', N'img0015', 1, 1, CAST(N'2026-03-07T07:44:10.6388705' AS DateTime2), 15)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (16, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627311/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/m2fcw4hgow8i5hhpmstk.png', N'img0016', 1, 1, CAST(N'2026-03-07T07:44:10.6388706' AS DateTime2), 16)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (17, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627310/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/ugx7d8f0q81lxyo1tecz.png', N'img0017', 1, 1, CAST(N'2026-03-07T07:44:10.6388707' AS DateTime2), 17)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (18, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627310/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/oxiq6fwhhfbtg3vjqlov.png', N'img0018', 1, 1, CAST(N'2026-03-07T07:44:10.6388709' AS DateTime2), 18)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (19, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627310/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/mhhv6dpeomytzpunk3y1.png', N'img0019', 1, 1, CAST(N'2026-03-07T07:44:10.6388710' AS DateTime2), 19)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (20, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627310/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/jmrhyvdb0howzgq5agh6.jpg', N'img0020', 1, 1, CAST(N'2026-03-07T07:44:10.6388711' AS DateTime2), 20)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (21, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627310/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/sdvivsgydeemyjtuqfjk.jpg', N'img0021', 1, 1, CAST(N'2026-03-07T07:44:10.6388713' AS DateTime2), 21)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (22, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627309/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/s6ztz2uyqfw8kz2mpxkx.jpg', N'img0022', 1, 1, CAST(N'2026-03-07T07:44:10.6388714' AS DateTime2), 22)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (23, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627309/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/kaoadd1vr6eta6lfhrog.jpg', N'img0023', 1, 1, CAST(N'2026-03-07T07:44:10.6388715' AS DateTime2), 23)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (24, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627309/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/edr4ibmh4xx1eo9isbfj.jpg', N'img0024', 1, 1, CAST(N'2026-03-07T07:44:10.6388717' AS DateTime2), 24)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (25, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627309/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/x5sa2lnh06xn71aibzcb.png', N'img0025', 1, 1, CAST(N'2026-03-07T07:44:10.6388718' AS DateTime2), 25)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (26, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627309/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/gdyr4dc81kmt66yflpdl.jpg', N'img0026', 1, 1, CAST(N'2026-03-07T07:44:10.6388719' AS DateTime2), 26)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (27, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627309/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/jywkwhlj5q1o0up1mbyq.jpg', N'img0027', 1, 1, CAST(N'2026-03-07T07:44:10.6388721' AS DateTime2), 27)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (28, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627309/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/ognzy3kciovw5pah5ki1.jpg', N'img0028', 1, 1, CAST(N'2026-03-07T07:44:10.6388722' AS DateTime2), 28)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (29, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627309/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/hsgimtzne9q9bph9b7bl.jpg', N'img0029', 1, 1, CAST(N'2026-03-07T07:44:10.6388724' AS DateTime2), 29)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (30, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627308/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/nckfwe0mlue5b2gbojvy.png', N'img0030', 1, 1, CAST(N'2026-03-07T07:44:10.6388725' AS DateTime2), 30)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (31, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627308/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/qqigyqs0iw2baysnmcrm.png', N'img0031', 1, 1, CAST(N'2026-03-07T07:44:10.6388763' AS DateTime2), 31)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (32, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627308/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/fxw9yshnkg7maqrddsbs.png', N'img0032', 1, 1, CAST(N'2026-03-07T07:44:10.6388765' AS DateTime2), 32)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (33, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627308/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/ugvjihfip8hwamdyrohp.png', N'img0033', 1, 1, CAST(N'2026-03-07T07:44:10.6388766' AS DateTime2), 33)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (34, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627308/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/q2v4xnxjlvo9e6z59iso.png', N'img0034', 1, 1, CAST(N'2026-03-07T07:44:10.6388768' AS DateTime2), 34)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (35, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627307/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/dw4n87coux51t5zajekm.png', N'img0035', 1, 1, CAST(N'2026-03-07T07:44:10.6388769' AS DateTime2), 35)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (36, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627307/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/adiccavhqqasqrucyl1d.webp', N'img0036', 1, 1, CAST(N'2026-03-07T07:44:10.6388771' AS DateTime2), 36)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (37, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627307/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/c9arqnzryd9piztysdq7.png', N'img0037', 1, 1, CAST(N'2026-03-07T07:44:10.6388772' AS DateTime2), 37)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (38, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627307/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/ewwiuv3qiuqsdexlxvdn.jpg', N'img0038', 1, 1, CAST(N'2026-03-07T07:44:10.6388773' AS DateTime2), 38)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (39, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627306/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/nimlqjjfxtrob5ycvqfy.webp', N'img0039', 1, 1, CAST(N'2026-03-07T07:44:10.6388775' AS DateTime2), 39)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (40, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627308/WebBanThuocBVTV/phan%20bon%20va%20hoa%20chat/rcjm3d3htnrvekc3tbh2.png', N'img0040', 1, 1, CAST(N'2026-03-07T07:44:10.6388776' AS DateTime2), 40)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (41, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627394/WebBanThuocBVTV/thuoc%20tru%20benh/lkle2ludf4mmjpxxouuj.png', N'img0041', 1, 1, CAST(N'2026-03-07T07:44:10.6388778' AS DateTime2), 41)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (42, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627394/WebBanThuocBVTV/thuoc%20tru%20benh/ke3jyctmiriffdg0cgij.jpg', N'img0042', 1, 1, CAST(N'2026-03-07T07:44:10.6388779' AS DateTime2), 42)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (43, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627393/WebBanThuocBVTV/thuoc%20tru%20benh/xjgd2edgpf2tycfu3pz8.png', N'img0043', 1, 1, CAST(N'2026-03-07T07:44:10.6388781' AS DateTime2), 43)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (44, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627393/WebBanThuocBVTV/thuoc%20tru%20benh/dyxeitgrspswm5bmz6ua.jpg', N'img0044', 1, 1, CAST(N'2026-03-07T07:44:10.6388782' AS DateTime2), 44)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (45, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627393/WebBanThuocBVTV/thuoc%20tru%20benh/xbricq1f6is32zzaqxmk.png', N'img0045', 1, 1, CAST(N'2026-03-07T07:44:10.6388784' AS DateTime2), 45)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (46, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627392/WebBanThuocBVTV/thuoc%20tru%20benh/kozqap8diqjsk5nkd7hc.png', N'img0046', 1, 1, CAST(N'2026-03-07T07:44:10.6388785' AS DateTime2), 46)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (47, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627392/WebBanThuocBVTV/thuoc%20tru%20benh/v5dnlgntzyxephsvv5ng.png', N'img0047', 1, 1, CAST(N'2026-03-07T07:44:10.6388786' AS DateTime2), 47)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (48, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627392/WebBanThuocBVTV/thuoc%20tru%20benh/avczmqhyslc8dc0rd3bx.png', N'img0048', 1, 1, CAST(N'2026-03-07T07:44:10.6388788' AS DateTime2), 48)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (49, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627392/WebBanThuocBVTV/thuoc%20tru%20benh/ezyeevxyqein8u4ybmzj.jpg', N'img0049', 1, 1, CAST(N'2026-03-07T07:44:10.6388789' AS DateTime2), 49)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (50, N'https://res.cloudinary.com/duouljna1/image/upload/v1755352284/WebBanThuocBVTV/thuoc tru sau/thuoc-tru-sau-regent-01.jpg.jpg', N'img0161', 1, 1, CAST(N'2026-03-07T07:44:10.6388790' AS DateTime2), 50)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (51, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627391/WebBanThuocBVTV/thuoc%20tru%20benh/uk8zgo4tkrqgi3zna1n2.png', N'img0051', 1, 1, CAST(N'2026-03-07T07:44:10.6388792' AS DateTime2), 51)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (52, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627391/WebBanThuocBVTV/thuoc%20tru%20benh/vyinzmzoxwim4sawaakc.png', N'img0052', 1, 1, CAST(N'2026-03-07T07:44:10.6388793' AS DateTime2), 52)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (53, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627390/WebBanThuocBVTV/thuoc%20tru%20benh/fgvcxexlrxlhfql3xgaz.png', N'img0053', 1, 1, CAST(N'2026-03-07T07:44:10.6388795' AS DateTime2), 53)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (54, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627390/WebBanThuocBVTV/thuoc%20tru%20benh/upbmw7jyrqesz4ozjmke.png', N'img0054', 1, 1, CAST(N'2026-03-07T07:44:10.6388796' AS DateTime2), 54)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (55, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627390/WebBanThuocBVTV/thuoc%20tru%20benh/iw5otblnoutpqzyfx6ei.png', N'img0055', 1, 1, CAST(N'2026-03-07T07:44:10.6388797' AS DateTime2), 55)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (56, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627389/WebBanThuocBVTV/thuoc%20tru%20benh/fc7xy5sffzbswqb69gdg.png', N'img0056', 1, 1, CAST(N'2026-03-07T07:44:10.6388799' AS DateTime2), 56)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (57, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627388/WebBanThuocBVTV/thuoc%20tru%20benh/xtt3zv1vggn1c0njfvwy.png', N'img0057', 1, 1, CAST(N'2026-03-07T07:44:10.6388800' AS DateTime2), 57)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (58, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627388/WebBanThuocBVTV/thuoc%20tru%20benh/wjqdemnptpyzfrkibpb8.jpg', N'img0058', 1, 1, CAST(N'2026-03-07T07:44:10.6388801' AS DateTime2), 58)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (59, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627387/WebBanThuocBVTV/thuoc%20tru%20benh/grvqf5hvm68mzemdppna.webp', N'img0059', 1, 1, CAST(N'2026-03-07T07:44:10.6388803' AS DateTime2), 59)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (60, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627387/WebBanThuocBVTV/thuoc%20tru%20benh/bvmpmxs6bnvsoki3l3ak.png', N'img0060', 1, 1, CAST(N'2026-03-07T07:44:10.6388804' AS DateTime2), 60)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (61, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627387/WebBanThuocBVTV/thuoc%20tru%20benh/husymifpwtcptmwpa4ad.webp', N'img0061', 1, 1, CAST(N'2026-03-07T07:44:10.6388806' AS DateTime2), 61)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (62, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627387/WebBanThuocBVTV/thuoc%20tru%20benh/lmdllx6bdom0mf389zfq.png', N'img0062', 1, 1, CAST(N'2026-03-07T07:44:10.6388807' AS DateTime2), 62)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (63, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627386/WebBanThuocBVTV/thuoc%20tru%20benh/caabcachfxhnyztrcxpn.png', N'img0063', 1, 1, CAST(N'2026-03-07T07:44:10.6388808' AS DateTime2), 63)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (64, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627386/WebBanThuocBVTV/thuoc%20tru%20benh/wmmbzhnbuefm2fy4comb.png', N'img0064', 1, 1, CAST(N'2026-03-07T07:44:10.6388810' AS DateTime2), 64)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (65, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627386/WebBanThuocBVTV/thuoc%20tru%20benh/nczfc7pmpf0dos3qwhb0.jpg', N'img0065', 1, 1, CAST(N'2026-03-07T07:44:10.6388811' AS DateTime2), 65)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (66, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627386/WebBanThuocBVTV/thuoc%20tru%20benh/bqozc9ntwikbn3n6jaox.png', N'img0066', 1, 1, CAST(N'2026-03-07T07:44:10.6388813' AS DateTime2), 66)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (68, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627385/WebBanThuocBVTV/thuoc%20tru%20benh/wkhjwo5hoptc7aqpdgrh.png', N'img0068', 1, 1, CAST(N'2026-03-07T07:44:10.6388814' AS DateTime2), 68)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (69, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627385/WebBanThuocBVTV/thuoc%20tru%20benh/zvjirnjfkjup4imfwif5.png', N'img0069', 1, 1, CAST(N'2026-03-07T07:44:10.6388815' AS DateTime2), 69)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (70, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627384/WebBanThuocBVTV/thuoc%20tru%20benh/dtyrnowitq0tctfq4zwb.jpg', N'img0070', 1, 1, CAST(N'2026-03-07T07:44:10.6388817' AS DateTime2), 70)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (71, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627384/WebBanThuocBVTV/thuoc%20tru%20benh/eo4keejaoaewx9q4wwel.jpg', N'img0071', 1, 1, CAST(N'2026-03-07T07:44:10.6388818' AS DateTime2), 71)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (72, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627384/WebBanThuocBVTV/thuoc%20tru%20benh/kpk54tnvo9bllmiiaq9l.png', N'img0072', 1, 1, CAST(N'2026-03-07T07:44:10.6388820' AS DateTime2), 72)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (73, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627383/WebBanThuocBVTV/thuoc%20tru%20benh/flre8xoud737daonms4h.jpg', N'img0073', 1, 1, CAST(N'2026-03-07T07:44:10.6388821' AS DateTime2), 73)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (74, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627383/WebBanThuocBVTV/thuoc%20tru%20benh/gpy6db5kgbgqtctvdggd.png', N'img0074', 1, 1, CAST(N'2026-03-07T07:44:10.6388823' AS DateTime2), 74)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (75, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627383/WebBanThuocBVTV/thuoc%20tru%20benh/uynvkdtc506jp7lw0x0o.png', N'img0075', 1, 1, CAST(N'2026-03-07T07:44:10.6388824' AS DateTime2), 75)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (76, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627383/WebBanThuocBVTV/thuoc%20tru%20benh/xqmbfdqzp4ogxg7jzlh8.png', N'img0076', 1, 1, CAST(N'2026-03-07T07:44:10.6388825' AS DateTime2), 76)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (77, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627382/WebBanThuocBVTV/thuoc%20tru%20benh/ol1xrck57c1ofcjir5cg.jpg', N'img0077', 1, 1, CAST(N'2026-03-07T07:44:10.6388827' AS DateTime2), 77)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (78, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627390/WebBanThuocBVTV/thuoc%20tru%20benh/ihllx57y5vrnkrsdqkz1.png', N'img0078', 1, 1, CAST(N'2026-03-07T07:44:10.6388828' AS DateTime2), 78)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (79, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627389/WebBanThuocBVTV/thuoc%20tru%20benh/xnidje0zro6j3hv5upzi.jpg', N'img0079', 1, 1, CAST(N'2026-03-07T07:44:10.6388830' AS DateTime2), 79)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (80, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627388/WebBanThuocBVTV/thuoc%20tru%20benh/csbfruemsuvxb4odqzx8.jpg', N'img0080', 1, 1, CAST(N'2026-03-07T07:44:10.6388831' AS DateTime2), 80)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (81, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627441/WebBanThuocBVTV/thuoc%20tru%20co/uwf4h3o3ygwtnz32x5yt.png', N'img0081', 1, 1, CAST(N'2026-03-07T07:44:10.6388832' AS DateTime2), 81)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (82, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627441/WebBanThuocBVTV/thuoc%20tru%20co/hxzuoxlvksg7jy2rgva0.png', N'img0082', 1, 1, CAST(N'2026-03-07T07:44:10.6388834' AS DateTime2), 82)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (83, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627440/WebBanThuocBVTV/thuoc%20tru%20co/cgkxgd7repxwjkdgizoa.webp', N'img0083', 1, 1, CAST(N'2026-03-07T07:44:10.6388835' AS DateTime2), 83)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (84, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627440/WebBanThuocBVTV/thuoc%20tru%20co/usl0nj7qawprezedcqfl.png', N'img0084', 1, 1, CAST(N'2026-03-07T07:44:10.6388837' AS DateTime2), 84)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (85, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627439/WebBanThuocBVTV/thuoc%20tru%20co/cenvg8t4zdzsl5vhz4yd.jpg', N'img0085', 1, 1, CAST(N'2026-03-07T07:44:10.6388838' AS DateTime2), 85)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (86, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627439/WebBanThuocBVTV/thuoc%20tru%20co/ign1dr7t00xg2bche62q.png', N'img0086', 1, 1, CAST(N'2026-03-07T07:44:10.6388840' AS DateTime2), 86)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (87, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627439/WebBanThuocBVTV/thuoc%20tru%20co/e0n1piko7vx4fifxy2vh.png', N'img0087', 1, 1, CAST(N'2026-03-07T07:44:10.6388841' AS DateTime2), 87)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (88, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627438/WebBanThuocBVTV/thuoc%20tru%20co/oravhfr5xkudqvuj4wlv.png', N'img0088', 1, 1, CAST(N'2026-03-07T07:44:10.6388842' AS DateTime2), 88)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (89, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627441/WebBanThuocBVTV/thuoc%20tru%20co/rhsalluh3j3n1qqr0ugs.png', N'img0089', 1, 1, CAST(N'2026-03-07T07:44:10.6388844' AS DateTime2), 89)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (90, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627437/WebBanThuocBVTV/thuoc%20tru%20co/szqmbnzvnpuhthiasnxi.png', N'img0090', 1, 1, CAST(N'2026-03-07T07:44:10.6388845' AS DateTime2), 90)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (91, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627434/WebBanThuocBVTV/thuoc%20tru%20co/ekllngg5btr6peefho3t.png', N'img0091', 1, 1, CAST(N'2026-03-07T07:44:10.6388846' AS DateTime2), 91)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (92, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627434/WebBanThuocBVTV/thuoc%20tru%20co/yhe5vpowvzb1c2eru5q3.jpg', N'img0092', 1, 1, CAST(N'2026-03-07T07:44:10.6388848' AS DateTime2), 92)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (93, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627433/WebBanThuocBVTV/thuoc%20tru%20co/oc8rtwequawab9sbauom.png', N'img0093', 1, 1, CAST(N'2026-03-07T07:44:10.6388849' AS DateTime2), 93)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (94, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627433/WebBanThuocBVTV/thuoc%20tru%20co/j4saiqe44gvsfyy9lsx0.webp', N'img0094', 1, 1, CAST(N'2026-03-07T07:44:10.6388851' AS DateTime2), 94)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (95, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627433/WebBanThuocBVTV/thuoc%20tru%20co/y2mdenwxctecbld0dmvd.png', N'img0095', 1, 1, CAST(N'2026-03-07T07:44:10.6388852' AS DateTime2), 95)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (96, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627432/WebBanThuocBVTV/thuoc%20tru%20co/tpiycdm1ehsute8ju7ds.png', N'img0096', 1, 1, CAST(N'2026-03-07T07:44:10.6388854' AS DateTime2), 96)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (97, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627432/WebBanThuocBVTV/thuoc%20tru%20co/tzdd0imesbze6tgll9hg.png', N'img0097', 1, 1, CAST(N'2026-03-07T07:44:10.6388855' AS DateTime2), 97)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (98, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627431/WebBanThuocBVTV/thuoc%20tru%20co/ajj0sukoxjl9o6xnawbh.jpg', N'img0098', 1, 1, CAST(N'2026-03-07T07:44:10.6388856' AS DateTime2), 98)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (99, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627431/WebBanThuocBVTV/thuoc%20tru%20co/siikjlvp5q6od3xx2to0.png', N'img0099', 1, 1, CAST(N'2026-03-07T07:44:10.6388858' AS DateTime2), 99)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (100, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627431/WebBanThuocBVTV/thuoc%20tru%20co/w7nyo58zxjdvgh9l9dpu.png', N'img0100', 1, 1, CAST(N'2026-03-07T07:44:10.6388859' AS DateTime2), 100)
GO
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (101, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627430/WebBanThuocBVTV/thuoc%20tru%20co/w2kp7pedofgr3atiia2g.png', N'img0101', 1, 1, CAST(N'2026-03-07T07:44:10.6388861' AS DateTime2), 101)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (102, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627430/WebBanThuocBVTV/thuoc%20tru%20co/y68tsg4tas3wd2icjxg8.png', N'img0102', 1, 1, CAST(N'2026-03-07T07:44:10.6388862' AS DateTime2), 102)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (103, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627430/WebBanThuocBVTV/thuoc%20tru%20co/qjhzgpf6ts8umsnwy2l8.png', N'img0103', 1, 1, CAST(N'2026-03-07T07:44:10.6388863' AS DateTime2), 103)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (104, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627429/WebBanThuocBVTV/thuoc%20tru%20co/uxbhyyifmu0jcaruzgje.webp', N'img0104', 1, 1, CAST(N'2026-03-07T07:44:10.6388865' AS DateTime2), 104)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (105, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627428/WebBanThuocBVTV/thuoc%20tru%20co/xkadeoazhlvktarjhezg.png', N'img0105', 1, 1, CAST(N'2026-03-07T07:44:10.6388866' AS DateTime2), 105)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (106, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627428/WebBanThuocBVTV/thuoc%20tru%20co/pqcwjndvkl9riyx2d7mr.png', N'img0106', 1, 1, CAST(N'2026-03-07T07:44:10.6388868' AS DateTime2), 106)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (107, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627427/WebBanThuocBVTV/thuoc%20tru%20co/u0bvas0sev5gprne7u67.jpg', N'img0107', 1, 1, CAST(N'2026-03-07T07:44:10.6388869' AS DateTime2), 107)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (108, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627427/WebBanThuocBVTV/thuoc%20tru%20co/csdicnuacsjbioqebfnf.png', N'img0108', 1, 1, CAST(N'2026-03-07T07:44:10.6388870' AS DateTime2), 108)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (109, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627426/WebBanThuocBVTV/thuoc%20tru%20co/ve4ctgvgzder3ou2avrr.png', N'img0109', 1, 1, CAST(N'2026-03-07T07:44:10.6388872' AS DateTime2), 109)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (110, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627426/WebBanThuocBVTV/thuoc%20tru%20co/np9n4jws2fujzj89uvpg.png', N'img0110', 1, 1, CAST(N'2026-03-07T07:44:10.6388873' AS DateTime2), 110)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (111, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627462/WebBanThuocBVTV/thuoc%20tru%20sau/bx3yjgcs2azhjfr3gxpl.png', N'img0111', 1, 1, CAST(N'2026-03-07T07:44:10.6388875' AS DateTime2), 111)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (112, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627461/WebBanThuocBVTV/thuoc%20tru%20sau/key6rzpxdsilylmgmnug.png', N'img0112', 1, 1, CAST(N'2026-03-07T07:44:10.6388876' AS DateTime2), 112)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (113, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627461/WebBanThuocBVTV/thuoc%20tru%20sau/b6sfja8vbixjv5emrmvg.png', N'img0113', 1, 1, CAST(N'2026-03-07T07:44:10.6388877' AS DateTime2), 113)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (114, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627461/WebBanThuocBVTV/thuoc%20tru%20sau/fwrq0pft91vk0cvfixci.png', N'img0114', 1, 1, CAST(N'2026-03-07T07:44:10.6388879' AS DateTime2), 114)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (115, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627460/WebBanThuocBVTV/thuoc%20tru%20sau/th1vckdksnfsvolome5y.png', N'img0115', 1, 1, CAST(N'2026-03-07T07:44:10.6388880' AS DateTime2), 115)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (116, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627459/WebBanThuocBVTV/thuoc%20tru%20sau/ayasod8r7hoinujqa20e.png', N'img0116', 1, 1, CAST(N'2026-03-07T07:44:10.6388881' AS DateTime2), 116)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (117, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627459/WebBanThuocBVTV/thuoc%20tru%20sau/rw3jtbwvfvbk9davey0m.png', N'img0117', 1, 1, CAST(N'2026-03-07T07:44:10.6388883' AS DateTime2), 117)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (118, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627458/WebBanThuocBVTV/thuoc%20tru%20sau/ytthu98oaddtk1nlfknn.png', N'img0118', 1, 1, CAST(N'2026-03-07T07:44:10.6388884' AS DateTime2), 118)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (119, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627458/WebBanThuocBVTV/thuoc%20tru%20sau/vyfkm3ecc2m3pubompqn.png', N'img0119', 1, 1, CAST(N'2026-03-07T07:44:10.6388886' AS DateTime2), 119)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (120, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627457/WebBanThuocBVTV/thuoc%20tru%20sau/baf8oekppus2mc6fjupi.png', N'img0120', 1, 1, CAST(N'2026-03-07T07:44:10.6388887' AS DateTime2), 120)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (121, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627456/WebBanThuocBVTV/thuoc%20tru%20sau/xwbflorsdhzqnizzqqw5.png', N'img0121', 1, 1, CAST(N'2026-03-07T07:44:10.6388889' AS DateTime2), 121)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (122, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627456/WebBanThuocBVTV/thuoc%20tru%20sau/ugq4zukriwzgqdmyarvx.png', N'img0122', 1, 1, CAST(N'2026-03-07T07:44:10.6388890' AS DateTime2), 122)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (123, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627456/WebBanThuocBVTV/thuoc%20tru%20sau/b9fyv2r91x3rj7kx9b2z.jpg', N'img0123', 1, 1, CAST(N'2026-03-07T07:44:10.6388891' AS DateTime2), 123)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (124, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627455/WebBanThuocBVTV/thuoc%20tru%20sau/icpkbsxdghjygqcnrcjz.png', N'img0124', 1, 1, CAST(N'2026-03-07T07:44:10.6388893' AS DateTime2), 124)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (125, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627455/WebBanThuocBVTV/thuoc%20tru%20sau/fpt4nnkkhishwrmk3yze.png', N'img0125', 1, 1, CAST(N'2026-03-07T07:44:10.6388894' AS DateTime2), 125)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (126, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627454/WebBanThuocBVTV/thuoc%20tru%20sau/j5ocenmjnrp6wlqzpgqe.png', N'img0126', 1, 1, CAST(N'2026-03-07T07:44:10.6388896' AS DateTime2), 126)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (127, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627454/WebBanThuocBVTV/thuoc%20tru%20sau/gcz0qypdrup7klwkdb52.png', N'img0127', 1, 1, CAST(N'2026-03-07T07:44:10.6388897' AS DateTime2), 127)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (128, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627453/WebBanThuocBVTV/thuoc%20tru%20sau/zxdvdu32koc4sscitsb6.png', N'img0128', 1, 1, CAST(N'2026-03-07T07:44:10.6388898' AS DateTime2), 128)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (129, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627452/WebBanThuocBVTV/thuoc%20tru%20sau/ybojxhv6gfgvdt6wmzay.png', N'img0129', 1, 1, CAST(N'2026-03-07T07:44:10.6388900' AS DateTime2), 129)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (130, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627452/WebBanThuocBVTV/thuoc%20tru%20sau/n22aclgzwhhh1kbfbeun.webp', N'img0130', 1, 1, CAST(N'2026-03-07T07:44:10.6388901' AS DateTime2), 130)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (131, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627452/WebBanThuocBVTV/thuoc%20tru%20sau/szwpxfyczpepdrj9upfb.jpg', N'img0131', 1, 1, CAST(N'2026-03-07T07:44:10.6388903' AS DateTime2), 131)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (132, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627451/WebBanThuocBVTV/thuoc%20tru%20sau/wtbwj1oxa5odxri2feyx.png', N'img0132', 1, 1, CAST(N'2026-03-07T07:44:10.6388904' AS DateTime2), 132)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (133, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627451/WebBanThuocBVTV/thuoc%20tru%20sau/agqo4ymtf1a4uylshin3.png', N'img0133', 1, 1, CAST(N'2026-03-07T07:44:10.6388905' AS DateTime2), 133)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (134, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627450/WebBanThuocBVTV/thuoc%20tru%20sau/evr9xsmkjdej9luzgcoh.png', N'img0134', 1, 1, CAST(N'2026-03-07T07:44:10.6388907' AS DateTime2), 134)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (135, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627450/WebBanThuocBVTV/thuoc%20tru%20sau/cyfhhtzcpcomvjcnalji.jpg', N'img0135', 1, 1, CAST(N'2026-03-07T07:44:10.6388908' AS DateTime2), 135)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (136, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627450/WebBanThuocBVTV/thuoc%20tru%20sau/plxojwkrx7gveydsbup1.png', N'img0136', 1, 1, CAST(N'2026-03-07T07:44:10.6388910' AS DateTime2), 136)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (137, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627449/WebBanThuocBVTV/thuoc%20tru%20sau/mxijfhik5egkka3dmxpe.png', N'img0137', 1, 1, CAST(N'2026-03-07T07:44:10.6388911' AS DateTime2), 137)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (138, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627448/WebBanThuocBVTV/thuoc%20tru%20sau/onouedh8r4bozxxbwfmb.jpg', N'img0138', 1, 1, CAST(N'2026-03-07T07:44:10.6388912' AS DateTime2), 138)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (139, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627447/WebBanThuocBVTV/thuoc%20tru%20sau/rckw7eif0ndrbnprhus5.png', N'img0139', 1, 1, CAST(N'2026-03-07T07:44:10.6388914' AS DateTime2), 139)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (140, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627447/WebBanThuocBVTV/thuoc%20tru%20sau/bmasnxnyf8qcfcjsxk1o.png', N'img0140', 1, 1, CAST(N'2026-03-07T07:44:10.6388915' AS DateTime2), 140)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (141, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627446/WebBanThuocBVTV/thuoc%20tru%20sau/feqygbhgd2qkdc1bdiv1.png', N'img0141', 1, 1, CAST(N'2026-03-07T07:44:10.6388916' AS DateTime2), 141)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (142, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627446/WebBanThuocBVTV/thuoc%20tru%20sau/xhqw7ujd3r4yjaizsyna.png', N'img0142', 1, 1, CAST(N'2026-03-07T07:44:10.6388918' AS DateTime2), 142)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (143, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627463/WebBanThuocBVTV/thuoc%20tru%20sau/uhv2vmxugdgt0wslwsnm.png', N'img0143', 1, 1, CAST(N'2026-03-07T07:44:10.6388919' AS DateTime2), 143)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (144, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627462/WebBanThuocBVTV/thuoc%20tru%20sau/z3tp8k2261jdjnzptzse.png', N'img0144', 1, 1, CAST(N'2026-03-07T07:44:10.6388921' AS DateTime2), 144)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (145, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627460/WebBanThuocBVTV/thuoc%20tru%20sau/cpndz8kg11rs6tiy3asz.png', N'img0145', 1, 1, CAST(N'2026-03-07T07:44:10.6388922' AS DateTime2), 145)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (146, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627459/WebBanThuocBVTV/thuoc%20tru%20sau/npvwetycha0tihe3htyj.jpg', N'img0146', 1, 1, CAST(N'2026-03-07T07:44:10.6388923' AS DateTime2), 146)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (147, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627457/WebBanThuocBVTV/thuoc%20tru%20sau/qxpwfgnyz4kmg7l9rj9e.png', N'img0147', 1, 1, CAST(N'2026-03-07T07:44:10.6388925' AS DateTime2), 147)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (148, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627452/WebBanThuocBVTV/thuoc%20tru%20sau/n22aclgzwhhh1kbfbeun.webp', N'img0148', 1, 1, CAST(N'2026-03-07T07:44:10.6388926' AS DateTime2), 148)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (149, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627446/WebBanThuocBVTV/thuoc%20tru%20sau/qzk8hci2pcec5ab1hapq.png', N'img0149', 1, 1, CAST(N'2026-03-07T07:44:10.6388928' AS DateTime2), 149)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (150, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627446/WebBanThuocBVTV/thuoc%20tru%20sau/qzk8hci2pcec5ab1hapq.png', N'img0150', 1, 1, CAST(N'2026-03-07T07:44:10.6388929' AS DateTime2), 150)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (151, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627449/WebBanThuocBVTV/thuoc%20tru%20sau/qe2ho5f5v7pnx01vvwjx.png', N'img0151', 1, 1, CAST(N'2026-03-07T07:44:10.6388930' AS DateTime2), 151)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (152, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627441/WebBanThuocBVTV/thuoc%20tru%20co/hxzuoxlvksg7jy2rgva0.png', N'img0152', 1, 1, CAST(N'2026-03-07T07:44:10.6388932' AS DateTime2), 152)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (153, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627436/WebBanThuocBVTV/thuoc%20tru%20co/r6uxi7paadws6kk6y2kv.png', N'img0153', 1, 1, CAST(N'2026-03-07T07:44:10.6388933' AS DateTime2), 153)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (154, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627436/WebBanThuocBVTV/thuoc%20tru%20co/slstxruk6mdvakwimuen.png', N'img0154', 1, 1, CAST(N'2026-03-07T07:44:10.6388934' AS DateTime2), 154)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (155, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627435/WebBanThuocBVTV/thuoc%20tru%20co/hjd8oy6f2pu3l9fkr6bq.webp', N'img0155', 1, 1, CAST(N'2026-03-07T07:44:10.6388936' AS DateTime2), 155)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (156, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627435/WebBanThuocBVTV/thuoc%20tru%20co/oww5ti6tyn5ppxfms0ra.png', N'img0156', 1, 1, CAST(N'2026-03-07T07:44:10.6388937' AS DateTime2), 156)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (157, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627435/WebBanThuocBVTV/thuoc%20tru%20co/a960aaxjwgqv5s1q5zbm.png', N'img0157', 1, 1, CAST(N'2026-03-07T07:44:10.6388939' AS DateTime2), 157)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (158, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627426/WebBanThuocBVTV/thuoc%20tru%20co/pmpfisqtuuh8bwukxfa0.jpg', N'img0158', 1, 1, CAST(N'2026-03-07T07:44:10.6388940' AS DateTime2), 158)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (159, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627437/WebBanThuocBVTV/thuoc%20tru%20co/fwcdyvz0dk4wd2usisjn.png', N'img0159', 1, 1, CAST(N'2026-03-07T07:44:10.6388941' AS DateTime2), 159)
INSERT [dbo].[ProductImages] ([Id], [ImageUrl], [ImageName], [DisplayOrder], [IsMainImage], [CreatedAt], [ProductId]) VALUES (161, N'https://res.cloudinary.com/duouljna1/image/upload/v1747627436/WebBanThuocBVTV/thuoc%20tru%20co/r6uxi7paadws6kk6y2kv.png', NULL, 0, 1, CAST(N'2026-03-23T08:02:15.8900152' AS DateTime2), 160)
SET IDENTITY_INSERT [dbo].[ProductImages] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (1, N'sp0001', N'Vi lượng-BOROZINC', N'Bo và Kẽm là các yếu tố vi lượng thiết yếu cho cây trồng, hỗ trợ tổng hợp protein, enzyme và các hormone tăng trưởng. BOROZINC giúp ngăn ngừa các triệu chứng thiếu Bo và Kẽm như: lá non nhỏ, biến dạng, chuyển màu; chùn đọt, chết ngọn, rụng trái non; nứt trái, sượng trái, bọng ruột. Cải thiện hiệu suất sinh trưởng, đặc biệt hữu ích trong các giai đoạn nhạy cảm như ra hoa, thụ phấn, đậu trái. Tan nhanh và hoàn toàn trong nước, tạo môi trường pH tối ưu giúp cây hấp thụ nhanh chóng và triệt để.', N'### CÂY TRỒNG: Lúa
                    * **Đối tượng phòng trừ:** Rầy nâu
                    * **Liều lượng:** 1,0 kg/ha (Pha 50 – 60 g/bình 25 lít nước)
                    * **Cách sử dụng:** Phun ướt đều tán lá khi rầy vừa xuất hiện
                    * **Lượng nước phun:** Không xác định
                    * **Lưu ý:**
                      * Phun thuốc khi rầy vừa xuất hiện để đạt hiệu quả cao
                      * Có thể pha chung với thuốc BUTYL để tăng hiệu quả
                      * Tránh phun thuốc khi cây đang trổ hoa hoặc trời nắng nóng
                      * **Thời gian cách ly:** Ngưng phun thuốc trước khi thu hoạch 14 ngày
                    ---
                    ### Hướng dẫn an toàn và bảo quản
                    * **Bảo quản:** Giữ trong bao bì gốc, để nơi khô ráo, thoáng mát
                    * **An toàn:**
                      * Mang đầy đủ đồ bảo hộ lao động khi pha và phun thuốc
                      * Không ăn uống, hút thuốc khi đang pha và phun thuốc
                      * Không súc rửa dụng cụ ở nơi ao hồ nuôi cá hay nguồn nước sinh hoạt
                      * Để thuốc ở nơi an toàn, tránh xa tầm tay trẻ em
                      * Bỏ bao, gói, chai sau khi sử dụng hoặc tiêu hủy đúng quy định', N'Bo (B): 130.000 ppm (13% Boron); Kẽm (Zn): 40.000 ppm (4% Kẽm); Độ ẩm: 1%', CAST(180000.00 AS Decimal(18, 2)), 50, NULL, CAST(N'2025-05-08T00:00:00.0000000' AS DateTime2), N'Lúa', 4, 14, CAST(1.00 AS Decimal(18, 2)), N'Mang bảo hộ lao động. Không ăn uống khi phun. Bảo quản nơi khô ráo.', CAST(N'2026-03-07T07:44:10.6387655' AS DateTime2), NULL, 0, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (2, N'sp0002', N'TT-ANONIN 1EC', N'Thuốc trừ sâu sinh học, 100% nguồn gốc từ thực vật. Trừ sâu tơ bắp cải, sâu xanh cà chua, rầy bông xoài, sâu vẽ bùa trên cam. An toàn cho môi trường. Không để lại dư lượng trên cây trồng. Không diệt thiên địch. Liều lượng: Sâu cuốn lá lúa 50ml/bình 25 lít. Sâu tơ bắp cải, sâu xanh cà chua 100ml/bình 25 lít.', N'### Hướng dẫn sử dụng
                    * Phun khi sâu tuổi 1, 2.
                    * Phun ướt đều toàn cây.
                    * **Lượng nước phun:** 400 – 500 lít/ha.
                    ---
                    ### Hướng dẫn an toàn
                    * Mang đầy đủ đồ bảo hộ lao động.
                    * Không ăn uống, hút thuốc khi pha và phun thuốc.
                    * Không súc rửa dụng cụ phun xịt nơi ao hồ nuôi cá, nguồn nước sinh hoạt.
                    * Để thuốc nơi an toàn, tránh xa tầm tay trẻ em.
                    * Bỏ bao, gói, chai sau khi sử dụng hoặc tiêu huỷ đúng quy định.
                    ---
                    ### Sơ cứu khi ngộ độc
                    * **Nếu dính thuốc vào mắt:** Rửa ngay bằng nước sạch trong 15–20 phút.
                    * **Nếu dính vào da:** Rửa kỹ bằng xà phòng và nước.
                    * **Nếu có dấu hiệu ngộ độc thuốc:** Đưa đến cơ sở y tế gần nhất để kịp thời chữa trị và nhớ mang theo nhãn thuốc.', N'Annonin: 1% w/w; Phụ gia và dung môi: Vừa đủ 100% w/w; Quy cách: Chai 250ml', CAST(220000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa, Rau màu', 4, 3, CAST(0.50 AS Decimal(18, 2)), N'An toàn sinh học. Rửa sạch bằng nước nếu dính vào mắt. Lắc đều trước khi dùng.', CAST(N'2026-03-07T07:44:10.6387660' AS DateTime2), NULL, 0, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (3, N'sp0003', N'TT SNAILTA GOLD 750WP', N'Công thức mới với khả năng tác động mạnh lên hệ hô hấp và hệ tiêu hóa của ốc. Trừ ốc nhanh và mạnh, hiệu quả cao. Thời điểm xử lý: Trước khi sạ lúa. Liều lượng: 0.35kg/ha (350g/ha).', N'### Hướng dẫn sử dụng
* Pha 18g thuốc vào 16 lít nước, phun 2 bình cho 1000m².
* **Lượng nước phun:** 320 lít/ha.
* Phun thuốc khi ruộng có nước xâm xấp từ 1 – 5 cm.
---
### Lưu ý
* Không sử dụng thuốc để trộn giống.
* **Thời gian cách ly:** Không xác định.
---
### Hướng dẫn an toàn
* Mang đầy đủ đồ bảo hộ lao động khi pha chế và phun thuốc.
* Không ăn uống, hút thuốc trong khi sử dụng thuốc.
* Không súc rửa dụng cụ phun xịt ở ao hồ nuôi cá, nguồn nước sinh hoạt.
* Để thuốc nơi an toàn, tránh xa tầm tay trẻ em.
* Bao bì phải được tiêu hủy đúng quy định sau khi sử dụng.
---
### Sơ cứu khi ngộ độc
* **Nếu thuốc dính vào mắt:** Rửa ngay bằng nước sạch trong 15 – 20 phút.
* **Nếu thuốc dính vào da:** Rửa ngay bằng xà phòng và nước.
* **Nếu nuốt phải thuốc:** Đưa ngay đến cơ sở y tế gần nhất, mang theo nhãn thuốc để được chữa trị kịp thời.', N'Niclosamide: 750g/kg; Phụ gia: 250g/kg', CAST(220000.00 AS Decimal(18, 2)), 49, NULL, NULL, N'Lúa', 3, 0, CAST(0.35 AS Decimal(18, 2)), N'Nguy hiểm cho cá. Không rửa dụng cụ ở ao nuôi thủy sản. Mang găng tay khi pha.', CAST(N'2026-03-07T07:44:10.6387664' AS DateTime2), NULL, 0, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (4, N'sp0004', N'TANO_606', N'Giúp ra hoa sớm, đồng loạt. Tăng tỷ lệ thụ phấn, chống rụng hoa. Hạn chế rụng trái non trên cây ăn trái. Tăng tỷ lệ đậu trái trên các loại cây trồng. Chống hiện tượng sượng trái, khô múi trên sầu riêng, cam, quýt, bưởi,… Bổ sung thêm Bo cho cây, phòng ngừa triệu chứng thiếu Bo như nứt trái, bọng ruột, trái dị dạng, thối đáy trái trên cà chua, dưa hấu và cây ăn trái các loại. Bo giúp tăng cường khả năng hấp thu và vận chuyển Canxi trong cây trồng.', N'### CÂY TRỒNG: Cà chua
* **Đối tượng phòng trừ:** Sâu đục quả
* **Liều lượng:** 150 g/ha (Pha 8 g/bình 25 lít nước)
* **Cách sử dụng:** Phun ướt đều tán lá khi sâu non tuổi 1 – 2 mới xuất hiện.
* **Lượng nước phun:** 400 – 500 lít/ha.
* **Lưu ý:**
  * Phun thuốc khi sâu non tuổi 1 – 2 mới xuất hiện gây hại.
  * Đọc kỹ nhãn thuốc và nhãn phụ kèm theo trước khi sử dụng.
  * **Thời gian cách ly:** Ngưng phun thuốc 5 ngày trước khi thu hoạch.
### Hướng dẫn an toàn và bảo quản
* **Bảo quản:** Giữ trong bao bì gốc, để nơi khô ráo, thoáng mát.
* **An toàn:**
  * Mang đầy đủ đồ bảo hộ lao động khi pha và phun thuốc.
  * Không ăn uống, hút thuốc khi đang pha và phun thuốc.
  * Không súc rửa dụng cụ ở nơi ao hồ nuôi cá hay nguồn nước sinh hoạt.
  * Để thuốc ở nơi an toàn, tránh xa tầm tay trẻ em.
  * Bỏ bao, gói, chai sau khi sử dụng hoặc tiêu hủy đúng quy định.
### Sơ cứu khi ngộ độc
* **Nếu dính thuốc vào mắt:** Rửa ngay bằng nước sạch trong 15 – 20 phút.
* **Nếu dính vào da:** Rửa bằng xà phòng và nước sạch.
* **Nếu ngộ độc:** Đưa ngay đến cơ sở y tế gần nhất để điều trị và mang theo nhãn thuốc.', N'Hoạt chất: Boron 160g/lít; pHH2O: 7; Tỷ trọng: 1,2', CAST(130000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Cà chua, Cây ăn trái', 4, 5, CAST(0.15 AS Decimal(18, 2)), N'Tránh phun khi trời nắng gắt. Để xa tầm tay trẻ em.', CAST(N'2026-03-07T07:44:10.6387688' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (5, N'sp0005', N'TANO_601', N'Giúp cây trồng phát triển nhanh, khỏe bằng cách tăng cường khả năng hấp thu các chất dinh dưỡng trong đất và quang hợp mạnh mẽ. Dinh dưỡng cân đối, giúp tăng sức đề kháng trong điều kiện môi trường bất lợi như: phèn, mặn, khô hạn, sương muối,… Cây lớn nhanh, ra hoa sớm, tăng tỷ lệ đậu trái, hạt.', N'### CÂY TRỒNG: Lúa
* **Liều lượng:** 30 – 40ml hoặc 40 – 50ml cho bình 16 lít nước
* **Thời điểm bón:**
  * 10 – 15 NSS: Giai đoạn mạ – đẻ nhánh
  * 30 – 45 NSS: Giai đoạn tượng đòng
  * Trước trổ và sau trổ 7 – 10 ngày
  * Mỗi đợt phun 2 lần, cách nhau 5 – 7 ngày
### CÂY ĂN TRÁI
**Ví dụ:** Xoài, sầu riêng, chôm chôm, mãng cầu, nhãn, vải, nho, thanh long, cây có múi…
* **Liều lượng:** 40 – 50ml cho bình 16 lít nước
* **Thời điểm bón:**
  * Sắp ra hoa
  * Sau ra hoa
  * Sau đậu trái
  * Trái đang lớn
* **Phun định kỳ:** 10 – 15 ngày/lần
### Đậu đỗ
**Ví dụ:** Đậu phộng, đậu nành, đậu xanh...
* **Liều lượng:** 30 – 50ml cho bình 16 lít nước
* **Thời điểm bón:**
  * 10 – 12 ngày sau khi mọc
  * 30 – 35 ngày sau khi mọc
  * 50 – 55 ngày sau khi mọc
* **Phun định kỳ:** 7 – 10 ngày/lần
### Ghi chú
* Lắc đều trước khi sử dụng
* Phun lúc sáng sớm hoặc chiều mát
* Có thể pha chung với các loại thuốc trừ sâu bệnh và phân bón lá khác
### Hướng dẫn bảo quản
* Đậy nắp kín, cất giữ nơi thoáng mát
* Tránh xa trẻ em, thực phẩm, gia súc và nguồn nước đang dùng', N'Nts – P2O5hh – K2Ohh: 7% - 6% - 7%; MgO: 0,05%; Fe: 400ppm; Zn: 400ppm; Mn: 500ppm; Cu: 200ppm; B: 400ppm; Acid Humic: 0,3%; pHH2O: 8; Tỷ trọng: 1,3', CAST(120000.00 AS Decimal(18, 2)), 10, NULL, NULL, N'Lúa, Cây ăn trái', 4, 7, CAST(1.20 AS Decimal(18, 2)), N'Bảo quản nơi thoáng mát. Có thể pha chung với thuốc BVTV khác.', CAST(N'2026-03-07T07:44:10.6387691' AS DateTime2), NULL, 0, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (6, N'sp0006', N'SUNPHAT_KẼM', N'Sunphat Kẽm là muối Kẽm vô cơ, tan hoàn toàn trong nước, có tác dụng bổ sung nguyên tố Kẽm (Zn), là dinh dưỡng vi lượng rất cần thiết với các loại cây trồng, nhất là những cây có tính mẫn cảm cao với Kẽm như: lúa, cây có múi, nho, đậu nành, bắp, hành, khoai tây, cà chua. Kẽm là thành phần cấu tạo của một số men (enzym), có vai trò quan trọng trong quá trình sinh tổng hợp acid nucleic (RNA), protein và các hoóc môn tăng trưởng, giúp cây sinh trưởng và phát triển mạnh. Kẽm giúp tăng khả năng sử dụng lân và đạm, phát triển bộ rễ, tăng khả năng chịu hạn, chịu nóng, tăng tính kháng bệnh và giảm rụng trái non. Sản phẩm dùng để ngăn ngừa và khắc phục nhanh các triệu chứng thiếu Kẽm.', N'### Lúa
* **Liều lượng:** 1,8 lít/ha/vụ
* **Cách pha:**
  * Pha 600 ml/350 lít nước để phun cho 1 ha
  * Hoặc pha 40 ml/bình 25 lít
* **Cách sử dụng:** Phun ướt đều tán lá
* **Thời điểm bón:** Phun 3 lần/vụ
  * Lần 1: Giai đoạn đẻ nhánh
  * Lần 2: Giai đoạn làm đòng
  * Lần 3: Giai đoạn sau trổ 7 ngày
---
### Cà chua
* **Thời điểm bón:** Phun 4 lần/vụ
  * Lần 1: Giai đoạn phân cành
  * Lần 2: Giai đoạn trước ra hoa
  * Lần 3: Giai đoạn sau đậu quả
  * Lần 4: Phun sau lần ba 15 ngày
---
### Cây cam
* **Liều lượng:** 4,8 lít/ha/vụ
* **Cách pha:**
  * Pha 960 ml/800 lít nước để phun cho 1 ha
  * Hoặc pha 240 ml/phuy 200 lít
  * Tương đương 30 ml/bình 25 lít
* **Cách sử dụng:** Phun ướt đều tán lá
* **Thời điểm bón:** Phun 5 lần/vụ', N'ZnSO4•6H2O: 97,3% min; Tương đương 23,6% Kẽm (Zn) min', CAST(220000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa, Cà chua', 4, 7, CAST(1.80 AS Decimal(18, 2)), N'Dạng muối kẽm, tránh hít phải bột. Rửa sạch tay sau khi sử dụng.', CAST(N'2026-03-07T07:44:10.6387694' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (7, N'sp0007', N'SPC - NPK', N'Tăng độ cứng cây, chống chịu sâu bệnh và hạn chế đổ ngã. Kéo dài tuổi thọ lá đòng, giúp hạt chắc mẩy, sáng vàng, bông trĩu hạt. Giúp trái to, tăng độ ngọt, màu vỏ đẹp, nâng cao năng suất. Tăng khả năng chống chịu mặn, nắng nóng, hạn hán và sương muối.', N'### Lúa
* **Liều lượng:** 1,8 lít/ha/vụ
* **Cách pha:**
  * Pha 600 ml/350 lít nước để phun cho 1 ha
  * Hoặc pha 40 ml/bình 25 lít
* **Cách sử dụng:** Phun ướt đều tán lá
* **Thời điểm bón:** Phun 3 lần/vụ
  * Lần 1: Giai đoạn đẻ nhánh
  * Lần 2: Giai đoạn làm đòng
  * Lần 3: Giai đoạn sau trổ 7 ngày
---
### Cà chua
* **Thời điểm bón:** Phun 4 lần/vụ
  * Lần 1: Giai đoạn phân cành
  * Lần 2: Giai đoạn trước ra hoa
  * Lần 3: Giai đoạn sau đậu quả
  * Lần 4: Phun sau lần ba 15 ngày
---
### Cây cam
* **Liều lượng:** 4,8 lít/ha/vụ
* **Cách pha:**
  * Pha 960 ml/800 lít nước để phun cho 1 ha
  * Hoặc pha 240 ml/phuy 200 lít
  * Tương đương 30 ml/bình 25 lít
* **Cách sử dụng:** Phun ướt đều tán lá
* **Thời điểm bón:** Phun 5 lần/vụ', N'Axit Humic (C): 3%; Đạm tổng số (Nts): 5%; Lân hữu hiệu (P2O5hh): 5%; Kali hữu hiệu (K2Ohh): 15%; pHH2O: 11; Tỷ trọng: 1,298', CAST(200000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa, Cà chua', 4, 7, CAST(2.00 AS Decimal(18, 2)), N'Phân bón an toàn. Tránh tiếp xúc trực tiếp với vết thương hở.', CAST(N'2026-03-07T07:44:10.6387698' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (8, N'sp0008', N'TT BIOBECA 0.1SP', N'TT BIOBECA 0.1SP giúp giữ xanh lá đòng, vô gạo nhanh, hạt chắc đầy bông và sáng màu trên lúa. Tăng trọng lượng trái, trái bóng đẹp trên cà chua, thanh long; tăng sinh khối trên bắp cải, hồ tiêu. Kích thích rễ phát triển, phát triển chồi, đọt non, cơi đọt và mầm hoa. Tăng khả năng thụ phấn, đậu trái non và nâng cao sức đề kháng của cây trồng trước sâu bệnh và điều kiện bất lợi như hạn hán, lạnh, úng, phèn, mặn, ngộ độc.', N'### Trường hợp đặc biệt
* Có thể phun khi cây gặp điều kiện bất lợi như: hạn hán, nhiễm phèn, nhiễm mặn, ngộ độc...
* **Thời gian cách ly:** 7 ngày
---
### Hướng dẫn an toàn
* Mang đầy đủ đồ bảo hộ lao động khi pha và phun thuốc
* Không ăn uống, hút thuốc trong quá trình sử dụng
* Không súc rửa dụng cụ phun xịt tại ao hồ nuôi cá hoặc nguồn nước sinh hoạt
* Để thuốc nơi an toàn, tránh xa tầm tay trẻ em
* Bao bì, chai lọ sau sử dụng cần được tiêu hủy đúng quy định
---
### Sơ cứu khi ngộ độc
* **Nếu thuốc dính vào mắt:** Rửa ngay bằng nước sạch trong 15 – 20 phút
* **Nếu thuốc dính vào da:** Rửa kỹ bằng xà phòng và nước
* **Nếu có dấu hiệu ngộ độc:** Đưa ngay đến cơ sở y tế gần nhất và mang theo nhãn thuốc để được điều trị kịp thời', N'Brassinolide: 0,1% w/w; Phụ gia: vừa đủ 100% w/w; Liều lượng: 6g/bình 25 lít', CAST(190000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa, Rau màu', 4, 7, CAST(0.24 AS Decimal(18, 2)), N'Kích thích sinh trưởng an toàn. Bảo quản trong bao bì kín.', CAST(N'2026-03-07T07:44:10.6387701' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (9, N'sp0009', N'SPC_MKP', N'Kích thích phát triển bộ rễ và giúp cây trồng phát triển khỏe mạnh trong điều kiện môi trường bất lợi như ngập úng, nhiễm độc phèn và ngộ độc hữu cơ. Tăng cường khả năng hấp thu phân bón và các dưỡng chất khác trong đất. Thúc đẩy ra hoa tập trung, trái to, tăng độ ngọt. Giúp lá non mau trưởng thành, thuận lợi cho xử lý ra hoa trái vụ.', N'### Cây ăn trái
**Ví dụ:** Cam, quýt, xoài, nhãn...
* **Liều lượng:**
  * 60 – 100g/8 lít nước
  * Hoặc 1,5 – 2,5kg/phuy 200 lít
* **Thời điểm bón:**
  * Phân hóa mầm hoa
  * Trái non và dưỡng trái
---
### Rau
**Ví dụ:** Dưa hấu, dưa leo, cà chua, khổ qua, hành, tỏi...
* **Liều lượng:**
  * 20 – 40g/8 lít nước
  * Hoặc 0,5 – 1kg/phuy 200 lít
* **Thời điểm bón:**
  * Rau ăn trái: sau hồi xanh, trước ra hoa, trái non
  * Rau lấy củ: sau hồi xanh, phun 1–2 lần/vụ
---
### Cây lương thực
**Ví dụ:** Lúa, bắp...
* **Liều lượng:**
  * 40 – 80g/8 lít nước
  * Hoặc 1 – 2kg/phuy 200 lít
* **Thời điểm bón:** 30, 45, 55 ngày sau gieo
---
### Cây công nghiệp
**Ví dụ:** Tiêu, cà phê...
* **Liều lượng:** 40 – 80g/8 lít nước
* **Thời điểm bón:** Trước và sau ra hoa
---
### Hoa, cây cảnh
* **Liều lượng:** 20 – 40g/8 lít nước
* **Thời điểm bón:** Sau trồng 14 ngày hoặc khi hình thành nụ
---
### Lưu ý
* Không phun khi trời nắng gắt hoặc cây đang nở hoa rộ
* Phun ướt đều tán lá
* Không pha chung với phân chứa **Canxi (Ca)** và **Magie (Mg)**
---
### Hướng dẫn an toàn và bảo quản
* **Bảo quản:** Nơi khô ráo, thoáng mát, bao bì kín
* **An toàn:** Tránh xa tầm tay trẻ em, thực phẩm và nguồn nước sinh hoạt', N'Lân (P2O5): 52%; Kali (K2O): 34%; Hình thức: Muối vô cơ, dạng tinh thể, màu trắng', CAST(230000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Cây ăn trái, Rau', 4, 7, CAST(3.00 AS Decimal(18, 2)), N'Không pha chung với phân chứa Canxi và Magie để tránh kết tủa.', CAST(N'2026-03-07T07:44:10.6387704' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (10, N'sp0010', N'SPC_KALI_SILIC', N'Hạn chế chiều cao cây, làm lá dày và dẹt ngắn, giúp phòng chống đổ ngã. Phòng tránh các bệnh như lem lép hạt, đốm vằn, đạo ôn, thối trái. Tăng cường khả năng chống chịu cho cây trồng trong điều kiện bất lợi như giá rét, hạn hán, mặn, phèn và ngộ độc hữu cơ. Kích thích bộ rễ hoạt động mạnh, giúp cây hấp thu dinh dưỡng tốt hơn. Cải thiện chất lượng quả, giúp quả to, ngọt, màu sắc vỏ đẹp, hạt sáng và mẩy.', N'### Lúa
* **Liều lượng:** 1,8 lít/ha/vụ
* **Cách pha:**
  * 600 ml / 350 lít nước cho 1 ha
  * Hoặc 40 ml / bình 25 lít
* **Thời điểm bón:**
  * Lần 1: Giai đoạn đẻ nhánh
  * Lần 2: Giai đoạn làm đòng
  * Lần 3: Giai đoạn sau trổ 7 ngày
* **Cách sử dụng:** Phun ướt đều tán lá
---
### Cà chua
* **Liều lượng:** 2,4 lít/ha/vụ
* **Cách pha:**
  * 600 ml / 350 lít nước cho 1 ha
  * Hoặc 40 ml / bình 25 lít
* **Thời điểm bón:**
  * Lần 1: Giai đoạn phân cành
  * Lần 2: Giai đoạn trước ra hoa
  * Lần 3: Giai đoạn sau đậu quả
  * Lần 4: Sau lần ba 15 ngày
* **Cách sử dụng:** Phun ướt đều tán lá
---
### Lưu ý
* Lắc kỹ trước khi sử dụng
* Không phun khi trời nắng gắt hoặc khi cây đang nở hoa rộ
* Có thể pha với hầu hết các loại thuốc phòng trừ sâu bệnh
---
### Hướng dẫn an toàn và bảo quản
* **Bảo quản:**
  * Giữ trong bao bì gốc, đậy nắp kín
  * Để nơi khô ráo, thoáng mát
* **An toàn:**
  * Tránh xa tầm tay trẻ em, thực phẩm và nguồn nước sinh hoạt
  * Không để chung với các hợp chất hữu cơ, lưu huỳnh hoặc chất khử', N'Axit Humic (C): 3%; Kali hữu hiệu (K2O): 10%; Silic hữu hiệu (SiO2): 12%; pH: 12; Tỷ trọng: 1,296', CAST(250000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa, Cà chua', 4, 7, CAST(1.80 AS Decimal(18, 2)), N'Tính kiềm cao (pH 12), tránh dây vào mắt. Mang kính bảo hộ khi pha.', CAST(N'2026-03-07T07:44:10.6387707' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (11, N'sp0011', N'SAMINO_51SL', N'SAMINO 5.1 SL là chất kích thích sinh học thực vật, chứa ATCA và Axit Folic (Vitamin B9), giúp cây trồng tăng năng suất và chất lượng, chống stress và tăng cường sức đề kháng trong điều kiện môi trường bất lợi.', N'### Lúa
* **Liều lượng:** 0,6 – 0,8 lít/ha
* **Cách pha:**
  * 38 – 50 ml/bình 25 lít
  * 25 – 40 ml/bình 16 lít
  * 300 – 400 ml/phuy 200 lít
* **Lượng nước phun:** 400 lít/ha
* **Thời điểm bón:** Khi lúa chuẩn bị làm đòng
---
### Xử lý hạt giống
* Trộn 100 – 200 ml SAMINO 5.1 SL cho lượng hạt gieo 1 ha
---
### Lưu ý
* Phun ướt đều tán lá
* Phun sáng sớm hoặc chiều mát
* Không pha chung với thuốc có tính kiềm
---
### Hướng dẫn an toàn và bảo quản
* Giữ trong bao bì gốc, đậy nắp kín
* Để nơi khô ráo, thoáng mát
* Tránh xa trẻ em, thực phẩm và nguồn nước', N'ATCA: 5,0% w/w; Folic acid (Axit folic): 0,1% w/w; Dung môi, phụ gia: 94,9% w/w', CAST(210000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa', 4, 0, CAST(0.80 AS Decimal(18, 2)), N'Chất kích thích sinh học. Không pha chung với thuốc có tính kiềm.', CAST(N'2026-03-07T07:44:10.6387710' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (12, N'sp0012', N'SAIGON_P115WP', N'SAIGON - P1 giúp tăng cường đẻ nhánh, làm cây cứng cáp và chống đổ ngã. Là thuốc điều hòa sinh trưởng có tác dụng hạn chế tăng trưởng mầm lá, đẩy nhanh quá trình hình thành và phân hóa mầm hoa. Giúp khống chế chiều cao cây, đặc biệt hiệu quả cho cây lúa và đậu phộng, thuận tiện cho việc thu hoạch lúa bằng máy.', N'### Lúa
* **Mục đích sử dụng:** Kích thích sinh trưởng, hạn chế chiều cao cây, chống đổ ngã
* **Liều lượng:** 0,6 – 0,8 kg/ha
* **Cách pha:**
  * Pha 6g/bình 25 lít nước
  * Phun 1,5 – 2 bình cho 1.000 m²
* **Thời điểm bón:**
  * Lần 1: 20 – 25 ngày sau sạ
  * Lần 2: 40 – 45 ngày sau sạ
---
### Lưu ý
* Phun ướt đều hai mặt lá
* Nên phun vào lúc sáng sớm hoặc khi trời mát
* Có thể pha với các thuốc phòng trừ sâu bệnh (trừ thuốc có tính kiềm)
* Có thể trộn với phân để rải
* Trong quá trình xử lý, giữ mực nước ruộng từ 3 – 5 cm
* Không phun khi lúa đã trên 45 ngày tuổi
---
### Hướng dẫn an toàn và bảo quản
* **Bảo quản:** Giữ trong bao bì gốc, đậy nắp kín, để nơi khô ráo, thoáng mát
* **An toàn:** Tránh xa tầm tay trẻ em, thực phẩm và nguồn nước sinh hoạt', N'Paclobutrazol: 15% w/w; Chất mang, phụ gia: 85% w/w', CAST(260000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa, Đậu phộng', 4, 10, CAST(0.80 AS Decimal(18, 2)), N'Tránh phun quá liều gây lùn cây quá mức. Rửa tay kỹ sau khi dùng.', CAST(N'2026-03-07T07:44:10.6387713' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (13, N'sp0013', N'SAGOLATEX', N'SAGOLATEX 2.5 PA là thuốc kích thích sinh trưởng cây trồng, giúp mủ cao su không bị đông kết, làm bớt các tuyến mủ, giúp dòng mủ chảy đều và kéo dài thời gian chảy. Sử dụng hợp lý không ảnh hưởng đến sinh trưởng và phát triển của cây cao su, đồng thời tăng cường trao đổi chất, thúc đẩy tái tạo mủ và hạn chế hiện tượng khô mặt cạo.', N'### Cao su
* **Mục đích sử dụng:** Tăng sản lượng mủ, kéo dài thời gian chảy mủ
* **Liều lượng:** 1 – 2 g/cây
* **Cách dùng:**
  * Dùng cọ quét một lớp thuốc mỏng lên mặt miệng cạo tái sinh, tiếp giáp với miệng cạo
  * Bề rộng vùng quét: 1 – 2 cm
* **Thời điểm xử lý:**
  * Quét thuốc trước nhát cạo đầu tiên **48 giờ**
---
### Lưu ý
* 400g **SAGOLATEX 2.5 PA** dùng cho 400 – 500 cây (≈ 1 ha), tùy tuổi cây và chiều dài mặt cạo
* Không quét thuốc khi:
  * Trời nắng nóng
  * Trời sắp mưa
  * Vỏ cây còn ẩm ướt
* Chỉ sử dụng cho cây **sinh trưởng khỏe mạnh**', N'Ethephon: 2,5% w/w; Chất phụ gia: 97,5% w/w', CAST(190000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Cao su', 3, 2, CAST(1.00 AS Decimal(18, 2)), N'Chất kích thích, có tính axit. Tránh dây vào da và mắt. Chỉ dùng cho cây khỏe.', CAST(N'2026-03-07T07:44:10.6387717' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (14, N'sp0014', N'SAGO SÓNG THẦN', N'Giúp thuốc BVTV loang trải đều trên bề mặt tiếp xúc, nhanh chóng thấm sâu vào lá, thân, gốc, rễ, phát huy tối đa hiệu lực phòng trừ sâu, bệnh và cỏ dại. Khi bón phân qua lá hoặc tưới gốc, dưỡng chất được cây trồng hấp thu nhanh và triệt để. Hạn chế bốc hơi do nắng nóng hoặc rửa trôi khi gặp mưa, giúp tiết kiệm lượng phân – thuốc sử dụng.', N'### Tất cả các loại cây trồng
*(Khi sử dụng chung với thuốc BVTV hoặc phân bón)*
* **Liều lượng sử dụng:**
  * Pha 7 – 8 ml **SAGO Sóng Thần** cho bình 25 lít nước
  * Hoặc pha 100 ml chia đều cho 14 bình 25 lít
  * Hoặc pha 100 ml với 350 lít nước để phun cho 1 ha
* **Cách dùng:**
  * Phun ướt đều cây
---
### Lưu ý
* Pha chung với thuốc BVTV hoặc phân bón theo **hướng dẫn của sản phẩm đó**
* Phun vào **sáng sớm hoặc chiều mát** để đạt hiệu quả cao nhất
---
### Hướng dẫn an toàn và bảo quản
* **Bảo quản:** Giữ trong bao bì gốc, đậy nắp kín, để nơi khô ráo, thoáng mát
* **An toàn:** Tránh xa tầm tay trẻ em, thực phẩm và nguồn nước sinh hoạt', N'Alcohol Ethoxylate: 30% w/w; Chất phụ gia: 70% w/w', CAST(195000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Đa dụng', 4, 0, CAST(0.30 AS Decimal(18, 2)), N'Dung dịch đã pha phải phun ngay. Tránh xa tầm tay trẻ em.', CAST(N'2026-03-07T07:44:10.6387721' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (15, N'sp0015', N'SAGO ĐỒNG', N'SAGO ĐỒNG được sử dụng trong nông nghiệp để pha chế dung dịch Bordeaux phòng trừ bệnh cho cây trồng. Trong nuôi trồng thủy sản, sản phẩm giúp diệt rong nhớt đáy ao và xử lý các bệnh ký sinh trên tôm, cá.', N'### Ao hồ đang nuôi tôm
* **Bệnh hại:** Rong đen mang, ký sinh trùng, rong nhớt đáy ao
* **Liều lượng:** 0,1 g/m³ nước
* **Cách sử dụng:** Hòa tan và tạt xuống ao mỗi ngày 1 lần, dùng 2 – 3 ngày liên tục
### Ao hồ chưa nuôi tôm
* **Bệnh hại:** Rong nhớt đáy ao
* **Liều lượng:** 0,25 g/m³ nước
* **Cách sử dụng:** Hòa tan và tạt xuống ao mỗi ngày 1 lần, dùng 2 – 3 ngày liên tục
### Bè cá
* **Bệnh hại:** Trắng mang, đỏ mang, lở loét do ký sinh trùng, rận cá, bông gòn, thối đuôi – vây
* **Liều lượng:** 0,3 g/m³ nước
* **Cách sử dụng:** Treo đầu bè mỗi ngày 1 lần, dùng 3 ngày liên tục
* **Lưu ý:** Dùng thường xuyên có thể làm đổi màu nước, tôm cá chậm lớn – cần tuân thủ đúng liều lượng
---
## Pha chế dung dịch Bordeaux
* **Cách pha:** 1 kg SAGO ĐỒNG hòa tan trong 80 lít nước, đổ từ từ vào 1 kg vôi sống (CaO) đã hòa tan trong 20 lít nước, khuấy đều và loại bỏ cặn
* **Kiểm tra:** Nhúng đinh sắt vào dung dịch 10 phút – không gỉ là đạt
* **Lưu ý:** Phun ngay sau khi pha, **không pha chung với thuốc khác**
---
### Hướng dẫn an toàn & bảo quản
* **Bảo quản:** Bao bì gốc, nơi khô ráo, thoáng mát
* **An toàn:** Tránh xa trẻ em, thực phẩm và nguồn nước sinh hoạt', N'Hoạt chất: Copper Sulphate 98% (25% Cu); Chất phụ gia: 2%', CAST(250000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Thủy sản, Cây trồng', 3, 7, CAST(3.00 AS Decimal(18, 2)), N'Độc với cá nếu quá liều. Không pha chung với thuốc khác khi làm Bordeaux.', CAST(N'2026-03-07T07:44:10.6387724' AS DateTime2), NULL, 0, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (16, N'sp0016', N'SAGO SIÊU HẤP', N'Đang cập nhật', N'Đang cập nhật', N'Đang cập nhật', CAST(220000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Đa dụng', 4, 0, CAST(0.50 AS Decimal(18, 2)), N'Chất trợ lực nông nghiệp. An toàn khi sử dụng đúng liều.', CAST(N'2026-03-07T07:44:10.6387727' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (17, N'sp0017', N'SAGO BÁM DÍNH', N'Tăng khả năng bám dính và loang trải của phân bón lá và thuốc BVTV lên thân, lá, hoa, trái. Hạn chế rửa trôi khi trời mưa, giảm thoát hơi nước mùa khô, hạn chế sương muối và tránh cháy lá. Giúp tăng hiệu lực và kéo dài thời gian tác dụng của các chất nông dược.', N'### Tất cả các loại cây trồng
*(Khi sử dụng chung với thuốc BVTV hoặc phân bón lá)*
* **Liều lượng sử dụng:**
  * Pha 15 – 20 ml cho bình 16 lít nước
  * Hoặc pha 200 – 250 ml cho phuy 200 lít nước
* **Cách dùng:**
  * Khuấy tan chất bám dính
  * Thêm thuốc BVTV hoặc phân bón lá, khuấy đều
  * Phun ướt đều **thân, lá, hoa, trái**
---
### Lưu ý
* Pha chung được với hầu hết thuốc BVTV và phân bón lá
* Dùng đúng liều lượng hướng dẫn
* Dung dịch đã pha **phun ngay**, không để quá 2 ngày
---
### Hướng dẫn an toàn và bảo quản
* **Bảo quản:** Bao bì gốc, đậy kín, nơi khô ráo, thoáng mát
* **An toàn:** Tránh xa trẻ em, thực phẩm và nguồn nước sinh hoạt', N'Linear Alkylbenzene Sulfonate: 5%; Keo và các phụ gia: Đầy đủ 100%', CAST(300000.00 AS Decimal(18, 2)), 0, NULL, NULL, N'Đa dụng', 4, 0, CAST(0.25 AS Decimal(18, 2)), N'Không ăn uống khi sử dụng. Bảo quản nơi thoáng mát.', CAST(N'2026-03-07T07:44:10.6387730' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (18, N'sp0018', N'PLASTIMULA 1SL', N'Giúp phát triển bộ rễ khỏe, tăng chồi hữu hiệu, cho đòng to – bông lớn, nâng cao năng suất lúa. Giúp lúa trổ đều, trổ rộ, phục hồi nhanh sau ngộ độc thuốc, hữu cơ, phèn và tăng sức đề kháng bệnh vàng lùn. Không phải phân bón lá, có thể sử dụng khi lúa đang bị bệnh.', N'### Cây trồng: Lúa
* **Liều lượng và cách dùng:**
  * Pha 30 ml cho bình 25 lít nước
  * Phun ướt đều cây lúa
* **Thời điểm xử lý:**
  * Xử lý giống trước gieo
  * Giai đoạn đẻ nhánh
  * Giai đoạn làm đòng
  * Giai đoạn trổ lẹt xẹt
---
### Lưu ý
* Có thể pha chung với thuốc BVTV khác
* **Không có thời gian cách ly**
* Mang đầy đủ bảo hộ lao động khi pha và phun
* Không ăn uống, hút thuốc khi sử dụng
* Không rửa dụng cụ ở ao hồ, nguồn nước sinh hoạt
* Bao bì sau sử dụng thu gom và tiêu hủy đúng quy định
---
### Sơ cứu khi ngộ độc
* **Dính mắt:** Rửa nước sạch 15 – 20 phút
* **Dính da:** Rửa bằng xà phòng và nước sạch
* **Ngộ độc:** Đưa đến cơ sở y tế gần nhất, mang theo nhãn thuốc
---
### Hướng dẫn an toàn & bảo quản
* **Bảo quản:** Bao bì gốc, đậy kín, nơi khô ráo, thoáng mát
* **An toàn:** Tránh xa trẻ em, thực phẩm và nguồn nước sinh hoạt', N'Polyphenol chiết xuất từ than bùn và lá, vỏ thân cây xoài (Mangifera indica L): 1g/l; Phụ gia: Vừa đủ 1 lít', CAST(230000.00 AS Decimal(18, 2)), 30, NULL, NULL, N'Lúa', 4, 0, CAST(0.50 AS Decimal(18, 2)), N'Chiết xuất sinh học. An toàn, không cần thời gian cách ly.', CAST(N'2026-03-07T07:44:10.6387733' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (19, N'sp0019', N'SAGO AXIT', N'Giúp phá vỡ trạng thái ngủ cho lúa giống ngắn ngày mới thu hoạch, tăng tỷ lệ nảy mầm, sức nảy mầm tốt và đồng đều hơn.', N'### Xử lý lúa giống bằng SAGO AXIT
* **Liều lượng và cách dùng:**
  * Pha **50 – 60 ml** trong **20 lít nước** để ngâm **20 kg lúa giống** (1 giạ)
  * Hoặc pha **250 – 300 ml** trong **100 lít nước** để ngâm **100 kg lúa giống** (5 giạ)
  * Ngâm **24 – 36 giờ**, sau đó **vớt ra – rửa sạch bằng nước – ủ bình thường**
---
### Chú ý
* **Chỉ đổ axit vào nước**, **không đổ nước vào axit**
* Không ngâm trong **thau, thùng kim loại**
* Tránh xa **trẻ em**
* Tránh dính vào **da, mắt, quần áo**', N'Axit Nitric (HNO3): 10%', CAST(180000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa giống', 2, 0, CAST(0.30 AS Decimal(18, 2)), N'Axit mạnh (HNO3). Tuyệt đối không đổ nước vào axit. Mang găng tay cao su.', CAST(N'2026-03-07T07:44:10.6387736' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (20, N'sp0020', N'ORGANIC NOKAYO', N'Giúp đất tơi xốp, giàu mùn, giữ ẩm tốt, kích thích vi sinh vật có lợi phát triển. Cung cấp đầy đủ đạm – lân – kali và trung vi lượng, giúp cây phát triển rễ khỏe, tăng sức đề kháng, chịu hạn – chịu rét tốt, nâng cao năng suất và chất lượng nông sản.', N'### Cây rau màu
* **Lượng bón:** 400 – 600 kg/ha/vụ
* **Bón lót:** 200 – 400 kg/ha
---
### Cây hoa
* **Bón thúc:** 200 – 400 kg/ha/lần/vụ
---
### Cây ăn trái
* **Lượng bón:** 1.000 – 1.100 kg/ha/năm
* **Cách bón:**
  * Thời kỳ cây con: **0,5 kg/gốc/lần**
  * Bón **3 tháng/lần**
---
### Cây công nghiệp
* **Lượng bón:** 0,75 kg/gốc/lần (thời kỳ kinh doanh)
* **Bón 2 lần/năm:**
  * Trước khi ra hoa
  * Khi hình thành quả
---
### Lưu ý
* Bón đều quanh gốc
* **Kết hợp tưới nước**
* Phù hợp cho **mọi loại đất**, đặc biệt đất **nghèo dinh dưỡng**
---
### Hướng dẫn an toàn & bảo quản
* **Bảo quản:** Bao bì gốc, nơi khô ráo, thoáng mát
* **An toàn:** Không ăn, để xa thực phẩm và nguồn nước uống', N'Chất hữu cơ: 50%; Nts: 3,4%; P2O5hh: 2,2%; K2Ohh: 2,1%; Độ ẩm: 26%; C/N: 7,1; pH(H2O): 6,7', CAST(170000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Rau màu, Cây ăn trái', 4, 0, CAST(500.00 AS Decimal(18, 2)), N'Phân hữu cơ an toàn. Rửa tay sau khi bón.', CAST(N'2026-03-07T07:44:10.6387739' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (21, N'sp0021', N'ORGANIC YUKIMOTO', N'Bổ sung hữu cơ cho đất bạc màu, nghèo dinh dưỡng, giúp cải thiện năng suất cây trồng. Tạo môi trường tối ưu cho bộ rễ phát triển mạnh, cân bằng vi sinh vật vùng rễ, tăng giữ ẩm, giúp đất tơi xốp, giàu mùn, nâng cao năng suất và chất lượng nông sản.', N'### Cây trồng các loại
* **Cách dùng:** Bón trực tiếp vào đất, bón đều quanh gốc
---
### Lưu ý
* Kết hợp tưới nước sau khi bón
* Phù hợp cho đất bạc màu, đất nghèo hữu cơ
---
### Hướng dẫn an toàn & bảo quản
* **Bảo quản:** Bao bì gốc, nơi khô ráo, thoáng mát
* **An toàn:** Để xa tầm tay trẻ em, thực phẩm và nguồn nước sinh hoạt', N'Chất hữu cơ: 60%; Độ ẩm: 24%; Tỷ lệ C/N: 8,9; pH(H2O): 6,3', CAST(180000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Đa dụng', 4, 0, CAST(500.00 AS Decimal(18, 2)), N'Bảo quản nơi khô ráo. Tránh xa thực phẩm.', CAST(N'2026-03-07T07:44:10.6387795' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (22, N'sp0022', N'NPK HÀN VIỆT 20 20 15 TE', N'Cung cấp dinh dưỡng cân đối đạm – lân – kali giúp cây trồng phát triển đồng đều, tăng trưởng mạnh. Đặc biệt hiệu quả trong giai đoạn nuôi trái, giúp nâng cao năng suất và chất lượng nông sản.', N'### Cây ăn trái
* **Lượng bón:** 1 – 2 kg/cây/năm
* Bón đều quanh gốc, kết hợp tưới nước
---
### Cây công nghiệp
* **Lượng bón:** 450 – 700 kg/ha/năm
* Bón 2 lần/năm: trước ra hoa và khi hình thành quả
---
### Lúa – Bắp
* **Lượng bón:** 300 – 400 kg/ha/vụ
---
### Rau màu
* **Lượng bón:** 200 – 250 kg/ha/vụ
---
### Hướng dẫn an toàn & bảo quản
* **Bảo quản:** Bao bì gốc, nơi khô ráo, thoáng mát
* **An toàn:** Tránh xa trẻ em, thực phẩm và nguồn nước sinh hoạt', N'Đạm (N): 15%; Lân (P2O5): 15%; Kali (K2O): 15%', CAST(210000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa, Bắp, Cây ăn trái', 4, 0, CAST(300.00 AS Decimal(18, 2)), N'Phân bón gốc. Tưới nước sau khi bón để tan phân.', CAST(N'2026-03-07T07:44:10.6387798' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (23, N'sp0023', N'NPK HÀN VIỆT 15-15-15', N'Thúc đẩy cây trồng phát triển đồng đều, tăng trưởng tốt. Đặc biệt hiệu quả trong giai đoạn nuôi trái của cây ăn trái. Cung cấp dinh dưỡng cân đối đạm – lân – kali, giúp cải thiện năng suất và chất lượng nông sản.', N'### Cây ăn trái
* **Lượng bón:** 1 – 2 kg/cây/năm
* **Cách bón:**
  * Bón đều quanh gốc
  * Kết hợp tưới nước để phân thẩm thấu tốt
---
### Cây công nghiệp
* **Lượng bón:** 450 – 700 kg/ha/năm
* **Bón 2 lần/năm:**
  * Trước khi ra hoa
  * Khi hình thành quả
---
### Lúa, bắp
* **Lượng bón:** 300 – 400 kg/ha/vụ
* **Cách bón:** Bón lót hoặc bón thúc
---
### Rau màu
* **Lượng bón:** 200 – 250 kg/ha/vụ
* **Cách bón:** Bón lót hoặc bón thúc, kết hợp tưới nước
---
### Lưu ý
* Bón đúng liều lượng khuyến cáo
* Không bón quá nhiều gây lãng phí
* Luôn tưới nước sau khi bón
---
### Hướng dẫn an toàn & bảo quản
* **Bảo quản:** Bao bì gốc, nơi khô ráo, thoáng mát
* **An toàn:** Tránh xa trẻ em, thực phẩm và nguồn nước', N'Đạm (N): 15%; Lân (P2O5): 15%; Kali (K2O): 15%', CAST(210000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Đa dụng', 4, 0, CAST(350.00 AS Decimal(18, 2)), N'Không bón quá liều gây xót rễ. Bảo quản nơi khô ráo.', CAST(N'2026-03-07T07:44:10.6387801' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (24, N'sp0024', N'NPK FERTIGONIA', N'FERTIGONIA là phân bón đa năng, phù hợp cho mọi loại cây trồng. Giúp phát triển toàn diện rễ, thân, lá, hoa, trái và hạt. Cung cấp đầy đủ đa – trung – vi lượng, tăng sức đề kháng và tối ưu khả năng hấp thu dinh dưỡng qua lá.', N'### Cây lương thực (Lúa)
* **Liều lượng:** 50 – 75 g/bình 25 lít
* **Thời điểm phun:** 17, 45 và 55 ngày sau sạ
---
### Cây ăn trái
* **Liều lượng:** 75 g/bình 25 lít
  * Hoặc 500 g/phuy 200 lít
* **Phun 3 – 4 lần:** Sau thu hoạch, trái non, dưỡng trái
---
### Rau màu
* **Liều lượng:** 50 – 75 g/bình 25 lít
* **Phun 3 lần/vụ:** 10 – 20 – 30 ngày sau trồng
---
### Lưu ý
* Không phun khi trời nắng gắt hoặc cây đang nở hoa
* Có thể pha chung với thuốc BVTV
* Phun ướt đều tán lá
---
### Hướng dẫn an toàn & bảo quản
* **Bảo quản:** Bao bì gốc, nơi khô ráo, thoáng mát
* **An toàn:** Tránh xa trẻ em, thực phẩm và nguồn nước', N'Nts: 18%; P2O5hh: 18%; K2Ohh: 18%; MgO: 3%; S: 2,6%; Zn: 200 ppm; B: 210 ppm; Fe: 600 ppm; Mn: 500 ppm; Cu: 400 ppm; Mo: 30 ppm; Độ ẩm: 5%', CAST(310000.00 AS Decimal(18, 2)), 47, NULL, NULL, N'Lúa, Rau màu', 4, 7, CAST(2.00 AS Decimal(18, 2)), N'Phân bón lá cao cấp. Không phun khi trời nắng gắt.', CAST(N'2026-03-07T07:44:10.6387805' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (25, N'sp0025', N'NATRAZYME', N'Natrazyme bổ sung đầy đủ và cân đối các chất dinh dưỡng dưới dạng hữu cơ dễ tiêu cùng khoáng chất đa, trung, vi lượng thiết yếu cho cây trồng. Hàm lượng lân hữu hiệu cao giúp bộ rễ phát triển nhanh, khỏe mạnh và hỗ trợ phân hóa mầm hoa tốt. Chứa NAA và GA3 giúp cây sinh trưởng nhanh, ra hoa sớm, dễ đậu trái, tăng năng suất và chất lượng nông sản.', N'### Cây lương thực
* **Lượng phân bón:** 40 – 80 ml/25 lít nước
* **Thời điểm phun:** 2 – 3 lần/vụ, từ giai đoạn cây con đến sắp ra hoa
---
### Rau màu, cây công nghiệp, cây hoa
* **Lượng phân bón:** 40 – 80 ml/25 lít nước
  Hoặc 300 – 600 ml/phuy 200 lít
* **Thời điểm phun:** 2 – 3 lần/năm, sau thu hoạch đến sắp ra hoa
---
### Cây ăn trái, cây cảnh
* **Lượng phân bón:** 25 – 50 ml/16 lít nước
* **Thời điểm phun:** Ra lá non và sau khi cắt tỉa cành
---
### Lưu ý
* Dừng phun ít nhất 7 ngày trước thu hoạch
* Không phun khi trời nắng gắt hoặc cây đang nở hoa rộ
* Phun ướt đều tán lá
---
### Hướng dẫn an toàn & bảo quản
* **Bảo quản:** Bao bì gốc, nơi khô ráo, thoáng mát
* **An toàn:** Tránh xa trẻ em, thực phẩm và nguồn nước', N'Đạm tổng số (Nts): 5%; Lân hữu hiệu (P2O5hh): 11%; Kali hữu hiệu (K2Ohh): 3%; Chất hữu cơ: 3%; Mg: 350 ppm; NAA: 0,01%; Mn: 350 ppm; GA3: 0,01%; Zn: 150 ppm; B: 30 ppm; pH (H2O): 5; Tỷ trọng: 1,17', CAST(230000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lương thực, Rau màu', 4, 7, CAST(1.50 AS Decimal(18, 2)), N'Chứa kích thích tố (NAA, GA3). Tuân thủ đúng liều lượng.', CAST(N'2026-03-07T07:44:10.6387808' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (26, N'sp0026', N'NPK 16-16-8-13S', N'Cung cấp dinh dưỡng cân đối đạm – lân – kali – lưu huỳnh, giúp cây sinh trưởng đồng đều, phát triển rễ, thân, lá và quả. Đặc biệt hiệu quả trong giai đoạn nuôi trái và sinh trưởng mạnh.', N'### Lúa, bắp
* **Liều lượng:** 350 – 450 kg/ha/vụ
* **Cách bón:** Bón lót hoặc bón thúc
---
### Cây công nghiệp
* **Liều lượng:** 500 – 700 kg/ha/năm
* **Bón 2 lần:** Trước ra hoa và khi hình thành quả
---
### Cây ăn trái
* **Liều lượng:** 1,5 – 2 kg/cây/năm
* **Cách bón:** Bón quanh gốc, kết hợp tưới nước
---
### Rau đậu
* **Liều lượng:** 200 – 300 kg/ha/vụ
* **Cách bón:** Bón lót hoặc thúc
---
### Lưu ý
* Bón đúng liều lượng khuyến cáo
* Tưới nước sau khi bón
---
### Hướng dẫn an toàn & bảo quản
* **Bảo quản:** Nơi khô ráo, thoáng mát
* **An toàn:** Tránh xa trẻ em và thực phẩm', N'Đạm (N): 16%; Lân (P2O5): 16%; Kali (K2O): 8%; Lưu huỳnh (S): 13%', CAST(210000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa, Bắp', 4, 0, CAST(400.00 AS Decimal(18, 2)), N'Chứa Lưu huỳnh (S). Rửa tay sạch sau khi bón.', CAST(N'2026-03-07T07:44:10.6387811' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (27, N'sp0027', N'SOP', N'Tăng sức chống chịu cho cây trước sâu bệnh và điều kiện bất lợi. Giúp trái lớn nhanh, tăng độ ngọt, màu sắc đẹp, chín đều và kéo dài thời gian bảo quản sau thu hoạch.', N'### Cây ăn trái
* **Liều lượng:** 25 – 50 g/25 lít nước
  Hoặc 200 – 400 g/phuy 200 lít
* **Thời điểm:** Phân hóa mầm hoa, trái non, dưỡng trái
---
### Rau màu
* **Liều lượng:** 25 – 50 g/25 lít nước
* **Phun:** 1 – 2 lần/vụ
---
### Lúa, bắp
* **Liều lượng:** 12,5 – 25 g/25 lít nước
* **Phun:** 30 – 45 – 55 ngày sau gieo
---
### Lưu ý
* Không phun khi nắng gắt hoặc cây đang nở hoa rộ
---
### Hướng dẫn an toàn & bảo quản
* **Bảo quản:** Bao bì kín, nơi khô ráo
* **An toàn:** Tránh xa trẻ em và nguồn nước', N'Kali hữu hiệu (K2Ohh): 50%; Lưu huỳnh (S); pH: 7', CAST(240000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Cây ăn trái, Rau', 4, 7, CAST(2.00 AS Decimal(18, 2)), N'Phân bón Kali trắng. An toàn cho cây mẫn cảm với Clo.', CAST(N'2026-03-07T07:44:10.6387814' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (28, N'sp0028', N'NPK 17-7-17 + TE', N'Phân bón hỗn hợp NPK 17-7-17+TE (Bo & Kẽm) sản xuất theo công nghệ hơi nước, nhập khẩu Hàn Quốc. Chuyên dùng cho cây công nghiệp như cà phê, tiêu, cao su, mía, khoai mì. Hàm lượng Kali cao giúp cây chắc hạt, chống rụng, tăng năng suất và chất lượng nông sản.', N'### Cà phê, cao su
* **Liều lượng:** 500 – 700 kg/ha/lần bón
---
### Mía
* **Liều lượng:** 400 – 500 kg/ha/lần bón
---
### Tiêu
* **Liều lượng:** 300 – 500 g/trụ/lần bón
---
### Khoai mì
* **Liều lượng:** 200 – 300 kg/ha/lần bón', N'Đạm (N): 17%; Lân (P2O5): 7%; Kali (K2O): 17%; Kẽm (Zn): 1.000 ppm; Boron (B): 1.000 ppm', CAST(200000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Cây công nghiệp', 4, 0, CAST(600.00 AS Decimal(18, 2)), N'Chuyên dùng cho cây công nghiệp. Bảo quản nơi khô ráo.', CAST(N'2026-03-07T07:44:10.6387817' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (29, N'sp0029', N'NPK 16-16-8 + TE', N'Phân NPK 16-16-8+TE sản xuất bằng công nghệ hơi nước Hàn Quốc, bổ sung Bo và Kẽm hàm lượng cao. Giúp cây sinh trưởng cân đối, giảm lượng phân bón tăng, đặc biệt hiệu quả cho lúa và cây công nghiệp.', N'### Lúa, bắp
* **Liều lượng:** 350 – 450 kg/ha/vụ
  *(13 – 16 kg/360 m²/vụ)*
---
### Cây công nghiệp
* **Liều lượng:** 300 – 500 kg/ha/đợt bón
---
### Cây ăn trái
* **Liều lượng:** 1,5 – 2 kg/cây/lần bón
---
### Rau đậu
* **Liều lượng:** 200 – 300 kg/ha/vụ', N'Đạm (Nts): 16%; Lân (P2O5hh): 16%; Kali (K2Ohh): 8%; Boron (B): 310 ppm; Kẽm (Zn): 800 ppm; Độ ẩm: 2%', CAST(190000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa, Bắp', 4, 0, CAST(400.00 AS Decimal(18, 2)), N'Bổ sung Bo và Kẽm. An toàn khi sử dụng.', CAST(N'2026-03-07T07:44:10.6387820' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (30, N'sp0030', N'NPK TÂN THÀNH 25-25-5', N'Cung cấp đồng thời Đạm – Lân – Kali và vi lượng Bo giúp cây phát triển mạnh thân lá, rễ khỏe, tăng khả năng quang hợp, chống đổ ngã và thích nghi tốt với điều kiện bất lợi.', N'### Mục đích sử dụng
Bón lót hoặc bón thúc cho lúa, ngô, cà phê, hồ tiêu, cây ăn trái, rau màu
---
### Thời điểm bón
* Giai đoạn phát triển thân lá
* Trước khi ra hoa, đậu quả
---
### Cách bón
* Rải đều quanh gốc hoặc theo luống
* Tưới nước đủ ẩm sau khi bón
---
### Lưu ý an toàn & bảo quản
* Chỉ dùng cho nông nghiệp
* Để xa trẻ em và vật nuôi
* Bảo quản nơi khô ráo, thoáng mát', N'Đạm (Nts): 25%; Lân (P2O5hh): 25%; Kali (K2Ohh): 5%; Bo (B): 50 ppm; Độ ẩm: 5%', CAST(310000.00 AS Decimal(18, 2)), 10, NULL, NULL, N'Đa dụng', 4, 0, CAST(300.00 AS Decimal(18, 2)), N'Hàm lượng đạm lân cao. Tưới đủ nước sau khi bón.', CAST(N'2026-03-07T07:44:10.6387836' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (31, N'sp0031', N'NPK TÂN THÀNH 20-20-15 TE', N'Phân đa dinh dưỡng tổng hợp giúp cây sinh trưởng nhanh, bổ sung trung – vi lượng, tăng khả năng ra hoa, hạn chế rụng trái non và nâng cao năng suất, chất lượng nông sản.', N'### Công dụng
* Giúp cây sinh trưởng nhanh
* Bổ sung trung và vi lượng
* Hạn chế rụng trái non
* Tăng năng suất và chất lượng nông sản', N'Đạm (Nts): 20%; Lân (P2O5hh): 20%; Kali (K2Ohh): 15%; Kẽm (Zn): 220 ppm; Bo (B): 60 ppm; Độ ẩm: 5%', CAST(220000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Đa dụng', 4, 0, CAST(2.00 AS Decimal(18, 2)), N'Phân bón gốc an toàn. Bảo quản nơi khô ráo, tránh ẩm ướt.', CAST(N'2026-03-07T07:44:10.6387839' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (32, N'sp0032', N'LACASOTO 4SP', N'Thuốc sinh học giúp tăng năng suất lúa 500 – 900 kg/ha, lá đòng xanh bền, vô gạo liên tục, tăng tỷ lệ hạt chắc 10%. Phù hợp với nông sản sạch, không cần thời gian cách ly.', N'### Thời điểm sử dụng
* Phun giai đoạn lúa cong trái me
---
### Liều lượng
* 18 g/25 lít nước, phun đều ruộng lúa
---
### Hướng dẫn an toàn
* Mang đồ bảo hộ khi phun
* Không ăn uống, hút thuốc
* Thu gom và tiêu hủy bao bì đúng quy định
---
### Sơ cứu khi ngộ độc
* **Dính mắt:** Rửa nước sạch 15 – 20 phút
* **Dính da:** Rửa xà phòng
* **Nuốt phải:** Đưa đến cơ sở y tế gần nhất', N'Sophora japonica L. Schott: 4 g/kg; Quy cách: 10 g, 18 g, 100 g', CAST(210000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa', 4, 0, CAST(0.72 AS Decimal(18, 2)), N'Thuốc sinh học, phù hợp nông sản sạch. An toàn cho người sử dụng.', CAST(N'2026-03-07T07:44:10.6387842' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (33, N'sp0033', N'CHUBECA', N'Trên lúa: Đặc trị lem lép hạt, phòng trị đạo ôn, khô vằn, cháy bìa lá. Giúp lá lúa dày, cứng, đứng thẳng, tăng khả năng quang hợp và sức chống chịu. Trên cây khác: Xoài (thán thư), Thanh long (đốm nâu), Cam (ghẻ nhám), Bắp cải (lở cổ rễ), Ớt (thán thư, héo rũ).', N'### Trên lúa
* **Liều lượng:** 60 – 70 ml/bình 25 lít nước
* **Cách dùng:** Phun đều ruộng lúa
### Trên xoài, nhãn
* **Liều lượng:** 360 ml/phuy 200 lít nước
* **Cách dùng:** Phun ướt đều tán cây
### Trên cây trồng khác
* **Liều lượng:** 60 ml/bình 25 lít nước
* **Cách dùng:** Phun đều trên cây
---
### Lưu ý
* Có thể phối trộn với thuốc trị bệnh khác
* **Thời gian cách ly:** Không khuyến cáo – an toàn cho người sử dụng
---
### Hướng dẫn an toàn
* Mang đồ bảo hộ khi pha và phun
* Không ăn uống, hút thuốc
* Không rửa dụng cụ ở ao hồ, nguồn nước sinh hoạt
* Thu gom, tiêu hủy bao bì đúng quy định
---
### Sơ cứu khi ngộ độc
* **Dính mắt:** Rửa nước sạch 15 – 20 phút
* **Dính da:** Rửa bằng xà phòng
* **Nuốt phải:** Đưa đến cơ sở y tế gần nhất', N'Polyphenol: 1,8 g/l (chiết xuất từ cây Oroxylum indicum và Salix babylonica); Phụ gia: vừa đủ 1 lít; Quy cách: Gói 30 ml; Chai 360 ml và 800 ml', CAST(170000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Lúa, Xoài, Thanh long', 4, 0, CAST(2.50 AS Decimal(18, 2)), N'Không cần thời gian cách ly. An toàn cho người và môi trường.', CAST(N'2026-03-07T07:44:10.6387845' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (34, N'sp0034', N'DAP TÂN THÀNH', N'Cung cấp dinh dưỡng thiết yếu cho mọi loại cây trồng. Giàu lân giúp ra mầm mạnh, đẻ nhánh tốt, phát triển rễ khỏe, ra hoa – đậu quả đều và tăng sức đề kháng trước điều kiện thời tiết bất lợi.', N'### Hướng dẫn sử dụng
* Bón lót hoặc bón thúc theo từng giai đoạn cây
* Phù hợp: lúa, ngô, cà phê, hồ tiêu, cây ăn trái, rau màu, cây công nghiệp
### Thời điểm bón
* Trời mát, tránh nắng gắt hoặc mưa lớn
### Cách bón
* Sau khi bón, tưới nước đầy đủ để cây hấp thu nhanh
### Liều lượng
* Tùy loại cây và độ phì đất
* Tham khảo khuyến cáo trên bao bì hoặc cán bộ kỹ thuật
---
### Lưu ý an toàn & bảo quản
* Chỉ dùng cho cây trồng
* Để xa trẻ em, vật nuôi
* Rửa tay sau khi sử dụng
* Bảo quản nơi khô ráo, thoáng mát', N'Đạm tổng số (Nts): 18%; Lân hữu hiệu (P2O5hh): 46%; Độ ẩm: 2,5%', CAST(160000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Đa dụng', 4, 0, CAST(150.00 AS Decimal(18, 2)), N'Rửa tay sạch sau khi bón. Tránh xa tầm tay trẻ em.', CAST(N'2026-03-07T07:44:10.6387848' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (35, N'sp0035', N'ATRAZIN', N'Cải tạo đất, tăng độ tơi xốp, cải thiện lý – hóa tính đất. Cung cấp NPK và mùn, tăng khả năng giữ nước, hạn chế rửa trôi dinh dưỡng, giúp cây sinh trưởng khỏe, tăng ra hoa và chất lượng nông sản.', N'### Cây ăn trái
* **Cây con:** 1 kg/gốc/lần, bón 3 tháng/lần
* **Thời kỳ kinh doanh:** 1,5 kg/gốc/lần, bón 2 lần/năm
### Rau màu
* 0,5 – 1 kg cho 10 kg đất trồng rau
### Cây tiểu cảnh
* 50 – 100 g/chậu
### Cây hoa, cây cảnh
* 0,5 – 1 kg/chậu lớn
---
### Cách bón
* Xới đất bề mặt
* Bón theo rãnh quanh tán hoặc mép chậu
* Lấp đất và tưới nước giữ ẩm', N'Chất hữu cơ: 15%; Đạm tổng số (Nts): 3%; Lân hữu hiệu (P2O5hh): 4%; Kali hữu hiệu (K2Ohh): 2%; pH: 5; Ẩm độ: 20%', CAST(230000.00 AS Decimal(18, 2)), 50, NULL, NULL, N'Cây ăn trái, Rau màu', 4, 0, CAST(1000.00 AS Decimal(18, 2)), N'Dùng bón gốc cải tạo đất. Không ăn được.', CAST(N'2026-03-07T07:44:10.6387852' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (36, N'sp0036', N'KẼM BORON', N'Kẽm (Zn): 50.000 ppm (tương đương 50g/lít). Bo (B): 50.000 ppm (tương đương 50g/lít). Độ ẩm: 1%. Dung môi và phụ gia: vừa đủ 1 lít.', N'### **Hướng dẫn an toàn khi sử dụng thuốc**
* **Trang bị bảo hộ đầy đủ** khi pha chế và phun thuốc.
* **Không ăn uống, hút thuốc** trong quá trình sử dụng thuốc.
* **Không súc rửa dụng cụ phun xịt** ở ao hồ nuôi cá, nguồn nước sinh hoạt.
* **Bảo quản thuốc** nơi an toàn, tránh xa tầm tay trẻ em.
* **Bao bì sau sử dụng** phải được **thu gom và tiêu hủy đúng quy định**.
### **Sơ cứu khi ngộ độc**
* **Nếu dính vào mắt:** Rửa ngay bằng nước sạch trong **15 – 20 phút**.
* **Nếu dính vào da:** Rửa kỹ bằng **xà phòng và nước sạch**.
* **Nếu nuốt phải thuốc:** Đưa ngay đến **cơ sở y tế gần nhất**, mang theo **nhãn thuốc**.', N'Kẽm (Zn): 50.000 ppm (tương đương 50 g/lít); Bo (B): 50.000 ppm (tương đương 50 g/lít); Độ ẩm: 1%; Dung môi và phụ gia: vừa đủ 1 lít', CAST(200000.00 AS Decimal(18, 2)), 50, 365, CAST(N'2025-12-08T00:00:00.0000000' AS DateTime2), N'Đa dụng', 4, 7, CAST(1.00 AS Decimal(18, 2)), N'Trang bị bảo hộ khi phun. Không súc rửa dụng cụ ở ao nuôi cá.', CAST(N'2026-03-07T07:44:10.6387856' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (37, N'sp0037', N'ANIMAT', N'Bo và Kẽm có vai trò thiết yếu đối với các nhu cầu sinh học của cây trồng như tổng hợp protein, enzyme và hormone tăng trưởng. Sản phẩm giúp ngăn ngừa hiện tượng lá non nhỏ, biến dạng, chùn đọt, chết ngọn, rụng trái non, nứt trái, sượng trái, bọng ruột. Đặc biệt hiệu quả trong các giai đoạn ra hoa, thụ phấn và đậu trái.', N'### **Cây ăn trái**
* **Liều lượng:** 25 – 50g/25 lít nước hoặc 200 – 400g/phuy 200 lít
* **Giai đoạn:** Phân hóa mầm hoa, trái non, dưỡng trái
### **Rau màu**
* **Liều lượng:** 25 – 50g/25 lít nước
* **Giai đoạn:** Sau hồi xanh, trước ra hoa
### **Cây lương thực**
* **Liều lượng:** 12,5 – 25g/25 lít nước
* **Giai đoạn:** 30 – 45 – 55 ngày sau gieo
### **Lưu ý**
* Không phun khi nắng gắt
* Có thể pha chung thuốc BVTV khác
### **Bảo quản & an toàn**
* Để nơi khô ráo, thoáng mát
* Tránh xa trẻ em và thực phẩm', N'TCA: 5,0% w/w; Folic acid: 0,1% w/w; Dung môi, phụ gia: 94,9% w/w', CAST(230000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Cây ăn trái, Rau màu', 4, 7, CAST(1.00 AS Decimal(18, 2)), N'Vi lượng và kích thích tố. Bảo quản nơi thoáng mát.', CAST(N'2026-03-07T07:44:10.6387859' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (38, N'sp0038', N'SPC - MKP', N'Giúp kích thích phát triển bộ rễ, tăng khả năng hấp thu dinh dưỡng, thúc đẩy ra hoa tập trung, trái to, tăng độ ngọt và giúp cây chống chịu tốt trong điều kiện bất lợi như phèn, ngập úng.', N'### **Cây ăn trái**
* **Liều lượng:** 25 – 50g/25 lít nước hoặc 200 – 400g/phuy 200 lít
* **Giai đoạn:** Phân hóa mầm hoa, trái non
### **Rau màu**
* **Liều lượng:** 25 – 50g/25 lít nước
* **Giai đoạn:** Sau hồi xanh
### **Cây lương thực**
* **Liều lượng:** 12,5 – 25g/25 lít nước
* **Giai đoạn:** 30 – 45 – 55 ngày sau gieo
### **Đậu đỗ**
* Phun trước và sau khi ra hoa', N'Lân (P2O5): 52%; Kali (K2O): 34%; Dạng tinh thể, màu trắng', CAST(210000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Cây ăn trái, Lúa', 4, 7, CAST(2.50 AS Decimal(18, 2)), N'Phân bón lá tạo mầm hoa. Tránh phun lúc nắng gắt.', CAST(N'2026-03-07T07:44:10.6387901' AS DateTime2), CAST(N'2026-03-23T08:01:15.8645318' AS DateTime2), 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (39, N'sp0039', N'CHOCASO', N'Chocaso là thuốc tăng trưởng sinh học chiết xuất hoàn toàn tự nhiên, an toàn, không làm thay đổi hương vị tự nhiên của chè. Giúp phát triển bộ rễ, tăng khả năng chịu hạn, tái tạo búp chè mạnh, bật búp tối đa và nâng cao năng suất cây trồng.', N'### **Lượng nước phun**
* 500 – 600 lít/ha
### **Đối với cây chè**
* Phun sau thu hoạch **3 – 5 ngày**
* Phun khi cây **ra búp non khoảng 1cm**
* Phun khi **trời mát**, tránh **nắng gắt**
### **Thời gian cách ly**
* Không khuyến cáo
### **Hướng dẫn an toàn**
* Mang đầy đủ đồ bảo hộ
* Không ăn uống, hút thuốc khi pha và phun
* Không súc rửa dụng cụ tại ao hồ, nguồn nước sinh hoạt
* Để xa tầm tay trẻ em
* Bao bì sau sử dụng tiêu hủy đúng quy định
### **Sơ cứu**
* Dính vào mắt: Rửa nước sạch 15 – 20 phút
* Dính vào da: Rửa bằng xà phòng và nước
* Ngộ độc: Đến cơ sở y tế gần nhất, mang theo nhãn thuốc', N'Polyphenol chiết xuất từ than bùn và lá cây vải (Litchi chinensis Sonn): 0,11 g/l; Phụ gia và dung môi: vừa đủ 1 lít; Quy cách: Chai 240 ml', CAST(300000.00 AS Decimal(18, 2)), 46, 365, NULL, N'Chè (Trà)', 4, 0, CAST(0.60 AS Decimal(18, 2)), N'Chiết xuất tự nhiên, không làm thay đổi hương vị chè. An toàn.', CAST(N'2026-03-07T07:44:10.6387905' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (40, N'sp0040', N'NKP TE', N'Phân NPK 16-16-8+TE sản xuất theo công nghệ hơi nước, đạt tiêu chuẩn Hàn Quốc. Chuyên dùng cho lúa và nhiều loại cây trồng, giúp cây sinh trưởng mạnh, giảm lượng bón và bổ sung vi lượng Bo, Kẽm giúp cây phát triển cân đối.', N'### **Lúa, bắp**
* 350 – 450 kg/ha/vụ
### **Cây công nghiệp**
* 300 – 500 kg/ha/đợt
### **Cây ăn trái**
* 1,5 – 2 kg/cây/lần
### **Rau đậu**
* 200 – 300 kg/ha/vụ', N'Đạm (Nts): 16%; Lân (P2O5hh): 16%; Kali (K2Ohh): 8%; Boron (B): 310 ppm; Kẽm (Zn): 800 ppm; Độ ẩm: 2%', CAST(230000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa, Cây công nghiệp', 4, 0, CAST(400.00 AS Decimal(18, 2)), N'Bón đúng liều lượng khuyến cáo. Tưới nước sau khi bón.', CAST(N'2026-03-07T07:44:10.6387909' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (41, N'sp0041', N'ZINEB BUL 80WP', N'Thuốc trừ nấm tiếp xúc, phòng trừ hiệu quả nhiều bệnh nấm hại trên cây trồng. Đồng thời cung cấp vi lượng kẽm (Zn++) giúp cây khỏe, tăng sức đề kháng.', N'### **Cà chua**
* Đốm vàng – 1,2 kg/ha
### **Khoai tây**
* Mốc sương – 1,0 – 1,5 kg/ha
### **Cam**
* Bệnh sẹo – 1,0 – 1,5 kg/ha
### **Nho**
* Phấn trắng – 1,5 kg/ha
### **Lúa**
* Lem lép hạt – 1,5 kg/ha
### **Lưu ý**
* Không pha chung với thuốc có tính kiềm
* Phun ướt đều tán lá
### **An toàn**
* Tránh xa trẻ em, thực phẩm, nguồn nước
* Bảo quản nơi khô ráo, thoáng mát', N'Hoạt chất: Zineb 80% w/w; Chất mang và phụ gia: 20% w/w', CAST(170000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Cà chua, Khoai tây, Cam', 3, 14, CAST(1.50 AS Decimal(18, 2)), N'Không pha chung với thuốc có tính kiềm. Nguy hiểm nếu hít phải bột thuốc.', CAST(N'2026-03-07T07:44:10.6387913' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (42, N'sp0042', N'ZIN 80 WP', N'Thuốc trừ nấm tác dụng tiếp xúc, phòng trừ hiệu quả nhiều bệnh hại trên cây trồng. Đồng thời cung cấp kẽm (Zn) giúp lá xanh bền, chậm già. Phổ tác dụng rộng trên khoai tây, thuốc lá, lúa và nhiều cây trồng khác.', N'### **Khoai tây**
* Mốc sương – 1,5 – 2,0 kg/ha  
* Pha 80 – 120 g/bình 16 – 25 lít nước  
### **Thuốc lá**
* Mốc xanh – 1,0 kg/ha  
* Pha 40 – 60 g/bình 16 – 25 lít nước  
### **Lúa**
* Lem lép hạt – 1,5 kg/ha  
* Pha 60 – 90 g/bình 16 – 25 lít nước  
### **Lưu ý**
* Thời gian cách ly: **14 ngày**
* Phun ướt đều tán lá
* Không phun khi nắng gắt hoặc cây đang nở hoa
### **An toàn**
* Nhóm độc III – ít độc với người, gia súc và cá
* Không độc với ong mật
* Tránh xa trẻ em, thực phẩm và nguồn nước', N'Hoạt chất: Zineb 80% w/w; Phụ gia chuyên dùng: 20% w/w', CAST(210000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Khoai tây, Lúa', 3, 14, CAST(2.00 AS Decimal(18, 2)), N'Ít độc với cá và ong. Mang bảo hộ khi phun. Cách ly 14 ngày.', CAST(N'2026-03-07T07:44:10.6387916' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (43, N'sp0043', N'XINAZO', N'XINAZO 250 SC là thuốc trừ nấm phổ rộng, có tác dụng nội hấp và lưu dẫn mạnh. Thuốc ức chế sự hình thành và nảy mầm bào tử nấm, giúp phòng và trị hiệu quả bệnh thán thư trên xoài.', N'### **Cây trồng: Xoài**
* Bệnh hại: Thán thư
### **Liều lượng & cách pha**
* Nồng độ 0,06%
* Pha 15 ml/bình 20 – 25 lít nước  
* Hoặc 120 ml/phuy 200 lít nước
### **Lượng nước phun**
* 600 lít/ha
### **Thời điểm phun**
* Khi bệnh mới xuất hiện (tỷ lệ ~5%)
### **Lưu ý**
* Thời gian cách ly: **7 ngày**
* Không phun khi nắng gắt hoặc cây đang nở hoa
### **An toàn**
* Tránh xa trẻ em, thực phẩm và nguồn nước
* Tuân thủ quy định an toàn lao động', N'Hoạt chất: Azoxystrobin 250 g/l; Dung môi và phụ gia: vừa đủ 1 lít', CAST(200000.00 AS Decimal(18, 2)), 48, 365, NULL, N'Xoài', 3, 7, CAST(0.60 AS Decimal(18, 2)), N'Tuân thủ an toàn lao động. Tránh phun khi trời nắng nóng.', CAST(N'2026-03-07T07:44:10.6387920' AS DateTime2), CAST(N'2026-03-19T04:50:41.0462983' AS DateTime2), 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (44, N'sp0044', N'VANICIDE', N'VANICIDE là thuốc trừ bệnh sinh học, đặc trị các bệnh do nấm Rhizoctonia, Corticium, Sclerotium gây ra như khô vằn, lở cổ rễ, thối gốc và nấm hồng trên nhiều loại cây trồng.', N'### **VANICIDE 3SL – Lúa**
* Khô vằn – 1,5 L/ha
* Pha 60 – 90 ml/bình 16 – 25 lít nước
### **VANICIDE 5SL – Lúa**
* Khô vằn – 1,0 L/ha
* Pha 40 – 60 ml/bình 16 – 25 lít nước
### **Cao su**
* Nấm hồng – 2,5 L/ha
* Pha 500 ml/100 lít nước
### **Lưu ý**
* Thời gian cách ly: **7 ngày**
* Không pha chung với thuốc gốc đồng hoặc thuốc vi sinh
* Phun khi bệnh mới xuất hiện
### **An toàn**
* Thuốc ít độc – LD50 > 20.000 mg/kg
* Không độc với cá và ong mật
* Tránh xa trẻ em, thực phẩm và nguồn nước', N'Hoạt chất: Validamycin A (3% hoặc 5% w/w); Nguồn gốc sinh học từ nấm Streptomyces hygroscopicus; Phụ gia và dung môi vừa đủ', CAST(175000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa, Cao su', 4, 7, CAST(1.50 AS Decimal(18, 2)), N'Thuốc ít độc. Không pha chung với thuốc gốc đồng hoặc vi sinh khác.', CAST(N'2026-03-07T07:44:10.6387923' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (45, N'sp0045', N'UNITIL', N'Thuốc có tác dụng nội hấp mạnh. Đặc trị bệnh đạo ôn lá và bệnh cháy bìa lá (do vi khuẩn) trên lúa. Giúp làm khô nhanh vết bệnh và duy trì hiệu lực kéo dài.', N'# **HƯỚNG DẪN SỬ DỤNG THUỐC TRÊN CÂY LÚA**
## **Cây trồng:** Lúa
### **Bệnh hại**
- Đạo ôn lá
- Cháy bìa lá (do vi khuẩn)
### **Liều lượng & cách pha**
- Pha **40 g thuốc cho bình 25 lít nước**
### **Lượng nước phun**
- **400 – 500 lít nước/ha**
### **Thời điểm phun**
- Phun sớm khi xuất hiện vết bệnh đầu tiên  
- Đạo ôn lá: khi xuất hiện vết chấm kim  
- Cháy bìa lá: khi bệnh mới xuất hiện  
- Phun buổi sáng sớm hoặc chiều mát  
- Không phun khi trời mưa  
- Bệnh nặng: phun nhắc lại sau **5 – 7 ngày**
### **Lưu ý**
- Thời gian cách ly: **7 ngày trước thu hoạch**
### **An toàn**
- Mang đầy đủ đồ bảo hộ lao động khi sử dụng
- Không ăn uống, hút thuốc khi pha và phun
- Không rửa dụng cụ tại nguồn nước sinh hoạt
- Để xa trẻ em, thực phẩm và thức ăn chăn nuôi
### **Sơ cứu**
- Dính mắt: rửa nước sạch 15 – 20 phút
- Dính da: rửa bằng xà phòng và nước sạch
- Nuốt phải: không gây nôn, đưa đến cơ sở y tế và mang theo nhãn thuốc', N'Hoạt chất: Kasugamycin 2% w/w; Tricyclazole 30% w/w; Phụ gia: 68% w/w; Quy cách: Gói 40 g', CAST(260000.00 AS Decimal(18, 2)), 57, 365, NULL, N'Lúa', 3, 7, CAST(0.80 AS Decimal(18, 2)), N'Trị đạo ôn và vi khuẩn. Không gây nôn nếu nuốt phải, đưa ngay đến y tế.', CAST(N'2026-03-07T07:44:10.6387926' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (46, N'sp0046', N'BASU 250WP', N'Thuốc đặc trị vi khuẩn, có tác dụng nội hấp và thấm sâu vào cây. Đặc trị các bệnh do vi khuẩn gây ra như cháy bìa lá (bạc lá) trên lúa, thối nhũn trên bắp cải, héo rũ trên khoai lang, đốm lá vi khuẩn trên hành.', N'### **CÂY TRỒNG: LÚA**
### **Bệnh hại**
- Đạo ôn lá
- Đạo ôn cổ bông
### **Liều lượng & cách pha**
- **0,5 – 0,6 lít/ha**
- Pha **20 – 30 ml thuốc/bình 16 – 25 lít nước**
### **Lượng nước phun**
- **500 lít/ha**
### **Thời điểm phun**
- Đạo ôn lá: khi bệnh mới chớm xuất hiện
- Đạo ôn cổ bông: khi lúa sắp trổ hoặc vừa trổ xong
- Bệnh nặng: phun **2 lần**, cách nhau **7 ngày**
### **Lưu ý**
- Thời gian cách ly: **14 ngày trước thu hoạch**
- Có thể pha chung với thuốc khác **trừ thuốc có tính kiềm**
- Chỉ phun khi lá khô, lúa đã ráo sương
- Không sử dụng phân chứa đạm khi lúa bị đạo ôn
- Phun ướt đều cây trồng
### **An toàn**
- Mang đầy đủ bảo hộ lao động
- Không ăn uống, hút thuốc khi sử dụng
- Không rửa dụng cụ tại ao hồ, nguồn nước sinh hoạt
- Để xa trẻ em, thực phẩm và thức ăn gia súc
### **Sơ cứu**
- Dính mắt: rửa nước sạch 15 – 20 phút
- Dính da: rửa bằng xà phòng và nước sạch
- Nuốt phải: không gây nôn, đưa đến cơ sở y tế và mang theo nhãn thuốc', N'Hoạt chất: Bismerthiazol 250 g/kg; Phụ gia: 750 g/kg; Quy cách: Gói 80 g, Gói 400 g', CAST(150000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa, Bắp cải', 3, 14, CAST(0.60 AS Decimal(18, 2)), N'Đặc trị vi khuẩn. Không dùng chung với phân đạm khi lúa bệnh.', CAST(N'2026-03-07T07:44:10.6387930' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (47, N'sp0047', N'KEEP 300SC', N'Công thức mới đặc trị bệnh đạo ôn trên lúa. Phù hợp với nền nông nghiệp an toàn. Dạng dung dịch tiện lợi khi sử dụng, không gây nóng lúa, giúp lá lúa xanh đứng, phát triển tốt. Hỗ trợ dọn sạch lá chân, giúp ruộng thông thoáng.', N'### **Cây ăn trái (Sầu riêng, cây có múi, xoài, na, thanh long, nhãn...)**
- **Liều lượng:** Pha 25 – 50 g/25 lít nước hoặc 200 – 400 g/phuy 200 lít nước
- **Thời điểm:** Giai đoạn phân hóa mầm hoa, trái non và dưỡng trái
### **Rau (Bắp cải, súp lơ, khoai tây, cà chua, ớt, dưa hấu, dưa leo, đậu cove...)**
- **Liều lượng:** Pha 25 – 50 g/25 lít nước hoặc 200 – 400 g/phuy 200 lít nước
- **Thời điểm:** - Rau ăn trái: sau hồi xanh, trước ra hoa, trái non  
  - Rau lấy củ: sau hồi xanh, phun 1 – 2 lần/vụ
### **Cây lương thực (Lúa, bắp...)**
- **Liều lượng:** Pha 12,5 – 25 g/25 lít nước hoặc 100 – 200 g/phuy 200 lít
- **Thời điểm:** 30, 45 và 55 ngày sau gieo
### **Đậu đỗ**
- **Liều lượng:** Pha 12,5 – 25 g/25 lít nước hoặc 100 – 200 g/phuy 200 lít
- **Thời điểm:** Trước và sau khi ra hoa
### **Lưu ý**
- Không phun lúc nắng gắt hoặc khi cây đang nở hoa rộ
- Có thể pha chung với các loại thuốc khác
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát
- Tránh xa tầm tay trẻ em, thực phẩm và nguồn nước sinh hoạt', N'Hoạt chất: Fenoxanil 200 g/l; Hexaconazole 100 g/l; Phụ gia và dung môi: 700 g/l', CAST(175000.00 AS Decimal(18, 2)), 20, 365, NULL, N'Lúa, Cây ăn trái', 3, 7, CAST(0.50 AS Decimal(18, 2)), N'Phù hợp nông nghiệp an toàn. Bảo quản nơi thoáng mát.', CAST(N'2026-03-07T07:44:10.6387933' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (48, N'sp0048', N'ATANIL', N'Thuốc đặc trị bệnh cháy bìa lá (bạc lá lúa) do vi khuẩn Xanthomonas oryzae gây ra. Thuốc có tác dụng tiếp xúc và lưu dẫn nhanh trong cây, giúp làm khô nhanh vết bệnh sau 1 – 2 ngày phun.', N'### **CÂY TRỒNG: Lúa**
### **Bệnh hại**
- Cháy bìa lá (bạc lá lúa) do vi khuẩn *Xanthomonas oryzae*
### **Liều lượng & cách pha**
- Liều lượng cụ thể: **tham khảo hướng dẫn trên bao bì sản phẩm**
### **Lượng nước phun**
- **400 – 500 lít/ha**
### **Thời điểm phun**
- Phun khi vết bệnh chớm xuất hiện
### **Lưu ý**
- Thời gian cách ly: **10 ngày trước thu hoạch**
- Phun ướt đều toàn bộ cây trồng
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát
- Mang đầy đủ đồ bảo hộ lao động
- Tránh xa trẻ em, thực phẩm và nguồn nước sinh hoạt', N'Hoạt chất: Bismerthiazol 250 g/kg; Phụ gia: 750 g/kg; Quy cách: Gói 80 g, Gói 400 g', CAST(230000.00 AS Decimal(18, 2)), 0, 365, NULL, N'Lúa', 3, 10, CAST(0.50 AS Decimal(18, 2)), N'Trị bạc lá lúa. Mang đầy đủ bảo hộ khi phun.', CAST(N'2026-03-07T07:44:10.6387937' AS DateTime2), NULL, 0, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (49, N'sp0049', N'BIOMYCIN', N'Thuốc có tác dụng tiếp xúc và nội hấp cực mạnh, tiêu diệt vi khuẩn nhanh, chặn đứng sự lây lan bệnh, làm khô nhanh vết bệnh và cho hiệu lực kéo dài. Đặc trị các bệnh vi khuẩn trên lúa như cháy bìa lá và lép vàng.', N'### **Lúa**
- **Bệnh hại:** Cháy bìa lá
- **Liều lượng:** 2 bình 16 lít/1.000 m²
- **Lượng nước:** 400 – 500 lít/ha
- **Thời điểm:** Khi bệnh chớm xuất hiện
### **Bắp cải**
- **Bệnh hại:** Thối nhũn
- **Liều lượng:** 2 bình 16 lít/1.000 m²
### **Khoai lang**
- **Bệnh hại:** Héo rũ
- **Liều lượng:** 2 bình 16 lít/1.000 m²
### **Hành**
- **Bệnh hại:** Đốm lá vi khuẩn
- **Liều lượng:** 2 bình 16 lít/1.000 m²
### **Lưu ý**
- Thời gian cách ly:
  - Lúa: **10 ngày**
  - Rau màu: **7 ngày**
- Phun ướt đều cây trồng
### **An toàn & bảo quản**
- Mang đầy đủ đồ bảo hộ
- Không ăn uống, hút thuốc khi phun
- Tránh xa trẻ em, thực phẩm và nguồn nước', N'Hoạt chất: Bronopol 40,5% w/w; Phụ gia: 59,5% w/w; Quy cách: Gói 18 g, Gói 180 g', CAST(185000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa, Rau màu', 3, 10, CAST(0.40 AS Decimal(18, 2)), N'Cắt đứt bệnh nhanh. Không ăn uống khi phun thuốc.', CAST(N'2026-03-07T07:44:10.6387940' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (50, N'sp0050', N'Regent', N'Thuốc trừ sâu Regent là sản phẩm đặc trị sâu cuốn lá, sâu đục thân và bọ trĩ cho các loại cây trồng bao gồm cả cây lương thực, cây ăn trái và cây trồng trong nông nghiệp. Với cơ chế hoạt động tấn công và làm tê liệt hệ thần kinh trung ương nhờ hoạt chất Fipronil, thuốc Regent có thể nhanh chóng tiêu diệt sâu bệnh và côn trùng gây hại.', N'### **Dùng để xử lý ngâm hạt lúa giống**
- Bà con nên sử dụng thuốc trừ sâu Regent dạng chai đậm đặc, dùng khoảng **80 ml cho lượng hạt trong 1000 m²**.
---
### **Dùng để tiêu diệt, phòng trừ côn trùng hoặc sâu bệnh cho cây**
- Với thuốc sâu Regent hạt dạng gói:
  - Gói **0,8 g** pha với **8 lít nước**
  - Gói **1,6 g** pha với **16 lít nước**', N'Fipronil: 200 g/kg', CAST(199000.00 AS Decimal(18, 2)), 49, NULL, CAST(N'2025-08-28T00:00:00.0000000' AS DateTime2), NULL, 0, 0, NULL, NULL, CAST(N'2026-03-07T07:44:10.6387943' AS DateTime2), CAST(N'2026-03-19T04:33:54.4082565' AS DateTime2), 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (51, N'sp0051', N'TRIZOLE 400SC', N'Trizole 400 SC là thuốc trừ nấm chuyên trị bệnh đạo ôn trên cây lúa. Thuốc có khả năng nội hấp mạnh, cho hiệu quả nhanh và kéo dài, giúp bảo vệ cây lúa hiệu quả, giảm số lần phun và tiết kiệm chi phí.', N'### **CÂY TRỒNG: Lúa**
- **Bệnh hại:** Đạo ôn (lá và cổ bông)
### **Liều lượng & cách pha**
- **0,5 – 0,6 lít/ha**
- Pha **20 – 30 ml thuốc/bình 16 – 25 lít nước**
### **Lượng nước phun**
- **500 lít/ha**
### **Thời điểm phun**
- Đạo ôn lá: Phun khi bệnh mới chớm xuất hiện
- Đạo ôn cổ bông: Phun ngừa khi lúa sắp trổ hoặc vừa trổ xong
- Khi bệnh phát triển mạnh: Phun **2 lần**, cách nhau **7 ngày**
### **Lưu ý**
- **Thời gian cách ly:** 14 ngày trước thu hoạch
- Có thể kết hợp Trizole với **KISAIGON dạng hạt**
- Chỉ phun khi lúa đã ráo sương, lá khô
- Không sử dụng phân chứa đạm khi lúa đang bị bệnh
- Có thể pha chung với thuốc khác, **trừ thuốc có tính kiềm**
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát
- Mang đầy đủ đồ bảo hộ khi sử dụng
- Tránh xa trẻ em, thực phẩm và nguồn nước', N'Hoạt chất: Tricyclazole 400 g/lít; Phụ gia, dung môi: vừa đủ 1 lít', CAST(210000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 3, 14, CAST(0.60 AS Decimal(18, 2)), N'Đặc trị đạo ôn. Không pha với thuốc có tính kiềm.', CAST(N'2026-03-07T07:44:10.6387946' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (52, N'sp0052', N'TRIZOLE 75WP', N'Trizole 75WP là thuốc trừ nấm phòng và trị bệnh đạo ôn trên cây lúa do nấm Pyricularia oryzae gây ra. Thuốc ức chế sự phát triển của mầm bệnh trên lá, cổ lá, cổ bông và hạt lúa, cho hiệu lực kéo dài, giúp giảm số lần phun và tiết kiệm chi phí.', N'### **CÂY TRỒNG: Lúa**
### **Bệnh hại: Đạo ôn lá**
- **Liều lượng:** 0,2 – 0,3 kg/ha
- **Cách pha:** 4 – 5 g thuốc/bình 8 lít nước
- **Lượng nước:** 320 – 600 lít/ha
- **Thời điểm:** Khi bệnh mới chớm xuất hiện
### **Bệnh hại: Đạo ôn bông**
- **Liều lượng:** Tương tự đạo ôn lá
- **Thời điểm:** Trước trổ 5 – 7 ngày và khi lúa trổ đều
### **Lưu ý**
- Phun vào sáng sớm hoặc chiều mát
- Tránh phun khi vỏ trấu đang mở
- Khi bệnh nặng có thể kết hợp **KISAIGON 10H dạng hạt**
- Không để ruộng khô khi có bệnh
- Ngưng bón phân đạm
- Có thể pha chung thuốc khác, **không pha với thuốc có tính kiềm cao**
- Phun ướt đều cây trồng
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát
- Đậy kín bao bì sau khi sử dụng', N'Hoạt chất: Tricyclazole 75% w/w; Phụ gia: vừa đủ 100% w/w', CAST(260000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 3, 14, CAST(0.30 AS Decimal(18, 2)), N'Hiệu lực kéo dài. Không để ruộng khô khi xử lý bệnh.', CAST(N'2026-03-07T07:44:10.6387949' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (53, N'sp0053', N'TRIZOLE 75 DO', N'Trizole 75 DO là thuốc trừ nấm có tính nội hấp nhanh, chuyên trị bệnh đạo ôn trên lúa gồm đạo ôn lá và đạo ôn cổ bông, giúp kiểm soát bệnh hiệu quả và kéo dài.', N'### **CÂY TRỒNG: Lúa**
- **Bệnh hại:** Đạo ôn lá, đạo ôn cổ bông
- **Liều lượng:** 12,5 – 25 g/25 lít nước
- **Cách dùng:** Phun khi bệnh chớm xuất hiện
- **Thời điểm:** 30, 45 và 55 ngày sau gieo
### **Lưu ý**
- Không phun khi trời nắng gắt
- Có thể pha chung với thuốc khác', N'Hoạt chất: Tricyclazole 75% w/w; Chất mang, phụ gia: 25% w/w', CAST(240000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 3, 14, CAST(0.50 AS Decimal(18, 2)), N'Nội hấp nhanh. Bảo quản nơi khô ráo, tránh xa trẻ em.', CAST(N'2026-03-07T07:44:10.6387953' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (54, N'sp0054', N'TRI 75WG', N'TRI 75WG là thuốc trừ bệnh lưu dẫn mạnh, phòng trị hiệu quả bệnh đạo ôn lá và đạo ôn cổ bông trên lúa.', N'### **LÚA**
- **Liều lượng:** 1 gói 30g/bình 25 lít
- **Lượng nước:** 400 lít/ha
- **Thời điểm:** Khi bệnh chớm xuất hiện hoặc lúa trổ
### **Lưu ý**
- Thời gian cách ly: 7 ngày
- Phun ướt đều cây trồng', N'Hoạt chất: Tricyclazole 75% w/w; Phụ gia: 25% w/w', CAST(240000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 3, 7, CAST(0.40 AS Decimal(18, 2)), N'Lưu dẫn mạnh. Phun ướt đều tán lá.', CAST(N'2026-03-07T07:44:10.6387956' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (55, N'sp0055', N'TREPPACH BUL', N'TREPPACH BUL là thuốc trừ nấm lưu dẫn, hấp thu nhanh qua rễ và lá, hiệu quả cao trong phòng trị bệnh xì mủ, sương mai và chết nhanh trên nhiều loại cây trồng.', N'### **SẦU RIÊNG**
- **Bệnh hại:** Xì mủ
- **Liều lượng:** 250 – 300 ml/100 lít nước
- **Cách dùng:** Phun hoặc tưới gốc
### **Lưu ý**
- Phun khi bệnh chớm xuất hiện
- Có thể xử lý định kỳ', N'Hoạt chất: Propamocarb 607 g/l; Phụ gia: vừa đủ 1 lít', CAST(220000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Sầu riêng', 3, 7, CAST(3.00 AS Decimal(18, 2)), N'Trị nấm Phytophthora. Có thể tưới gốc hoặc phun.', CAST(N'2026-03-07T07:44:10.6387959' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (56, N'sp0056', N'SAIPORA', N'SAIPORA là thuốc trừ nấm có tác dụng nhanh và hiệu lực kéo dài, phổ tác dụng rộng, được đăng ký đặc trị bệnh khô vằn hại lúa.', N'### **LÚA**
- **Bệnh hại:** Khô vằn
- **Liều lượng:** 0,8 lít/ha
- **Cách pha:** 40 ml/bình 25 lít nước (2 bình/1000 m²)
- **Lượng nước:** 400 – 500 lít/ha
- **Thời điểm:** Phun sớm khi bệnh mới xuất hiện
### **Lưu ý**
- Phun đủ lượng nước để thuốc phủ đều cây trồng
### **An toàn & bảo quản**
- Bảo quản trong bao bì gốc, nơi khô ráo, thoáng mát
- Mang đầy đủ đồ bảo hộ khi sử dụng', N'Hoạt chất: Iprodione 250 g/l; Hexaconazole 100 g/l; Dung môi, phụ gia: vừa đủ 1 lít', CAST(210000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 3, 7, CAST(0.80 AS Decimal(18, 2)), N'Trị khô vằn. Phun đủ lượng nước để thuốc phủ đều.', CAST(N'2026-03-07T07:44:10.6387990' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (57, N'sp0057', N'SAGOPERFECT 320', N'SAGOPERFECT 320 là thuốc trừ nấm có phổ tác dụng rộng, được đăng ký phòng trị bệnh thán thư trên cây cà phê.', N'### **CÂY TRỒNG: Cà phê**
- **Bệnh hại:** Thán thư
- **Liều lượng:** Nồng độ 0,15%
- **Cách pha:** 150 ml/100 lít nước
- **Lượng nước:** 600 – 1000 lít/ha
- **Thời điểm:** Khi bệnh mới xuất hiện (tỷ lệ bệnh ~5%), phun lại sau 5 ngày
### **Lưu ý**
- Thời gian cách ly: 7 ngày trước thu hoạch
- Phun đủ nước để thuốc phủ đều cây trồng
### **An toàn & bảo quản**
- Giữ trong bao bì gốc, đậy kín nắp
- Mang đầy đủ đồ bảo hộ khi pha và phun', N'Hoạt chất: Picoxystrobin 200 g/l; Difenoconazole 120 g/l; Dung môi, phụ gia: vừa đủ 1 lít', CAST(270000.00 AS Decimal(18, 2)), 0, 365, NULL, N'Cà phê', 3, 7, CAST(1.00 AS Decimal(18, 2)), N'Trị thán thư. Đậy kín nắp sau khi sử dụng.', CAST(N'2026-03-07T07:44:10.6387994' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (58, N'sp0058', N'SAGOGRAIN 300EC', N'Diệt mầm bệnh nhanh chóng và mang lại hiệu lực kéo dài từ 2 đến 3 tuần. Có tác dụng phòng và trị bệnh, ngăn chặn sự phát triển của mầm bệnh từ giai đoạn đầu và tiếp tục kiểm soát bệnh ở giai đoạn sau. Thuốc còn giúp dưỡng cây lúa khỏe mạnh, lá xanh, cây cứng cáp, hạt lúa sáng bóng, mẩy. Đặc trị bệnh lem lép hạt và khô vằn trên lúa.', N'### **Cây trồng: Lúa**
* **Bệnh hại:** Lem lép hạt
* **Liều lượng & cách pha:**
    * Phun **0,3 lít/ha**
    * Pha **12 – 18 ml/bình 16 – 25 lít nước**
* **Lượng nước phun:** **400 lít/ha**
* **Thời điểm phun:** * Lần 1: Trước trổ 5 – 7 ngày hoặc khi lúa vừa trổ (nên phun chiều)
    * Lần 2: Khi lúa trổ đều
---
### **Cây trồng: Lúa**
* **Bệnh hại:** Khô vằn
* **Liều lượng & cách pha:**
    * Phun **0,35 lít/ha**
    * Pha **14 – 20 ml/bình 16 – 25 lít nước**
* **Lượng nước phun:** **400 lít/ha**
* **Thời điểm phun:** Khi bệnh mới chớm xuất hiện
---
### **Lưu ý**
* Thời gian cách ly: Tham khảo trên bao bì sản phẩm
* Không độc với ong mật, chim và trùn đất
* Có thể pha chung với thuốc khác, **không pha với thuốc có tính kiềm cao**
* Phun ướt đều cây trồng
---
### **An toàn & bảo quản**
* Bảo quản nơi khô ráo, thoáng mát, tránh ánh nắng
* Mang đầy đủ đồ bảo hộ khi sử dụng', N'Hoạt chất: Propiconazole + Difenoconazole (hỗn hợp) (tổng hàm lượng không ghi rõ, ký hiệu “300EC” có thể biểu thị tổng nồng độ 300 g/l); Dung môi, phụ gia: vừa đủ 1 lít', CAST(310000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 3, 14, CAST(0.35 AS Decimal(18, 2)), N'Trị lem lép hạt. Không độc với ong mật và chim.', CAST(N'2026-03-07T07:44:10.6387997' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (59, N'sp0059', N'ROTEVA 30SC', N'ROTEVA 30SC giúp trị bệnh và kích thích sinh trưởng cho cây trồng, mang lại hiệu quả bảo vệ lâu dài. Sản phẩm được đăng ký trị bệnh sương mai trên cà chua và bệnh thán thư trên ớt.', N'### **Cây trồng: Cà chua**
* **Bệnh hại:** Sương mai
* **Lượng nước phun:** **500 lít/ha**
* **Thời điểm phun:** Khi bệnh mới xuất hiện, tỷ lệ bệnh khoảng **5%**
---
### **Cây trồng: Ớt**
* **Bệnh hại:** Thán thư
* **Lượng nước phun:** **500 lít/ha**
* **Thời điểm phun:** Khi bệnh mới xuất hiện, tỷ lệ bệnh khoảng **5%**
---
### **Lưu ý**
* **Thời gian cách ly:** **7 ngày**
* Phun ướt đều cây trồng để đạt hiệu quả tối ưu
---
### **An toàn & bảo quản**
* Bảo quản nơi râm mát, nhiệt độ không quá **30°C**
* Đậy kín nắp sau khi sử dụng
* Tránh xa tầm tay trẻ em và thực phẩm
* Mang đồ bảo hộ khi tiếp xúc thuốc', N'Hoạt chất: Boscalid 20% w/w; Pyraclostrobin 10% w/w; Phụ gia: vừa đủ 100% w/w', CAST(150000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Cà chua, Ớt', 3, 7, CAST(0.50 AS Decimal(18, 2)), N'Bảo quản nơi râm mát < 30 độ C. Tránh xa thực phẩm.', CAST(N'2026-03-07T07:44:10.6388000' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (60, N'sp0060', N'PYROLAX 250EC', N'Thuốc có tác dụng phòng và trị bệnh. Đặc trị bệnh thán thư trên Tiêu. Kích thích sinh trưởng trên Cà phê và Lạc (đậu phộng).', N'### **Cây trồng: Tiêu**
- **Bệnh hại:** Thán thư  
- **Liều lượng & cách pha:** Nồng độ **0,1%** – Pha **100 ml/100 lít nước** - **Lượng nước phun:** **500 – 800 lít/ha** - **Thời điểm phun:** Khi tỷ lệ bệnh khoảng **5%**
---
### **Cây trồng: Cà phê**
- **Mục đích:** Kích thích sinh trưởng  
- **Liều lượng & cách pha:** **0,45 lít/ha** – Pha **20 – 25 ml/bình 25 lít** - **Lượng nước phun:** **500 – 600 lít/ha** - **Thời điểm phun:** - Lần 1: Khi cây bắt đầu ra hoa  
  - Lần 2: Khi cây hình thành quả
---
### **Cây trồng: Lạc (đậu phộng)**
- **Mục đích:** Kích thích sinh trưởng  
- **Liều lượng & cách pha:** **0,45 lít/ha** – Pha **20 – 25 ml/bình 25 lít** - **Lượng nước phun:** **500 – 600 lít/ha** - **Thời điểm phun:** - Lần 1: Khi cây bắt đầu ra hoa  
  - Lần 2: Khi cây hình thành củ
---
### **Lưu ý**
- **Thời gian cách ly:** • Tiêu: **7 ngày** • Cà phê: **45 ngày** • Lạc: **14 ngày** - Phun ướt đều hai mặt lá  
- Nên phun sáng sớm hoặc chiều mát  
- Không pha chung với thuốc có tính kiềm
---
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát  
- Không phun vào ao hồ, nguồn nước nuôi thủy sản  
- Mang đầy đủ đồ bảo hộ khi sử dụng', N'Hoạt chất: Pyraclostrobin 250 g/l; Dung môi, phụ gia: 750 g/l (cho đủ 1 lít)', CAST(210000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Tiêu, Cà phê', 3, 45, CAST(0.80 AS Decimal(18, 2)), N'Lưu ý thời gian cách ly dài trên cà phê (45 ngày). Không phun xuống nguồn nước.', CAST(N'2026-03-07T07:44:10.6388004' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (61, N'sp0061', N'OTICIN 47.5WP', N'Thuốc phòng trị hiệu quả các bệnh do nấm và vi khuẩn gây ra. Không gây nóng bông, không ảnh hưởng đến trái non khi sử dụng đúng liều. Đặc trị bệnh rỉ sắt trên hoa cúc và bệnh cháy bìa lá do vi khuẩn trên lúa.', N'### **Cây trồng: Hoa cúc**
- **Bệnh hại:** Rỉ sắt  
- **Liều lượng:** **1,0 – 1,25 kg/ha** (2 – 2,5 gói 500g)  
- **Cách pha:** 1 gói **500g/200 lít nước** - **Lượng nước phun:** **400 – 500 lít/ha** - **Thời điểm phun:** Khi bệnh chớm xuất hiện hoặc phun phòng
---
### **Cây trồng: Lúa**
- **Bệnh hại:** Cháy bìa lá (vi khuẩn)  
- **Liều lượng:** **1,0 – 1,25 kg/ha** - **Cách pha:** 1 gói **500g/200 lít nước** - **Lượng nước phun:** **400 – 500 lít/ha** - **Thời điểm phun:** Khi bệnh chớm xuất hiện
---
### **Lưu ý**
- **Thời gian cách ly:** **7 ngày** - Không phun khi cây đang ra hoa, trời nắng gắt hoặc mưa  
- Không phối trộn với thuốc gốc lân hữu cơ, nhôm hoặc kháng sinh  
- Phun ướt đều cây trồng
---
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát  
- Mang đầy đủ đồ bảo hộ khi pha và phun  
- Tránh xa trẻ em, thực phẩm và thức ăn gia súc', N'Hoạt chất: Copper Hydroxide 22,9% w/w; Copper Oxychloride 24,6% w/w; Chất mang và phụ gia: 52,5% w/w', CAST(240000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Hoa cúc, Lúa', 3, 7, CAST(1.25 AS Decimal(18, 2)), N'Không phun khi cây đang ra hoa. Không pha với thuốc gốc nhôm hoặc kháng sinh.', CAST(N'2026-03-07T07:44:10.6388007' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (62, N'sp0062', N'MEXYL MZ', N'Thuốc phòng trị hiệu quả nhiều loại nấm bệnh hại cây. Mang lại hiệu lực cao và kéo dài trong việc bảo vệ cây trồng. Đặc trị bệnh chết nhanh trên tiêu và loét sọc mặt cạo trên cao su.', N'### **Cây trồng: Tiêu**
- **Bệnh hại:** Chết nhanh  
- **Liều lượng & cách pha:** Nồng độ **0,30 – 0,45%** (300 – 450 g/100 lít nước)  
- **Cách dùng:** Phun ướt đều tán lá hoặc tưới vào gốc  
- **Thời điểm:** Khi bệnh mới phát sinh
---
### **Cây trồng: Cao su**
- **Bệnh hại:** Loét sọc mặt cạo  
- **Liều lượng & cách pha:** Nồng độ **2,0%** (20 g/1 lít nước)  
- **Cách dùng:** Quét dung dịch thuốc lên vết bệnh  
- **Thời điểm:** Khi bệnh mới phát sinh
---
### **Lưu ý**
- Thời gian cách ly: Tham khảo trên bao bì sản phẩm  
- Khi bệnh nặng có thể xử lý **2 lần cách nhau 7 ngày** - Không pha với thuốc có tính kiềm cao (như Bordeaux)  
- Phun ướt đều cây trồng để đạt hiệu quả cao
---
### **An toàn & bảo quản**
- Giữ trong bao bì gốc, đậy kín  
- Để nơi khô ráo, thoáng mát  
- Mang đầy đủ đồ bảo hộ khi sử dụng', N'Hoạt chất: Metalaxyl 8% w/w; Mancozeb 64% w/w; Chất mang, phụ gia: 28% w/w', CAST(140000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Tiêu, Cao su', 3, 7, CAST(3.00 AS Decimal(18, 2)), N'Không pha với thuốc có tính kiềm cao (Bordeaux). Rửa tay sạch sau khi dùng.', CAST(N'2026-03-07T07:44:10.6388010' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (63, N'sp0063', N'LUSTER 250SC', N'Thuốc có tác dụng phòng trị đặc hiệu bệnh khô vằn hại lúa. Hiệu quả cao khi bệnh mới xuất hiện, bệnh nặng nên phun 2 lần cách nhau 7 ngày.', N'### **Lưu ý**
- **Thời gian cách ly:** 7 ngày  
- Có thể pha chung với nhiều loại thuốc trừ sâu bệnh khác (nên thử trước)  
- Phun ướt đều cây trồng để đạt hiệu quả tối ưu
---
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát  
- Mang đầy đủ đồ bảo hộ khi pha và phun  
- Không súc rửa dụng cụ tại ao hồ, nguồn nước sinh hoạt', N'Hoạt chất: Pencycuron 250 g/l; Dung môi, phụ gia: vừa đủ 1 lít', CAST(250000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 4, 7, CAST(0.80 AS Decimal(18, 2)), N'Không súc rửa dụng cụ tại nguồn nước sinh hoạt. Có thể pha chung với thuốc khác.', CAST(N'2026-03-07T07:44:10.6388014' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (64, N'sp0064', N'LUNASA 80', N'Giúp diệt nấm bệnh nhanh chóng và mang lại hiệu lực kéo dài. Sản phẩm được đăng ký trị bệnh lem lép hạt trên cây lúa.', N'### **Cây trồng: Lúa**
- **Bệnh hại:** Lem lép hạt  
- **Liều lượng & cách pha:** **0,4 lít/ha** – Pha **15 – 20 ml/bình 20 – 25 lít** - **Lượng nước phun:** **400 – 500 lít/ha** - **Thời điểm:** Phun sớm khi bệnh mới xuất hiện hoặc khi lúa bắt đầu trổ
---
### **Lưu ý**
- **Thời gian cách ly:** 7 ngày  
- Không pha với thuốc có tính kiềm cao  
- Phun ướt đều cây trồng  
- Đọc kỹ hướng dẫn trên nhãn trước khi dùng
---
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát  
- Tránh xa nguồn nhiệt, thực phẩm và thức ăn gia súc  
- Mang đầy đủ đồ bảo hộ khi sử dụng', N'Hoạt chất: Difenoconazole 125 g/l; Propiconazole 125 g/l; Dung môi, phụ gia: vừa đủ 1 lít; Quy cách: Chai 250 ml', CAST(220000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 3, 7, CAST(0.40 AS Decimal(18, 2)), N'Tránh xa nguồn nhiệt. Đọc kỹ hướng dẫn trước khi dùng.', CAST(N'2026-03-07T07:44:10.6388017' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (65, N'sp0065', N'LÚA VÀNG', N'Thuốc có hiệu quả cao trong phòng và trị các bệnh đạo ôn hại lúa, bao gồm: Đạo ôn trên lá (cháy lá), đạo ôn cổ bông, cổ gié (thối cổ bông, cổ gié), đạo ôn hạt lúa.', N'### **Cây trồng: Lúa**
- **Bệnh hại:** Đạo ôn (cháy lá, thối cổ bông, cổ gié)
- **Liều lượng & cách pha:** 1,0 kg/ha – Pha 40 – 60 g/bình 16 – 25 lít nước
- **Lượng nước phun:** Ít nhất 400 lít/ha
- **Thời điểm:**
  - Đạo ôn lá: Khi bệnh mới phát sinh
  - Đạo ôn cổ bông, cổ gié: Trước trổ và ngay sau khi trổ
---
### **Lưu ý**
- Có thể phun lại sau 7 – 10 ngày nếu bệnh phát triển
- Chỉ phun khi lá khô ráo
- Có thể pha chung thuốc khác (nên thử trước)
---
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát
- Mang đầy đủ đồ bảo hộ khi sử dụng', N'Hoạt chất: Tricyclazole 6% w/w; Iprobenfos 14% w/w; Phụ gia: vừa đủ 100% w/w', CAST(260000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 3, 14, CAST(1.00 AS Decimal(18, 2)), N'Trị đạo ôn cổ bông. Chỉ phun khi lá khô ráo.', CAST(N'2026-03-07T07:44:10.6388020' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (66, N'sp0066', N'KAISAIGON', N'Thuốc trừ nấm nội hấp, đặc trị các bệnh hại lúa như đạo ôn lá, đạo ôn cổ bông và thối thân.', N'### **Cách dùng chung**
- Rải đều thuốc xuống ruộng
- Giữ mực nước 3 – 5 cm trong 5 – 7 ngày sau khi rải
- Không trộn với phân đạm khi bệnh đã xuất hiện
---
### **Cây trồng: Lúa**
- **Đạo ôn lá:** 25 – 30 kg/ha
- **Đạo ôn cổ bông:** 25 – 40 kg/ha
- **Thối thân:** 25 – 30 kg/ha
---
### **An toàn & bảo quản**
- Mang đồ bảo hộ khi rải thuốc
- Bảo quản nơi khô ráo, thoáng mát', N'Hoạt chất: Isoprothiolane 10% w/w; Dạng hạt (GR); Phụ gia: vừa đủ', CAST(230000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 4, 14, CAST(30.00 AS Decimal(18, 2)), N'Dạng hạt để rải. Giữ mức nước ruộng 3-5cm sau khi rải.', CAST(N'2026-03-07T07:44:10.6388024' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (67, N'sp0067', N'KAISAIGON 10', N'Thuốc đặc trị các bệnh nấm hại lúa như đạo ôn lá, đạo ôn cổ bông và thối thân.', N'### **Cách dùng chung**
- Rải đều thuốc xuống ruộng
- Giữ mực nước 3 – 5 cm trong 5 – 7 ngày
- Không trộn với phân đạm khi bệnh đã xuất hiện
---
### **Cây trồng: Lúa**
- **Đạo ôn lá:** 25 – 30 kg/ha
- **Đạo ôn cổ bông:** 25 – 40 kg/ha
- **Thối thân:** 25 – 30 kg/ha
---
### **An toàn & bảo quản**
- Mang đồ bảo hộ khi sử dụng
- Bảo quản nơi khô ráo, thoáng mát', N'Hoạt chất: Isoprothiolane 10% w/w; Dạng hạt (GR); Phụ gia: vừa đủ', CAST(150000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 4, 14, CAST(30.00 AS Decimal(18, 2)), N'Không trộn với phân đạm khi lúa đang bệnh. Bảo quản nơi khô ráo.', CAST(N'2026-03-07T07:44:10.6388027' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (68, N'sp0068', N'CỐP XANH', N'Thuốc phòng trị hiệu quả nhiều loại bệnh hại quan trọng trên cây trồng như rỉ sắt cà phê, thán thư tiêu, mốc sương khoai tây và đốm đen hoa hồng.', N'### **Cây trồng: Cà Phê**
- **Bệnh hại:** Rỉ sắt
- **Liều lượng:** 1,0 – 1,25 kg/ha
- **Cách pha:** 200 – 250 g/100 lít nước
- **Lượng nước:** 500 lít/ha
---
### **Cây trồng: Tiêu**
- **Bệnh hại:** Thán thư
- **Nồng độ:** 0,5%
- **Cách pha:** 500 g/100 lít nước
- **Lượng nước:** 600 – 850 lít/ha
---
### **Cây trồng: Khoai Tây**
- **Bệnh hại:** Mốc sương
- **Liều lượng:** 2,0 – 2,5 kg/ha
- **Cách pha:** 80 – 100 g/bình 20 lít
- **Lượng nước:** 500 lít/ha
---
### **Cây trồng: Hoa Hồng**
- **Bệnh hại:** Đốm đen
- **Liều lượng:** 1,5 kg/ha
- **Cách pha:** 60 g/bình 20 lít
- **Lượng nước:** 500 lít/ha
---
### **Lưu ý**
- **Thời gian cách ly:** 14 ngày
- Phun lại sau 5 – 7 ngày nếu điều kiện thời tiết thuận lợi cho bệnh
---
### **Bảo quản**
- Nơi khô ráo, thoáng mát, tránh ánh sáng trực tiếp', N'Hoạt chất: Copper Oxychloride 17% w/w; Zineb 34% w/w; Chất mang, phụ gia: 49% w/w', CAST(250000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Cà phê, Tiêu', 3, 14, CAST(1.25 AS Decimal(18, 2)), N'Trị rỉ sắt, thán thư. Tránh ánh sáng trực tiếp.', CAST(N'2026-03-07T07:44:10.6388030' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (69, N'sp0069', N'HỎA TIỄN', N'HỎA TIỄN 50 SP là thuốc trừ bệnh vi khuẩn thế hệ mới, nội hấp mạnh, phổ tác dụng rộng, đặc trị bạc lá và cháy bìa lá lúa, đồng thời kích thích cây sinh trưởng.', N'### **Cây trồng: Lúa**
- **Bệnh hại:** Bạc lá, cháy bìa lá
#### Phun tay / máy thường
- **Liều lượng:** 0,5 kg/ha
- **Cách pha:** 25 g/bình 20 – 25 lít
- **Mật độ:** 2 bình/1000 m²
- **Lượng nước:** 400 – 500 lít/ha
#### Phun Drone
- **Liều lượng:** 500 g/ha
- **Cách pha:** 20 – 30 lít nước/ha
- **Thời điểm:** Khi bệnh mới xuất hiện, có thể phun lại sau 7 ngày nếu bệnh nặng
---
### **Lưu ý**
- Không pha với thuốc có tính kiềm
- Phun ướt đều cây trồng
---
### **An toàn & bảo quản**
- Mang đầy đủ đồ bảo hộ khi sử dụng
- Bảo quản nơi khô ráo, thoáng mát', N'Hoạt chất: Chlorobromoisocyanuric Acid 50% w/w; Chất mang, phụ gia: 50% w/w', CAST(250000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 3, 7, CAST(0.50 AS Decimal(18, 2)), N'Thuốc trừ vi khuẩn thế hệ mới. Không pha với thuốc tính kiềm.', CAST(N'2026-03-07T07:44:10.6388034' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (70, N'sp0070', N'HẠT VÀNG', N'HẠT VÀNG có khả năng phòng và trị hiệu quả các loại nấm khó trị như Fusarium sp, Botrytis sp, Corticium sp, Sclerotium, Rhizoctonia, Alternaria. Sản phẩm được đăng ký phòng trị lem lép hạt trên lúa và đốm quả (thối kim) trên nhãn.', N'### **HẠT VÀNG 50WP**
#### **Cây trồng: Lúa**
- **Bệnh hại:** Lem lép hạt
- **Liều lượng:** 0,3 – 0,5 kg/ha
- **Cách pha:** 20 – 30 g/bình 16 – 25 lít
- **Lượng nước:** 320 – 500 lít/ha
- **Thời điểm:** Trước trổ 5 – 7 ngày và khi lúa trổ đều
---
### **HẠT VÀNG 250SC**
#### **Cây trồng: Lúa**
- **Bệnh hại:** Lem lép hạt
- **Liều lượng:** 0,7 lít/ha
- **Cách pha:** 30 – 40 ml/bình 16 – 25 lít
- **Lượng nước:** 400 – 500 lít/ha
#### **Cây trồng: Nhãn**
- **Bệnh hại:** Đốm quả (thối kim)
- **Cách pha:** 300 ml/100 lít nước
- **Cách dùng:** Phun ướt đều tán cây
- **Thời điểm:** Khi trái non, lặp lại sau 10 – 15 ngày
---
### **Lưu ý**
- Thời gian cách ly: Xem trên bao bì
- Có thể pha chung với thuốc khác (nên thử trước với lượng nhỏ)', N'HẠT VÀNG 50WP:
• Hoạt chất: Iprodione 50% w/w
• Dạng bột thấm nước, màu vàng xám nhạt, mùi nhẹ
• Phụ gia: vừa đủ 100% w/w
HẠT VÀNG 250SC:
• Hoạt chất: Iprodione 250 g/l (tương đương 25% w/v)
• Dạng huyền phù nước (dạng sữa), màu vàng nhạt, mùi nhẹ
• Dung môi, phụ gia: vừa đủ 1 lít', CAST(215000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa, Nhãn', 3, 7, CAST(0.50 AS Decimal(18, 2)), N'Trị lem lép hạt. Có thể pha chung với thuốc khác.', CAST(N'2026-03-07T07:44:10.6388037' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (71, N'sp0071', N'EDIVIL 80WP', N'Edivil 80WP là sự kết hợp của 3 hoạt chất đặc trị đạo ôn, có tác dụng tiếp xúc và lưu dẫn mạnh, làm khô nhanh vết bệnh và cho hiệu lực kéo dài.', N'### **Ao hồ đang nuôi tôm**
- **Bệnh hại:** Rong đen mang, ký sinh trùng, rong nhớt đáy ao
- **Liều lượng:** 0,1 g/m³ nước
- **Cách dùng:** Hòa tan và tạt xuống ao, 1 lần/ngày, 2 – 3 ngày liên tục
### **Ao hồ chưa nuôi tôm**
- **Bệnh hại:** Rong nhớt đáy ao
- **Liều lượng:** 0,25 g/m³ nước
- **Cách dùng:** Tạt 1 lần/ngày, 2 – 3 ngày
### **Bè cá**
- **Bệnh hại:** Trắng mang, đỏ mang, lở loét, rận cá, bông gòn, thối đuôi
- **Liều lượng:** 0,3 g/m³ nước
- **Cách dùng:** Treo đầu bè, 1 lần/ngày trong 3 ngày
---
### **An toàn & bảo quản**
- Để trong bao bì gốc, nơi khô ráo, thoáng mát
- Tránh xa trẻ em, thực phẩm và nguồn nước sinh hoạt', N'Tricylazole 40% w/w; Isoprothiolane 25% w/w; Difenoconazole 15% w/w; Phụ gia 20% w/w', CAST(210000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Thủy sản (Tôm, Cá)', 3, 0, CAST(1.00 AS Decimal(18, 2)), N'Dùng xử lý nước ao nuôi. Tránh xa trẻ em.', CAST(N'2026-03-07T07:44:10.6388041' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (72, N'sp0072', N'DIPOMATE', N'DIPOMATE 430 SC là thuốc trừ nấm, đăng ký phòng trị lem lép hạt lúa. Cung cấp các trung và vi lượng cần thiết cho cây như Lưu huỳnh (S), Mangan (Mn), Kẽm (Zn), giúp kiểm soát nấm bệnh và tăng cường sức khỏe cây trồng.', N'### **Cây trồng: Lúa**
- **Dịch hại:** Lem lép hạt
- **Liều lượng:** 3,0 lít/ha
- **Cách pha:** 120 – 180 ml/bình 16 – 25 lít nước
- **Lượng nước phun:** 400 lít/ha
- **Thời điểm:** Phun khi lúa sắp trổ hoặc bắt đầu trổ. Bệnh nặng phun lần 2 sau khi trổ đều
---
### **Lưu ý**
- **Thời gian cách ly:** 7 ngày
- Phun ướt đều tán lá
---
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát
- Mang đồ bảo hộ khi pha và phun
- Tránh xa trẻ em, thực phẩm và nguồn nước sinh hoạt', N'Mancozeb 430 g/l; Dung môi, phụ gia: đủ 1 lít', CAST(220000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 3, 7, CAST(3.00 AS Decimal(18, 2)), N'Bổ sung vi lượng Kẽm, Mangan. Mang bảo hộ khi phun.', CAST(N'2026-03-07T07:44:10.6388044' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (73, N'sp0073', N'DIPOMATE 80', N'Phòng trị hiệu quả nhiều bệnh hại nguy hiểm như thán thư, rỉ sắt, lem lép hạt, đạo ôn, khô vằn, sương mai, mốc sương, chết nhanh, thối gốc, đốm lá trên nhiều loại cây trồng.', N'### **Cây trồng: Lúa**
- **Bệnh hại:** Lem lép hạt
- **Liều lượng:**
  - Dipomate 430SC: 3,0 lít/ha
  - Dipomate 80WP: 1,5 kg/ha
- **Cách dùng:** Phun khi lúa sắp trổ hoặc bắt đầu trổ. Bệnh nặng phun lần 2
---
### **Cây trồng: Cà chua**
- **Bệnh hại:** Sương mai
- **Liều lượng:** Dipomate 430SC: 1,7 – 2,3 kg/ha
- **Cách dùng:** Phun khi bệnh chớm xuất hiện
---
### **Cây trồng: Hoa cúc**
- **Bệnh hại:** Rỉ sắt
- **Liều lượng:** Dipomate 430SC: 1,7 – 2,3 kg/ha
- **Cách dùng:** Phun khi bệnh chớm xuất hiện
---
### **Lưu ý**
- **Thời gian cách ly:** 7 ngày
- Có thể pha chung với thuốc khác
- Phun ướt đều tán lá
---
### **An toàn & bảo quản**
- Đeo đồ bảo hộ khi sử dụng
- Không ăn uống khi pha, phun
- Tránh xa trẻ em và nguồn nước', N'Dipomate 80WP: Dạng bột, chứa 80% hoạt chất Mancozeb
Dipomate 430SC: Dạng lỏng, chứa 43% hoạt chất Mancozeb', CAST(130000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa, Cà chua', 3, 7, CAST(1.50 AS Decimal(18, 2)), N'Phổ rộng, phòng trừ nhiều bệnh. Không ăn uống khi pha thuốc.', CAST(N'2026-03-07T07:44:10.6388074' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (74, N'sp0074', N'CLEARNER 75 WP', N'CLEARNER 75 WP là thuốc trừ nấm tác dụng tiếp xúc, phổ tác dụng rộng. Đặc trị thán thư trên ớt, xoài; sẹo trên cam, quýt và sương mai trên dưa hấu.', N'### **Cây trồng: Ớt**
- **Bệnh hại:** Thán thư
- **Liều lượng:** 1,2 kg/ha
- **Cách pha:** 60 g/bình 20 – 25 lít nước
- **Lượng nước phun:** 400 – 500 lít/ha
- **Thời gian cách ly:** 5 ngày
### **Cây trồng: Dưa hấu**
- **Bệnh hại:** Sương mai
- **Liều lượng:** 1,5 kg/ha
- **Cách pha:** 75 g/bình 20 – 25 lít nước
- **Lượng nước phun:** 400 – 500 lít/ha
- **Thời gian cách ly:** 7 ngày
### **Cây trồng: Xoài**
- **Bệnh hại:** Thán thư
- **Liều lượng:** 0,25% (250 g/100 lít nước)
- **Lượng nước phun:** 600 – 800 lít/ha
- **Thời gian cách ly:** 7 ngày
### **Cây trồng: Cam**
- **Bệnh hại:** Sẹo
- **Cách dùng:** Phun khi tỷ lệ bệnh 3 – 5%
- **Lượng nước phun:** 600 – 800 lít/ha
- **Thời gian cách ly:** 7 ngày
---
### **Lưu ý**
- Thuốc tiếp xúc, cần phun đều bề mặt lá
- Phun sáng sớm hoặc chiều mát
---
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát
- Mang đầy đủ đồ bảo hộ khi sử dụng
- Tránh xa trẻ em, thực phẩm và nguồn nước', N'Chlorothalonil 75% w/w; Chất mang, phụ gia 25% w/w', CAST(210000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Ớt, Dưa hấu', 2, 7, CAST(1.20 AS Decimal(18, 2)), N'Thuốc tiếp xúc mạnh. Phun sáng sớm hoặc chiều mát.', CAST(N'2026-03-07T07:44:10.6388078' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (75, N'sp0075', N'CHUBECA 1.8SL', N'Đặc trị lem lép hạt trên lúa; phòng trị đạo ôn, khô vằn, cháy bìa lá. Hiệu quả trên nhiều cây trồng khác như xoài, thanh long, cam, bắp cải, ớt.', N'### **Cây trồng: Lúa**
- **Bệnh hại:** Lem lép hạt, đạo ôn, khô vằn, cháy bìa lá
- **Liều lượng:** 60 – 70 ml/bình 25 lít
- **Cách dùng:** Phun khi bệnh chớm xuất hiện
### **Cây trồng: Xoài, Nhãn**
- **Bệnh hại:** Thán thư
- **Liều lượng:** 360 ml/phuy 200 lít
- **Cách dùng:** Phun khi bệnh chớm xuất hiện
### **Cây trồng khác (Thanh long, Cam, Bắp cải, ớt, ...)**
- **Bệnh hại:** Thán thư, đốm nâu, ghẻ nhám, lở cổ rễ, héo rũ
- **Liều lượng:** 60 ml/bình 25 lít
- **Cách dùng:** Phun khi bệnh chớm xuất hiện
---
### **Lưu ý**
- Có thể phối trộn với thuốc trị bệnh khác
- **Thời gian cách ly:** Không khuyến cáo (xem bao bì)
- Phun sáng sớm hoặc chiều mát
---
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát
- Mang khẩu trang, gang tay khi sử dụng
- Tránh xa trẻ em và nguồn nước', N'Polyphenol 1,8 g/l (chiết xuất từ Oroxylum indicum và Salix babylonica); Phụ gia: vừa đủ 1 lít', CAST(130000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa, Xoài', 4, 0, CAST(2.50 AS Decimal(18, 2)), N'Chiết xuất thảo mộc. An toàn, không cần thời gian cách ly.', CAST(N'2026-03-07T07:44:10.6388081' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (76, N'sp0076', N'ALPINE 80WP', N'ALPINE có tác dụng lưu dẫn hai chiều trong cây, hiệu lực cao và lâu dài, đặc biệt với các bệnh do nấm Phytophthora. Ức chế vi khuẩn gây bệnh, bảo vệ cây trồng nhờ khả năng bám dính tốt và thấm nhanh.', N'### **Cây trồng: Tiêu**
- **Bệnh hại:** Chết nhanh
- **Liều lượng:** 50 – 75 g/bình 16 – 25 lít nước hoặc 300 g/100 lít nước
- **Lượng nước phun:** 400 lít/ha
- **Cách sử dụng:** Phun ướt đều lá và thân cây khi bệnh xuất hiện
### **Cây trồng: Hoa, Cây cảnh**
- **Bệnh hại:** Sương mai
- **Liều lượng:** 50 – 100 g/bình 16 – 25 lít nước
- **Lượng nước phun:** 400 – 500 lít/ha
- **Cách sử dụng:** Phun ướt đều lá cây
---
### **Chú ý**
- Phun thuốc khi vết bệnh mới xuất hiện
- Nếu điều kiện thuận lợi cho bệnh phát triển, phun lại sau 5 – 7 ngày
- Có thể phối hợp với thuốc trừ sâu, bệnh khác để tăng hiệu quả', N'Fosetyl - Aluminium 80% w/w; Chất mang, phụ gia 20% w/w', CAST(220000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Tiêu, Hoa', 4, 7, CAST(3.00 AS Decimal(18, 2)), N'Đặc trị nấm Phytophthora. Lưu dẫn 2 chiều.', CAST(N'2026-03-07T07:44:10.6388084' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (77, N'sp0077', N'ALPINE XANH', N'ALPINE 80 WG là thuốc trừ nấm và vi khuẩn, đặc trị các bệnh do nấm Phytophthora. Ức chế vi khuẩn gây bệnh, bảo vệ cây trồng nhờ khả năng bám dính và thấm nhanh.', N'### **Cây trồng: Dưa hấu**
- **Bệnh hại:** Thối rễ
- **Liều lượng:** 40 – 60 g/bình 16 – 25 lít nước
- **Cách sử dụng:** Phun ướt đẫm lá và thân cây
### **Cây trồng: Cam (Cây có múi)**
- **Bệnh hại:** Xì mủ
- **Liều lượng:** 0,25% (25 g/10 lít nước)
- **Cách sử dụng:** Gọt sạch vết bệnh và quét thuốc lên
### **Cây trồng: Tiêu**
- **Bệnh hại:** Chết nhanh
- **Liều lượng:** 0,2 – 0,25% (200 – 250 g/100 lít nước)
- **Cách sử dụng:** Phun ướt đều lá khi bệnh mới xuất hiện
### **Cây trồng: Lúa**
- **Bệnh hại:** Bạc lá (cháy bìa lá)
- **Liều lượng:** 1,0 kg/ha (40 – 60 g/bình 16 – 25 lít nước)
- **Cách sử dụng:** Phun ướt đều lá khi bệnh mới xuất hiện
### **Cây trồng: Nho**
- **Bệnh hại:** Mốc sương
- **Liều lượng:** 0,2 – 0,25% (200 – 250 g/100 lít nước)
- **Lượng nước phun:** 400 lít/ha
- **Cách sử dụng:** Phun ướt đều lá khi bệnh mới xuất hiện
### **Cây trồng: Cao su**
- **Bệnh hại:** Thối thân xì mủ
- **Liều lượng:** 0,2% (20 g/10 lít nước)
- **Cách sử dụng:** Gọt sạch vết bệnh rồi quét thuốc lên
### **Cây trồng: Phong lan**
- **Bệnh hại:** Thối đen
- **Liều lượng:** 40 – 60 g/bình 16 – 25 lít nước
- **Cách sử dụng:** Phun ướt đều cây khi bệnh mới xuất hiện
---
### **Lưu ý**
- Phun thuốc khi bệnh mới xuất hiện, có thể phun lại sau 5 – 7 ngày
- Với bệnh xì mủ, kết hợp quét thân và phun tán lá
- Có thể phối hợp với thuốc trừ sâu, bệnh khác
- Phun sáng sớm hoặc chiều mát
---
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát
- Mang đầy đủ đồ bảo hộ khi sử dụng
- Tránh xa trẻ em và nguồn nước', N'Fosetyl - Aluminium 80% w/w; Chất mang, phụ gia 20% w/w', CAST(220000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Dưa hấu, Cam', 4, 7, CAST(2.50 AS Decimal(18, 2)), N'Có thể kết hợp quét thân và phun lá. An toàn cho cây.', CAST(N'2026-03-07T07:44:10.6388088' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (78, N'sp0078', N'SULOX 80WP', N'Đặc trị bệnh phấn trắng trên xoài, cao su; đốm lá trên đậu phộng; nhện gié trên lúa; nhện lông nhung trên vải, nhãn. Phòng trừ hiệu quả các loại nhện hại và bổ sung lưu huỳnh (S) giúp cây phát triển khỏe mạnh.', N'### **Cây trồng: Lúa**
- **Đối tượng phòng trừ:** Nhện gié
- **Liều lượng:** **1,5 kg/ha**
- Pha **60 – 90 g/bình 16 – 25 lít nước**
- **Lượng nước phun:** **400 lít/ha**
- **Cách sử dụng:** Phun ướt đều tán lá
---
### **Cây trồng: Cao su**
- **Đối tượng phòng trừ:** Bệnh phấn trắng
- **Liều lượng:** **0,25 – 0,33%** (Pha **250 – 330 g/100 lít nước**)
- **Cách sử dụng:** Phun ướt đều tán lá
---
### **Cây trồng: Xoài**
- **Đối tượng phòng trừ:** Bệnh phấn trắng
- **Liều lượng:** **1,5 – 2,0 kg/ha**
- Pha **60 – 80 g/bình 16 lít nước**
- **Lượng nước phun:** **400 lít/ha**
- **Cách sử dụng:** Phun ướt đều tán lá
---
### **Cây trồng: Lạc (Đậu phộng)**
- **Đối tượng phòng trừ:** Bệnh đốm lá
- **Liều lượng:** **1,5 – 2,0 kg/ha**
- Pha **60 – 80 g/bình 16 lít nước**
- **Lượng nước phun:** **400 lít/ha**
- **Cách sử dụng:** Phun ướt đều tán lá
---
### **Cây trồng: Vải**
- **Đối tượng phòng trừ:** Nhện lông nhung
- **Liều lượng:** **0,375 – 0,5%** (Pha **375 – 500 g/100 lít nước**)
- **Cách sử dụng:** Phun ướt đều tán lá
---
### **Cây trồng: Nhãn**
- **Đối tượng phòng trừ:** Nhện lông nhung
- **Liều lượng:** **0,3 – 0,5%** (Pha **300 – 500 g/100 lít nước**)
- **Cách sử dụng:** Phun ướt đều tán lá
---
### **Lưu ý**
- Phun khi bệnh mới xuất hiện, nếu bệnh nặng phun lại sau **7 – 10 ngày**
- Không pha chung với thuốc có tính kiềm cao, dầu khoáng và propargite
- Tránh phun khi cây đang trổ hoa hoặc trời nắng nóng
- Không độc cho cá và ong
- **Thời gian cách ly:** Không xác định
---
### **An toàn & bảo quản**
- Bảo quản nơi khô ráo, thoáng mát
- Mang đầy đủ đồ bảo hộ khi sử dụng
- Không ăn uống, hút thuốc khi pha và phun
- Tránh xa tầm tay trẻ em', N'Sulfur 80% w/w; Chất mang, phụ gia 20% w/w', CAST(210000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa, Cao su, Xoài', 4, 7, CAST(1.50 AS Decimal(18, 2)), N'Không phun khi trời nắng nóng. Không pha với dầu khoáng.', CAST(N'2026-03-07T07:44:10.6388091' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (79, N'sp0079', N'SAIZOLE 5SC', N'Thuốc trừ nấm có khả năng nội hấp mạnh, phòng trừ hiệu quả nhiều loại nấm bệnh trên cây trồng. Chuyên trị các bệnh do nấm thuộc lớp Ascomycetes và Basidiomycetes như khô vằn, lem lép hạt, phấn trắng, nấm hồng, gỉ sắt, thán thư, lở cổ rễ, ghẻ sẹo.', N'### **Cây trồng: Lúa**
- **Bệnh hại:** Lem lép hạt
- **Liều lượng:** **0,3 – 0,5 kg/ha**
- Pha **20 – 30 g/bình 16 – 25 lít nước**
- **Lượng nước phun:** **320 – 500 lít/ha**
- **Thời điểm phun:** Trước khi lúa trổ **5 – 7 ngày** và khi lúa trổ đều', N'Hexaconazole 5% w/v; Chất mang, phụ gia: đủ 1 lít', CAST(310000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 3, 7, CAST(0.50 AS Decimal(18, 2)), N'Nội hấp mạnh. Trị lem lép hạt, khô vằn.', CAST(N'2026-03-07T07:44:10.6388095' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (80, N'sp0080', N'SAIPAN 2SL', N'Thuốc trừ nấm và vi khuẩn gây bệnh trên cây trồng, khả năng nội hấp nhanh, bảo vệ cây lâu dài. Phòng trừ nhiều bệnh hại do nấm và vi khuẩn.', N'### **Cây trồng: Lúa**
- **Bệnh hại:** Bạc lá (vi khuẩn), đạo ôn (lá và cổ bông)
- **Liều lượng:** **1,0 – 1,5 lít/ha**
- Pha **50 – 75 ml/bình 16 – 25 lít nước**
- **Lượng nước phun:** **400 – 600 lít/ha**
- **Cách sử dụng:** Phun khi bệnh mới phát sinh
---
### **Cây trồng: Bắp cải**
- **Bệnh hại:** Thối nhũn (vi khuẩn)
- **Liều lượng:** **1,5 lít/ha**
- **Lượng nước phun:** **400 – 600 lít/ha**
---
### **Cây trồng: Cam**
- **Bệnh hại:** Loét (vi khuẩn)
- **Liều lượng:** **0,25 – 0,3%** (Pha **250 – 300 ml/100 lít nước**)
---
### **Lưu ý**
- Phun khi bệnh mới phát sinh
- Phun lặp lại **2 – 3 lần**, cách nhau **7 – 10 ngày**
- **Thời gian cách ly:** 7 ngày', N'Kasugamycin 2% w/v; Dung môi, phụ gia: đủ 1 lít', CAST(220000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa, Bắp cải', 3, 7, CAST(1.50 AS Decimal(18, 2)), N'Trị nấm và vi khuẩn. Phun khi bệnh mới phát sinh.', CAST(N'2026-03-07T07:44:10.6388098' AS DateTime2), NULL, 1, 2, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (81, N'sp0081', N'YOSKY', N'Thuốc trừ cỏ không chọn lọc, diệt hiệu quả hầu hết các loại cỏ từ giai đoạn non đến trưởng thành, hiệu lực nhanh chỉ sau 2 – 3 ngày.', N'### **Cây trồng: Cà phê**
- **Đối tượng:** Cỏ các loại
- **Liều lượng:** **3 lít/ha**
- Pha **125 ml/bình 25 lít nước**
- **Lượng nước phun:** **600 lít/ha**
- **Thời điểm phun:** Khi cỏ đang phát triển mạnh
---
### **Lưu ý**
- Phun ướt đều thân và lá cỏ
- Tránh để thuốc dính vào cây trồng
- Phun lúc sáng sớm hoặc chiều mát
---
### **An toàn**
- Mang đầy đủ đồ bảo hộ
- Tránh xa tầm tay trẻ em', N'Glufosinate-P 10% w/w; Dung môi, phụ gia: 90% w/w', CAST(310000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Cà phê', 3, 0, CAST(3.00 AS Decimal(18, 2)), N'Trừ cỏ không chọn lọc. Tránh để thuốc bay vào cây trồng.', CAST(N'2026-03-07T07:44:10.6388101' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (82, N'sp0082', N'XINRON', N'Thuốc được dùng để diệt cỏ cho đất trồng mía. XINRON 800 WG diệt cỏ hiệu quả ở các giai đoạn: trước khi cỏ mọc, khi cỏ đang nảy mầm, hoặc khi cỏ mới mọc còn nhỏ (có 3 - 5 lá). Đặc trị các loại cỏ hòa thảo và cỏ lá rộng trên ruộng mía.', N'### **Cây trồng: Mía**
- **Đối tượng (loại cỏ):** Cỏ hòa thảo và cỏ lá rộng
- **Liều lượng:** **1,5 kg/ha**
- Pha **50 g/bình 25 lít nước**
- **Lượng nước phun:** **700 – 900 lít/ha**
- **Thời điểm phun:** Phun khi mía ở giai đoạn 4 – 6 lá, và cỏ ở giai đoạn 3 – 5 lá, đang phát triển mạnh
---
### **Lưu ý**
- **Thời gian cách ly:** Không xác định (tham khảo trên bao bì sản phẩm)
- Khuấy đều sau khi pha thuốc vào nước
- Phun ướt đều thân và lá cỏ
- Phun khi trời im gió hoặc gió nhẹ
- Không để thuốc bay tạt vào cây trồng khác (đặc biệt là cây mẫn cảm với Diuron)
---
### **An toàn & bảo quản**
- Mang đầy đủ đồ bảo hộ lao động khi pha và phun thuốc
- Không ăn uống, hút thuốc khi đang pha và phun thuốc
- Không súc rửa dụng cụ phun xịt nơi ao hồ nuôi cá, nguồn nước sinh hoạt
- Để thuốc nơi an toàn, tránh xa tầm tay trẻ em
- Bảo quản nơi khô ráo, thoáng mát, tránh ánh sáng trực tiếp
---
### **Sơ cứu khi ngộ độc**
- Nếu thuốc dính vào mắt: Rửa bằng nước sạch liên tục **15 – 20 phút**
- Nếu thuốc dính vào da: Rửa bằng xà phòng và nhiều nước sạch
- Nếu nuốt phải: Không gây nôn, đưa ngay đến cơ sở y tế và mang theo nhãn thuốc', N'Hoạt chất: Diuron 800 g/kg; Chất mang, phụ gia: 200 g/kg', CAST(250000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Mía', 3, 0, CAST(1.50 AS Decimal(18, 2)), N'Tránh bay thuốc sang cây mẫn cảm (đậu nành). Phun khi đất ẩm.', CAST(N'2026-03-07T07:44:10.6388105' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (83, N'sp0083', N'VITOP', N'Diệt hầu hết các loại cỏ dại và lúa cỏ (lúa rài) trên ruộng lúa sạ.', N'### **Cây trồng: Lúa (sạ)**
- **Đối tượng (loại cỏ):** Hầu hết các loại cỏ và lúa cỏ (lúa rài)
- **Liều lượng & cách pha:**
  - **50 ml/bình 25 lít nước**
  - Hoặc **30 ml/bình 16 lít nước**, phun **2 bình/công 1000 m²**
- **Lượng nước phun:** **320 – 400 lít/ha**
- **Thời điểm phun:** **0 – 3 ngày sau sạ (NSS)**, phun càng sớm hiệu quả càng cao
**Điều kiện ruộng khi phun:**
- Ruộng đủ ẩm, mặt ruộng bằng phẳng
- Lúa giống đã ra đủ mầm và rễ
- Không phun khi ruộng khô nứt hoặc sạ trên 5 ngày
---
### **Lưu ý**
- **Thời gian cách ly:** Không xác định
- Phun ướt đều mặt ruộng
---
### **An toàn & bảo quản**
- Mang đầy đủ đồ bảo hộ lao động khi pha và phun thuốc
- Không ăn uống, hút thuốc khi đang pha và phun thuốc
- Không súc rửa dụng cụ phun xịt nơi ao hồ nuôi cá, nguồn nước sinh hoạt
- Để thuốc nơi an toàn, tránh xa tầm tay trẻ em
- Bảo quản nơi khô ráo, thoáng mát, tránh ánh sáng và nhiệt độ cao
---
### **Sơ cứu khi ngộ độc**
- Nếu thuốc dính vào mắt: Rửa ngay bằng nước sạch **15 – 20 phút**
- Nếu thuốc dính vào da: Rửa bằng xà phòng và nhiều nước sạch
- Nếu nuốt phải: Không gây nôn, đưa đến cơ sở y tế gần nhất và mang theo nhãn thuốc', N'Pretilachlor 500 g/l; Chất an toàn Fenclorim 150 g/l; Phụ gia: vừa đủ 1 lít', CAST(310000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa (sạ)', 3, 0, CAST(1.00 AS Decimal(18, 2)), N'Có chất an toàn cho lúa. Phun 0-3 ngày sau sạ.', CAST(N'2026-03-07T07:44:10.6388108' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (84, N'sp0084', N'VENUS', N'Diệt trừ hiệu quả nhiều loại cỏ dại phổ biến trong ruộng lúa, đặc trị lúa cỏ (lúa rài, lúa lộn), dùng cho lúa gieo sạ và lúa cấy.', N'### **Cây trồng: Lúa gieo thẳng (sạ), Lúa cấy**
- **Đối tượng:** Cỏ đuôi phụng, lồng vực, chác, lác, mác bao, xà bông, lúa cỏ
- **Liều lượng:** **1,0 lít/ha**
- Pha **50 ml/bình 16 lít** hoặc **75 ml/bình 25 lít**
- **Lượng nước phun:** **320 – 400 lít/ha**
- **Thời điểm phun:** 0 – 4 ngày sau sạ, 1 – 4 ngày sau cấy
---
### **Lưu ý & An toàn**
- Phun ướt đều mặt ruộng
- Mang đầy đủ đồ bảo hộ
- Tránh xa tầm tay trẻ em', N'Pretilachlor 300 g/l; Fenclorim 100 g/l; Dung môi, phụ gia: vừa đủ 1 lít', CAST(210000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lúa', 3, 0, CAST(1.00 AS Decimal(18, 2)), N'Diệt cỏ lồng vực, đuôi phụng. Mang đầy đủ bảo hộ.', CAST(N'2026-03-07T07:44:10.6388112' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (85, N'sp0085', N'TAR 10WP', N'Thuốc trừ cỏ chọn lọc, đặc trị cỏ hòa thảo trên lạc và vừng trong giai đoạn đầu sinh trưởng.', N'### **Cây trồng: Lạc (Đậu phộng)**
- **Đối tượng:** Cỏ hòa thảo
- **Liều lượng:** **0,8 – 1,0 lít/ha**
- Pha **60 ml/bình 25 lít** hoặc **40 ml/bình 16 lít**
- **Thời điểm phun:** Sau gieo 9 – 14 ngày
---
### **Cây trồng: Vừng (Mè)**
- **Đối tượng:** Cỏ hòa thảo
- **Liều lượng:** **1,0 lít/ha**
- **Thời điểm phun:** Sau gieo 7 – 8 ngày
---
### **An toàn**
- Phun khi đất đủ ẩm
- Mang đồ bảo hộ đầy đủ', N'Hoạt chất 10% w/w; Phụ gia 90% w/w', CAST(130000.00 AS Decimal(18, 2)), 50, 365, NULL, N'Lạc, Vừng', 3, 0, CAST(1.00 AS Decimal(18, 2)), N'Phun sau gieo 9-14 ngày. Đất phải đủ ẩm.', CAST(N'2026-03-07T07:44:10.6388115' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (86, N'sp0086', N'SIMATOP', N'Thuốc diệt trừ nhiều loại cỏ lá hẹp và lá rộng trên vườn cây Cà phê. Cỏ cháy khô nhanh sau 2 – 3 ngày phun thuốc và chết sau đó.', N'### **Cây trồng: Lạc (Đậu phộng)**
- **Đối tượng (loại cỏ):** Cỏ hòa thảo các loại
- **Liều lượng & cách pha:**
  - 0,8 – 1,0 lít/Ha
  - Pha 60 ml/bình 25 lít nước hoặc 40 ml/bình 16 lít nước
- **Lượng nước phun:** 400 lít/Ha (tương đương phun 2,5 bình 16 lít nước cho 1000 m²)
- **Thời điểm phun:** Sau khi gieo hạt 9 – 14 ngày (khi cỏ có 3 – 6 lá)
---
### **Cây trồng: Vừng (Mè)**
- **Đối tượng (loại cỏ):** Cỏ hòa thảo (hòa bản)
- **Liều lượng & cách pha:**
  - 1,0 lít/Ha
  - Pha 60 ml/bình 25 lít nước hoặc 40 ml/bình 16 lít nước
- **Lượng nước phun:** 400 lít/Ha (tương đương phun 2,5 bình 16 lít nước cho 1000 m²)
- **Thời điểm phun:** Sau khi gieo hạt 7 – 8 ngày (khi cỏ có 3 – 6 lá)
---
### **Lưu ý**
- Thời gian cách ly: Thông tin cụ thể không được cung cấp.
- Thời điểm phun hiệu quả nhất: Khi cỏ có 3 – 6 lá.
- Điều kiện đất: Hiệu quả cao hơn khi đất đủ ẩm.
- Thuốc không có tác dụng đối với nhóm cỏ lá rộng và cỏ lác (cỏ cói).
- Phun ướt đều lá cỏ.
- Thông tin về khả năng pha trộn chưa có trong tài liệu, cần bổ sung nếu cần.', N'Glufosinate Ammonium 200 g/l; Dung môi, phụ gia: cho đủ 1 lít', CAST(220000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lạc, Vừng', 3, 0, CAST(1.00 AS Decimal(18, 2)), N'Trừ cỏ lá hẹp và lá rộng. Tránh phun vào cây trồng.', CAST(N'2026-03-07T07:44:10.6388119' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (87, N'sp0087', N'SAIONE 15EC', N'Thuốc có hiệu quả cao trong việc diệt trừ các loại cỏ hòa thảo (hòa bản) như: Cỏ chỉ, cỏ ống, lồng vực (cỏ gạo), mần trầu, cỏ mật, cỏ bông tua, cỏ lá tre, cỏ túc, cỏ sâu róm và các loại cỏ hòa thảo khác. Sử dụng chuyên biệt cho các cây trồng lá rộng.', N'### **Cây trồng: Lạc (Đậu phộng)**
- **Đối tượng (loại cỏ):** Cỏ hòa thảo các loại
- **Liều lượng & cách pha:**
  - 0,8 – 1,0 lít/Ha
  - Pha 60 ml/bình 25 lít nước hoặc 40 ml/bình 16 lít nước
- **Lượng nước phun:** 400 lít/Ha (tương đương phun 2,5 bình 16 lít nước cho 1000 m²)
- **Thời điểm phun:** Sau khi gieo hạt 9 – 14 ngày (khi cỏ có 3 – 6 lá)
---
### **Cây trồng: Vừng (Mè)**
- **Đối tượng (loại cỏ):** Cỏ hòa thảo (hòa bản)
- **Liều lượng & cách pha:**
  - 1,0 lít/Ha
  - Pha 60 ml/bình 25 lít nước hoặc 40 ml/bình 16 lít nước
- **Lượng nước phun:** 400 lít/Ha (tương đương phun 2,5 bình 16 lít nước cho 1000 m²)
- **Thời điểm phun:** Sau khi gieo hạt 7 – 8 ngày (khi cỏ có 3 – 6 lá)
---
### **Lưu ý**
- Thời gian cách ly: Thông tin cụ thể không được cung cấp.
- Thời điểm phun hiệu quả nhất: Khi cỏ có 3 – 6 lá.
- Điều kiện đất: Hiệu quả cao hơn khi đất đủ ẩm.
- Thuốc không có tác dụng đối với nhóm cỏ lá rộng và cỏ lác (cỏ cói).
- Phun ướt đều lá cỏ.
- Thông tin về khả năng pha trộn chưa có trong tài liệu, cần bổ sung nếu cần.
---
### **Hướng dẫn an toàn và bảo quản**
- Bảo quản: Giữ trong bao bì gốc, đậy nắp kín, để nơi khô ráo, thoáng mát, tránh ánh sáng trực tiếp và nhiệt độ cao.
- An toàn: Mang đầy đủ đồ bảo hộ lao động, không ăn uống, hút thuốc khi pha và phun, tránh xa trẻ em và nguồn thực phẩm.
- Bỏ bao, gói, chai sau khi sử dụng hoặc tiêu huỷ đúng quy định.
---
### **Sơ cứu khi ngộ độc**
- Nếu thuốc dính vào mắt: Rửa mắt ngay bằng nước sạch liên tục từ 15 – 20 phút.
- Nếu thuốc dính vào da: Rửa ngay bằng xà phòng và nhiều nước sạch.
- Nếu nuốt phải thuốc: Không gây nôn, đưa nạn nhân đến cơ sở y tế gần nhất và mang theo nhãn thuốc.', N'Fluazifop-P-Butyl 150 g/l; Dung môi, phụ gia: đủ 1 lít', CAST(200000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lạc, Vừng', 3, 0, CAST(1.00 AS Decimal(18, 2)), N'Chuyên trị cỏ hòa thảo. Không tác dụng với cỏ lá rộng.', CAST(N'2026-03-07T07:44:10.6388122' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (88, N'sp0088', N'SAICOBA', N'Mang lại hiệu quả cao trong việc trị các loại cỏ lá hẹp và cỏ lá rộng mọc từ hạt. Sử dụng cho các cây trồng như Lạc (Đậu phộng), Khoai mì (Sắn), và Ngô (Bắp).', N'### **Cây trồng: Lạc (Đậu phộng)**
- **Đối tượng (loại cỏ):** Cỏ lá hẹp và lá rộng mọc từ hạt
- **Liều lượng & cách pha:**
  - 1.0 L/Ha
  - Pha 60 ml/bình 25 lít nước
- **Lượng nước phun:** 320 - 400 lít/Ha
- **Thời điểm phun:** Phun sau khi gieo hạt 2 ngày
---
### **Cây trồng: Khoai mì (Sắn)**
- **Đối tượng (loại cỏ):** Cỏ lá hẹp và lá rộng mọc từ hạt
- **Liều lượng & cách pha:**
  - 0.8 – 1.0 L/Ha
  - Pha 55 – 60 ml/bình 25 lít nước
- **Lượng nước phun:** 320 – 400 lít/Ha
- **Thời điểm phun:** Phun sau khi gieo hạt 2 ngày (hoặc sau khi đặt hom 0 – 3 ngày)
---
### **Cây trồng: Ngô (Bắp)**
- **Đối tượng (loại cỏ):** Cỏ lá hẹp và lá rộng mọc từ hạt
- **Liều lượng & cách pha:**
  - 1.0 – 1.5 L/Ha
  - Pha 60 – 90 ml/bình 25 lít nước
- **Lượng nước phun:** 320 – 400 lít/Ha
- **Thời điểm phun:** Phun sau khi gieo 1 – 3 ngày
---
### **Lưu ý**
- Thời gian cách ly: Không xác định
- Phun thuốc đều mặt ruộng sau khi làm đất lần cuối và sau khi gieo hạt (hoặc đặt hom) từ 0 – 3 ngày
- Phun thuốc lúc đất đủ ẩm. Nếu đất khô, cần tưới ẩm trước khi phun
- Tránh để ruộng đã xử lý thuốc bị đọng nước sau cơn mưa
- Thông tin về khả năng pha trộn chưa có trong dữ liệu
---
### **Hướng dẫn an toàn và bảo quản**
- Bảo quản: Giữ trong bao bì gốc, đậy nắp kín, để nơi khô ráo, thoáng mát, tránh ánh sáng trực tiếp và nhiệt độ cao
- An toàn: Mang đầy đủ đồ bảo hộ lao động, không ăn uống, hút thuốc khi pha và phun thuốc, tránh xa trẻ em và nguồn thực phẩm
- Bỏ bao, gói, chai sau khi sử dụng hoặc tiêu huỷ đúng quy định
---
### **Sơ cứu khi ngộ độc**
- Nếu thuốc dính vào mắt: Dùng nước sạch để rửa mắt ngay và nên rửa liên tục từ 15 đến 20 phút
- Nếu thuốc dính vào da: Rửa ngay bằng xà phòng và nhiều nước sạch
- Nếu nuốt phải thuốc: Không gây nôn. Đưa ngay nạn nhân đến cơ sở y tế gần nhất và mang theo nhãn thuốc đã gây ngộ độc để bác sĩ có hướng điều trị kịp thời', N'Acetochlor 800 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lạc, Khoai mì, Ngô', 3, 0, CAST(1.00 AS Decimal(18, 2)), N'Phun sau khi gieo 0-3 ngày. Đất cần đủ ẩm.', CAST(N'2026-03-07T07:44:10.6388126' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (89, N'sp0089', N'WINDUP', N'Thuốc diệt được đăng ký để phòng trừ nhóm cỏ dại trên ruộng lúa. Đặc biệt hiệu quả với nhóm cỏ chác lác và các loại cỏ lá rộng. Sử dụng cho các cây trồng: Khoai mì (sắn), Mía, Ngô (bắp), Đậu phộng (lạc).', N'### **Cây trồng: Lúa (sạ)**
- **Đối tượng (loại cỏ):** Nhóm cỏ chác lác, cỏ lá rộng
- **Liều lượng & cách pha:**
  - Pha 100 – 120 ml thuốc/bình 25 lít nước
- **Lượng nước phun:** 320 – 400 lít/ha
- **Thời điểm phun:** Phun thuốc sau khi sạ 10 – 12 ngày
---
### **Lưu ý**
- Thời gian cách ly: Không xác định
- Phun cho nước thuốc tiếp xúc trực tiếp với cỏ để đạt hiệu quả cao nhất
- Thông tin về khả năng pha trộn chưa có trong dữ liệu nếu cần bổ sung
---
### **Hướng dẫn an toàn và bảo quản**
- Bảo quản: Giữ trong bao bì gốc, đậy nắp kín, để nơi khô ráo, thoáng mát, tránh ánh sáng trực tiếp và nhiệt độ cao
- An toàn: Mang đầy đủ đồ bảo hộ lao động khi pha và phun thuốc, không ăn uống, hút thuốc, tránh xa trẻ em và nguồn thực phẩm
- Bỏ bao, gói, chai sau khi sử dụng hoặc tiêu huỷ đúng quy định
---
### **Sơ cứu khi ngộ độc**
- Nếu thuốc dính vào mắt: Rửa mắt ngay bằng nước sạch liên tục từ 15 đến 20 phút
- Nếu thuốc dính vào da: Rửa ngay bằng xà phòng và nhiều nước sạch
- Nếu nuốt phải thuốc: Không gây nôn. Đưa nạn nhân đến cơ sở y tế gần nhất và mang theo nhãn thuốc', N'Acetochlor 500 g/l; Bentazone 480 g/l; Dung môi, chất phụ gia: cho đủ 1 lít.', CAST(130000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 3, 0, CAST(1.20 AS Decimal(18, 2)), N'Đặc trị cỏ chác lác. Phun sau sạ 10-12 ngày.', CAST(N'2026-03-07T07:44:10.6388129' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (90, N'sp0090', N'PYANCHOR GOLD 8.5EC', N'Diệt trừ hữu hiệu các loại cỏ thuộc nhóm hòa bản (cỏ lồng vực, đuôi phụng), chác lác và một số cỏ lá rộng mọc phổ biến trong ruộng lúa như: đuôi phụng (lông công), lồng vực (cỏ gạo), cỏ nước mặn, chác lác, rau muống, mác,... Thuốc diệt cỏ hiệu quả ở giai đoạn cỏ đã mọc ra lá (cỏ có từ 2 - 5 lá), tương ứng với lúa sạ được 7 - 15 ngày. Cỏ ngừng sinh trưởng ngay sau khi phun và chết hoàn toàn sau 7-10 ngày.', N'### **Cây trồng: Lúa (sạ)**
- **Đối tượng (loại cỏ):** Các loại cỏ thuộc nhóm hòa bản, chác lác và lá rộng như: đuôi phụng (lông công), lồng vực (cỏ gạo), cỏ nước mặn, chác lác, rau muống, mác,...
- **Liều lượng & cách pha:**
  - 0.8 – 1.0 lít/Ha
  - Pha 40 – 50 ml/bình 16 lít nước (phun 2 bình cho 1000 m²)
  - Hoặc pha 65 – 75 ml/bình 25 lít nước
  - Trường hợp phun muộn khi cỏ đã lớn, nên dùng liều cao hơn trong khoảng khuyến cáo
- **Lượng nước phun:** 320 lít/Ha
- **Thời điểm phun:** Phun khi lúa sạ được 7 – 15 ngày (tốt nhất 8 – 12 ngày), lúc cỏ có từ 2 – 5 lá
---
### **Lưu ý**
- Thời gian cách ly: Thông tin không được cung cấp
- Quản lý nước:
  - Tháo cạn nước ruộng trước khi phun
  - Sau khi phun 1 – 3 ngày, dẫn nước vào ruộng cao khoảng 2/3 chiều cao cây lúa và giữ nước ít nhất 4 – 5 ngày
- Phun lại: Có thể dùng liều 1.2 lít/Ha để phun lau lại cỏ còn sót
- Độ bền với mưa: Nếu mưa sau 6 giờ, không cần phun lại
- Phun ướt đều lá cỏ
- Khả năng pha trộn chưa có dữ liệu
---
### **Hướng dẫn an toàn và bảo quản**
- Bảo quản: Giữ trong bao bì gốc, đậy nắp kín, nơi khô ráo, thoáng mát, tránh ánh sáng trực tiếp và nhiệt độ cao
- An toàn: Mang đồ bảo hộ, không ăn uống, hút thuốc, tránh xa trẻ em và thực phẩm
- Bỏ bao, gói, chai sau khi sử dụng
---
### **Sơ cứu khi ngộ độc**
- Dính vào mắt: Rửa nước sạch 15 – 20 phút
- Dính vào da: Rửa bằng xà phòng và nước sạch
- Nuốt phải: Không gây nôn, đưa ngay đến cơ sở y tế mang nhãn thuốc', N'Pyribenzoxim 2.5% w/w; Cyhalofop-butyl 6.0% w/w; Dung môi, phụ gia: 91.5% w/w (cho đủ 100%).', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 3, 0, CAST(1.00 AS Decimal(18, 2)), N'Diệt cỏ lồng vực, đuôi phụng. Giữ nước sau phun 1-3 ngày.', CAST(N'2026-03-07T07:44:10.6388158' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (91, N'sp0091', N'MIZIN 30WP', N'Thuốc diệt hiệu quả nhiều loại cỏ hằng năm mọc từ hạt như: Cỏ lá hẹp: Lồng vực cạn, mần trầu, cỏ bông tua, cỏ chân gà. Cỏ lá rộng: Mần ri, dền gai, rau sam, cỏ mực, dừa cạn… Hiệu quả tốt nhất khi trừ cỏ ở giai đoạn tiền nảy mầm và hậu nảy mầm sớm. An toàn cho cây bắp (ngô) khi sử dụng đúng khuyến cáo.', N'### **Cây trồng: Bắp (Ngô)**
- **Đối tượng (loại cỏ):** Cỏ lá rộng và cỏ lá hẹp (Lồng vực cạn, mần trầu, mần ri, cỏ bông tua, cỏ chân gà, dền gai, rau sam, cỏ mực, dừa cạn…)
- **Liều lượng & cách pha:**
  - 1,5 – 3,0 lít/ha
  - Pha 65 – 100 ml/bình 16 lít hoặc 100 – 150 ml/bình 25 lít
- **Lượng nước phun:** 400 – 500 lít/ha
- **Thời điểm phun:** Sau khi gieo hạt, lấp đất 0 – 3 ngày, phun đều lên mặt đất khi cỏ chưa mọc hoặc mới mọc nhỏ (1 – 2 lá)
---
### **Lưu ý**
- Thời gian cách ly: Thông tin không được cung cấp
- Điều kiện đất: Hiệu quả cao khi phun trên đất ẩm; nếu đất khô, tưới nước trước
- Tránh thuốc bay sang cây mẫn cảm với Atrazine như đậu nành, đậu xanh, đay
- Khả năng pha trộn chưa có dữ liệu
---
### **Hướng dẫn an toàn và bảo quản**
- Bảo quản: Giữ trong bao bì gốc, đậy nắp kín, nơi khô ráo, thoáng mát, tránh ánh sáng trực tiếp và nhiệt độ cao
- An toàn: Mang đồ bảo hộ, không ăn uống, hút thuốc, tránh xa trẻ em và thực phẩm
- Bỏ bao, gói, chai sau khi sử dụng
---
### **Sơ cứu khi ngộ độc**
- Dính vào mắt: Rửa nước sạch 15 – 20 phút
- Dính vào da: Rửa bằng xà phòng và nước sạch
- Nuốt phải: Không gây nôn, đưa đến cơ sở y tế mang nhãn thuốc', N'Atrazine 500 g/l; Chất phụ gia, dung môi: cho đủ 1 lít.', CAST(250000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Ngô (Bắp)', 3, 0, CAST(2.00 AS Decimal(18, 2)), N'Thuốc trừ cỏ chọn lọc. Không để bay sang đậu nành.', CAST(N'2026-03-07T07:44:10.6388162' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (92, N'sp0092', N'MIZIN PLUS', N'Diệt hiệu quả các loại cỏ lá hẹp và cỏ lá rộng hằng năm. Thuốc có hiệu quả tốt nhất khi sử dụng ở giai đoạn tiền nảy mầm (trước khi cỏ mọc) và hậu nảy mầm sớm (khi cỏ còn nhỏ, có 1-2 lá). Sản phẩm được dùng cho cây ngô (bắp) và mía.', N'### **Cây trồng: Ngô (Bắp)**
- **Đối tượng (loại cỏ):** Cỏ lá hẹp và lá rộng hằng năm
- **Liều lượng & cách pha:**
  - 1 – 2 kg/ha
  - Pha 40 – 70 g/bình 16 lít nước
- **Lượng nước phun:** 400 – 500 lít/ha
- **Thời điểm phun:** Phun ngay sau khi tra hạt, khi cỏ chưa mọc hoặc mới mọc nhỏ (1 – 2 lá)
### **Cây trồng: Mía**
- **Đối tượng (loại cỏ):** Cỏ lá hẹp và lá rộng hằng năm
- **Liều lượng & cách pha:**
  - 3 – 5 kg/ha
  - Pha 120 – 160 g/bình 16 lít nước
- **Lượng nước phun:** 400 – 500 lít/ha
- **Thời điểm phun:** Phun ngay sau khi đặt hom, khi cỏ chưa mọc hoặc mới mọc nhỏ (1 – 2 lá), hoặc sau khi làm đất dọn gốc mía sau thu hoạch
### **Lưu ý**
- Thời gian cách ly: Không có thông tin cụ thể
- Điều kiện đất: Đất càng ẩm, hiệu quả càng cao; nếu đất khô cần tưới ẩm
- Phòng tránh: Không để thuốc bay sang cây mẫn cảm với Atrazine như đậu nành, đay
- Dụng cụ: Phun đều mặt đất, rửa sạch dụng cụ sau khi sử dụng
- Khả năng pha trộn: Chưa có dữ liệu
### **Hướng dẫn an toàn và bảo quản**
- Bảo quản: Giữ trong bao bì gốc, đậy kín, nơi khô ráo, thoáng mát, tránh ánh sáng trực tiếp và nhiệt độ cao
- An toàn: Mang đồ bảo hộ, không ăn uống, tránh xa trẻ em và thực phẩm
- Bỏ bao, gói, chai sau khi sử dụng
### **Sơ cứu khi ngộ độc**
- Dính vào mắt: Rửa nước sạch 15 – 20 phút
- Dính vào da: Rửa bằng xà phòng và nước sạch
- Nuốt phải: Không gây nôn, đưa đến cơ sở y tế mang nhãn thuốc', N'Atrazine 80% w/w; Chất mang, phụ gia: 20% w/w.', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Ngô, Mía', 3, 0, CAST(1.50 AS Decimal(18, 2)), N'Phun phủ đều mặt đất. Hiệu quả cao khi đất ẩm.', CAST(N'2026-03-07T07:44:10.6388165' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (93, N'sp0093', N'ANSARON PLUS', N'ANSARON 500 SC là thuốc trừ cỏ lá hẹp và lá rộng cho đất trồng cạn. Thuốc có tác dụng nội hấp và chọn lọc. Diệt hiệu quả nhiều loại cỏ như: mần trầu, cỏ túc, cỏ ống, đuôi chồn, cỏ chân gà, dền gai, mần ri, sam, cỏ cháo, chác, mắc cỡ… Chủ yếu trừ cỏ ở giai đoạn tiền nảy mầm (trước khi cỏ mọc) hoặc khi cỏ mới mọc còn nhỏ (có từ 1 - 2 lá). Hiệu lực diệt cỏ kéo dài, giúp giảm chi phí trừ cỏ.', N'### **Cây trồng: Mía**
- **Đối tượng (loại cỏ):** Cỏ lá hẹp và lá rộng (mần trầu, cỏ túc, cỏ ống, đuôi chồn, cỏ chân gà, dền gai, mần ri, sam, cỏ cháo, chác, mắc cỡ…)
- **Liều lượng & cách pha:**
  - 2,5 – 3,0 lít/Ha
  - Pha 100 – 120 ml/bình 16 lít (phun 2,5 bình/1000 m²)
- **Lượng nước phun:** ~400 lít/Ha
- **Thời điểm phun:** Ngay sau khi đặt hom từ 0 – 3 ngày, phun đều lên mặt đất ngay sau khi đặt hom mía hoặc sau khi làm đất lần đầu cho mía gốc đã thu hoạch
### **Lưu ý**
- Thời gian cách ly: Không có thông tin cụ thể
- Nên phun trước khi cỏ mọc hoặc khi cỏ còn nhỏ (1 – 2 lá)
- Tránh phun trực tiếp vào ngọn mía đã mọc
- Đất càng ẩm càng tốt; nếu đất khô cần tưới ẩm
- Khả năng pha trộn: Chưa có dữ liệu
### **Hướng dẫn an toàn và bảo quản**
- Bảo quản: Giữ trong bao bì gốc, đậy kín, nơi khô ráo, thoáng mát, tránh ánh sáng trực tiếp và nhiệt độ cao
- An toàn: Mang đồ bảo hộ, không ăn uống, tránh xa trẻ em và thực phẩm
- Bỏ bao, gói, chai sau khi sử dụng
### **Sơ cứu khi ngộ độc**
- Dính vào mắt: Rửa nước sạch 15 – 20 phút
- Dính vào da: Rửa bằng xà phòng và nước sạch
- Nuốt phải: Không gây nôn, đưa đến cơ sở y tế mang nhãn thuốc', N'Diuron 500 g/l; Dung môi và phụ gia: cho đủ 1 lít.', CAST(200000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Mía', 3, 0, CAST(2.80 AS Decimal(18, 2)), N'Diệt cỏ lá hẹp và lá rộng. Không phun trực tiếp vào cây trồng mẫn cảm.', CAST(N'2026-03-07T07:44:10.6388169' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (94, N'sp0094', N'KABUTO', N'Thuốc trừ cỏ chuyên dùng cho ruộng lúa, phòng trừ hiệu quả các loại cỏ dại. Sử dụng trên các giống lúa được khuyến cáo.', N'### Cây trồng: Lúa
- **Lưu ý về giống lúa sử dụng:**
  - Được khuyến cáo: OM 18, OM 34, OM 380, OM 4900, OM 6976, ST 5, ST 20, ST 24, ST 25, Tài Nguyên, RVT, Lúa Nhật DS – 1, HP2, Cửu Long 555, Đài Thơm 8, Nàng Hoa 9, PC 10, VNR – 20, VD 20, Jasmine 85, Lúa Gà (ML – 202)
  - Không sử dụng trên: OM 2517, OM 5451, IR 50404, HL 5, OC 10, Huyết Rồng, Lúa Nếp, Lúa Cấy
  - Trường hợp khác: Liên hệ tổng đài miễn cước 1800 1083
- **Đối tượng (loại cỏ):** Cỏ dại các loại trên ruộng lúa
- **Liều lượng & cách pha:**
  - Phun máy/drone: 200 – 250 ml/ha, phun mịn béc, đảm bảo thuốc trải đều
  - Trộn phân rải: 200 – 250 ml thuốc + 600 ml nước, trộn đều với 100 kg phân cho 1 ha
- **Lượng nước phun:** Tùy thiết bị, đảm bảo phủ đều
- **Thời điểm phun:** Thường giai đoạn tiền nảy mầm hoặc hậu nảy mầm rất sớm, ruộng có nước ổn định
### Hướng dẫn an toàn và bảo quản
- Giữ bao bì gốc, đậy kín, nơi khô ráo, thoáng mát, tránh ánh sáng và nhiệt độ cao
- Mang đầy đủ đồ bảo hộ, không ăn uống khi pha/phun, tránh xa trẻ em
- Tiêu hủy bao bì sau sử dụng
### Sơ cứu khi ngộ độc
- Dính mắt: Rửa 15–20 phút
- Dính da: Rửa xà phòng & nước sạch
- Nuốt phải: Không gây nôn, đưa đến cơ sở y tế mang nhãn thuốc', N'QUY CÁCH Chai 100ml', CAST(230000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 3, 0, CAST(0.25 AS Decimal(18, 2)), N'Chỉ dùng trên các giống lúa được khuyến cáo (OM 18, ST 24...). Đọc kỹ hướng dẫn.', CAST(N'2026-03-07T07:44:10.6388172' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (95, N'sp0095', N'GLU-TRUST 200SL', N'Thuốc diệt trừ hiệu quả các loại cỏ dại (lá hẹp và lá rộng) trên vườn cây Cà phê.', N'### Cây trồng: Cà phê
- **Đối tượng (loại cỏ):** Cỏ lá hẹp và lá rộng
- **Liều lượng & cách pha:**
  - 3,0 lít/ha
  - Pha 150 ml/bình 25 lít nước
- **Lượng nước phun:** 500 – 600 lít/ha
- **Thời điểm phun:** Khi cỏ đang phát triển mạnh
### Lưu ý
- Phun định hướng, tránh thuốc bay vào lá/cành non cà phê
- Phun lúc sáng sớm hoặc chiều mát
- Mang đồ bảo hộ đầy đủ
### An toàn & bảo quản
- Bảo quản nơi khô ráo
- Tránh xa trẻ em', N'Glufosinate Ammonium 200 g/l; Dung môi, phụ gia: vừa đủ 1 lít.', CAST(220000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Cà phê', 3, 0, CAST(3.00 AS Decimal(18, 2)), N'Thuốc cỏ cháy. Tuyệt đối không để thuốc bay vào lá cà phê.', CAST(N'2026-03-07T07:44:10.6388175' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (96, N'sp0096', N'GAVAN PLUS', N'Thuốc diệt hiệu quả các loại cỏ nhóm hòa thảo và lá rộng hằng năm mọc từ hạt. An toàn cho cây Ngô (Bắp).', N'### Cây trồng: Ngô (Bắp)
- **Đối tượng (loại cỏ):** Cỏ hòa thảo và lá rộng (Cối xay, dền gai, ké đầu ngựa, rau muối, đuôi chồn, lồng vực, túc, cỏ lông, cỏ chỉ)
- **Liều lượng & cách pha:** 1,25 lít/ha; Pha 65 – 75 ml/bình 25 lít nước
- **Lượng nước phun:** 400 – 500 lít/ha
- **Thời điểm phun:** Phun 6 – 9 ngày sau gieo hạt, khi cỏ đang nảy mầm hoặc mới mọc (1 – 3 lá)
### Lưu ý
- Thời gian cách ly: Không xác định
- Hiệu quả cao trên đất ẩm; tưới ẩm nếu đất khô
- Phun sương mịn, phủ đều, tránh gió mạnh
### Hướng dẫn an toàn và bảo quản
- Giữ trong bao bì gốc, đậy kín, nơi khô ráo, thoáng mát
- Mang đầy đủ đồ bảo hộ; không ăn uống khi pha/phun
- Tiêu hủy bao bì sau sử dụng
### Sơ cứu khi ngộ độc
- Dính mắt: Rửa 15–20 phút
- Dính da: Rửa xà phòng & nước sạch
- Nuốt phải: Không gây nôn, đưa đến cơ sở y tế mang nhãn thuốc', N'Mesotrione 75 g/l; Nicosulfuron 30 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(270000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Ngô (Bắp)', 3, 0, CAST(1.25 AS Decimal(18, 2)), N'An toàn cho cây ngô. Phun trùm lên cây được ở giai đoạn nhỏ.', CAST(N'2026-03-07T07:44:10.6388179' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (97, N'sp0097', N'FASTOXY 32WP', N'Diệt nhiều loại cỏ lá rộng và lá hẹp, cỏ hằng niên và đa niên. Cỏ chết sau 3 – 5 ngày. Dùng cho vườn cây Cà phê.', N'### Cây trồng: Cà phê
- **Đối tượng (loại cỏ):** Cỏ lá hẹp và lá rộng
- **Liều lượng & cách pha:** 1,6 kg/ha; Pha 1 gói/bình 20 – 25 lít nước
- **Lượng nước phun:** 500 lít/ha
- **Thời điểm phun:** Khi cỏ đang phát triển mạnh
### Lưu ý
- Thời gian cách ly: Không xác định
- Phun định hướng, tránh thuốc bay vào lá/cành non
- Pha thuốc với nước trong; phun sương mịn, phủ đều
### Hướng dẫn an toàn và bảo quản
- Giữ trong bao bì gốc, đậy kín, nơi khô ráo, thoáng mát
- Mang đầy đủ đồ bảo hộ; không ăn uống khi pha/phun
- Tiêu hủy bao bì sau sử dụng
### Sơ cứu khi ngộ độc
- Dính mắt: Rửa 15–20 phút
- Dính da: Rửa xà phòng & nước sạch
- Nuốt phải: Không gây nôn, đưa đến cơ sở y tế mang nhãn thuốc', N'Glufosinate Ammonium 24% w/w; Oxyfluorfen 8% w/w; Chất mang, phụ gia: 68% w/w.', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Cà phê', 3, 0, CAST(1.60 AS Decimal(18, 2)), N'Diệt cỏ đa niên. Dùng phễu chụp khi phun để bảo vệ cây trồng.', CAST(N'2026-03-07T07:44:10.6388182' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (98, N'sp0098', N'FASFIX', N'Diệt hiệu quả các loại cỏ dại trên vườn cây Cà phê và các cây trồng khác như cam, nhãn, xoài, ca cao, chuối.', N'### Cây trồng: Cà phê
- **Đối tượng (loại cỏ):** Cỏ lá hẹp và lá rộng
- **Liều lượng & cách pha:** 2,0 – 3,0 lít/Ha; Pha 80 – 120 ml/16 lít nước
- **Lượng nước phun:** 320 – 400 lít/Ha
- **Thời điểm phun:** Khi cỏ đang phát triển mạnh
### Lưu ý
- Thời gian cách ly: Không xác định
- Tăng lượng nước khi ruộng nhiều cỏ; tránh phun vào lá/cành non
- Rửa bình và dụng cụ phun sau khi sử dụng
### Hướng dẫn an toàn và bảo quản
- Giữ bao bì gốc, đậy kín, nơi khô ráo, thoáng mát
- Mang đầy đủ đồ bảo hộ; không ăn uống khi pha/phun
- Tiêu hủy bao bì sau sử dụng
### Sơ cứu khi ngộ độc
- Dính mắt: Rửa 15–20 phút
- Dính da: Rửa xà phòng & nước sạch
- Nuốt phải: Không gây nôn, đưa đến cơ sở y tế mang nhãn thuốc', N'Glufosinate Ammonium 150 g/l; Dung môi, phụ gia: vừa đủ 1 lít.', CAST(150000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Cà phê, Cam', 3, 0, CAST(2.50 AS Decimal(18, 2)), N'Rửa sạch bình bơm ngay sau khi phun. Tránh bay thuốc vào cây trồng.', CAST(N'2026-03-07T07:44:10.6388186' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (99, N'sp0099', N'FASFIX BÔNG 6', N'Diệt hiệu quả nhiều loại cỏ lá hẹp và lá rộng trên vườn cây Cà phê.', N'### Cây trồng: Cà phê
- **Đối tượng (loại cỏ):** Cỏ lá hẹp và lá rộng
- **Liều lượng & cách pha:** 2,0 – 3,0 lít/Ha; Pha 80 – 120 ml/16 lít nước hoặc 125 – 185 ml/25 lít nước
- **Lượng nước phun:** 400 lít/Ha
- **Thời điểm phun:** Khi cỏ đang phát triển mạnh
### Lưu ý
- Thời gian cách ly: Không xác định
- Tăng lượng nước khi ruộng nhiều cỏ hoặc cỏ cao; tránh phun vào lá/cành non
- Rửa bình bơm và dụng cụ sau khi phun; pha thuốc với nước trong
- Phun khi trời im gió hoặc gió nhẹ
### Hướng dẫn an toàn và bảo quản
- Giữ trong bao bì gốc, đậy kín, nơi khô ráo, thoáng mát
- Mang đồ bảo hộ; không ăn uống khi pha/phun
- Tiêu hủy bao bì sau sử dụng
### Sơ cứu khi ngộ độc
- Dính mắt: Rửa 15–20 phút
- Dính da: Rửa xà phòng và nước sạch
- Nuốt phải: Không gây nôn, đưa đến cơ sở y tế', N'Glufosinate Ammonium 150 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(310000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Cà phê', 3, 0, CAST(2.50 AS Decimal(18, 2)), N'Pha với nước trong. Phun khi trời lặng gió.', CAST(N'2026-03-07T07:44:10.6388189' AS DateTime2), NULL, 1, 3, NULL, NULL)
GO
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (100, N'sp0100', N'FARUS 25SC', N'Thuốc đặc trị cỏ lồng vực (cỏ gạo, cỏ kê) và một số loại cỏ lá rộng trên ruộng lúa.', N'### Cây trồng: Lúa (sạ)
- **Đối tượng (loại cỏ):** Cỏ lồng vực (cỏ gạo, cỏ kê), một số loại cỏ lá rộng
- **Liều lượng & cách pha:** 1,0 lít/Ha; Pha 60 ml/bình 25 lít nước
- **Lượng nước phun:** 320 – 400 lít/Ha
- **Thời điểm phun:** Sau khi sạ 8 – 10 ngày, khi cỏ lồng vực có 2 – 3,5 lá
### Lưu ý
- Thời gian cách ly: Không xác định
- Lắc kỹ chai trước khi sử dụng
- Phun khi ruộng cạn nước nhưng đủ ẩm; phun sương mịn, phủ đều lá cỏ
- Có thể phối hợp với Star 10 WP hoặc Beron 10 WP (thử nghiệm nhỏ trước)
### Hướng dẫn an toàn và bảo quản
- Giữ bao bì gốc, đậy kín, nơi khô ráo, thoáng mát
- Mang đồ bảo hộ; không ăn uống khi pha/phun
- Tiêu hủy bao bì sau sử dụng', N'Quinclorac 250 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(130000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 3, 0, CAST(1.00 AS Decimal(18, 2)), N'Đặc trị cỏ lồng vực. Lắc kỹ chai trước khi dùng.', CAST(N'2026-03-07T07:44:10.6388192' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (101, N'sp0101', N'DOMINO', N'Diệt hiệu quả các loại cỏ thuộc nhóm hòa bản, cháo chác và lá rộng trên ruộng lúa như: lồng vực (cỏ gạo), chác, lác, rau muống, rau mác, cỏ mực, lục bình, rong, vẩy ốc, bợ bợ.', N'### Cây trồng: Lúa sạ (cấy)
- **Đối tượng (loại cỏ):** Cỏ nhóm hòa bản, cháo chác và lá rộng
- **Liều lượng & cách pha:** 0,15 – 0,20 kg/Ha; Pha 16 g/bình 18 – 20 lít nước
- **Lượng nước phun:** 320 – 400 lít/Ha
- **Thời điểm phun:** Khi cỏ có 3 – 4 lá (10 – 15 ngày sau sạ/cấy)
### Lưu ý
- Thời gian cách ly: Không xác định
- Khuấy đều thuốc khi pha; tăng lượng nếu cỏ > 4 lá
- Không phun khi nhiệt độ < 17°C
- Quản lý nước: tháo cạn trước, giữ nước 2/3 chiều cao cây sau 1–2 ngày, duy trì 4–5 ngày
- Phun bằng vòi sương mịn để phủ đều lá
### An toàn
- Giữ bao bì gốc, đậy kín, nơi khô ráo, thoáng mát
- Mang đồ bảo hộ; không ăn uống khi pha/phun', N'[Tên hoạt chất cụ thể] 20% w/w; Phụ gia: 80% w/w.', CAST(220000.00 AS Decimal(18, 2)), 49, 0, NULL, N'Lúa', 3, 0, CAST(0.18 AS Decimal(18, 2)), N'Trị cỏ cháo, chác, lác. Không phun khi trời lạnh dưới 17 độ C.', CAST(N'2026-03-07T07:44:10.6388196' AS DateTime2), CAST(N'2026-03-19T07:16:34.3897935' AS DateTime2), 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (102, N'sp0102', N'DIUSINATE', N'Dùng để phòng và trị nhiều loại cỏ lá rộng và lá hẹp, cỏ hằng niên và đa niên, từ lúc mới mọc đến khi cỏ tăng trưởng mạnh. Làm cỏ vàng và chết sau 3-5 ngày phun. Đồng thời hủy diệt hạt cỏ đang và sắp nảy mầm trong đất. Sản phẩm được đăng ký trị cỏ trên cây Cao su.', N'### Cây trồng: Cao su
- **Đối tượng (loại cỏ):** Cỏ lá rộng & lá hẹp, hằng niên & đa niên
- **Liều lượng & cách pha:** 3,5 – 4,0 lít/ha; Pha 180 – 200 ml/bình 25 lít nước
- **Lượng nước phun:** 500 lít/ha
- **Thời điểm phun:** Cây cao su >4 năm, thân vỏ hóa gỗ >0,5 m; cỏ đang tăng trưởng
### Lưu ý
- Phun sát ngọn lá cỏ; dùng phễu chụp để định hướng
- Tránh phun vào lá/thân non cây cao su
- Pha thuốc với nước trong; phun sương mịn
### An toàn
- Giữ bao bì gốc, đậy kín, nơi khô ráo
- Mang đồ bảo hộ; không ăn uống khi pha/phun', N'Glufosinate Ammonium 108 g/kg; Diuron 160 g/kg; Dung môi và phụ gia: đủ cho 1 lít.', CAST(250000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Cao su', 3, 0, CAST(3.80 AS Decimal(18, 2)), N'Chỉ dùng cho vườn cao su trên 4 năm tuổi (đã hóa gỗ).', CAST(N'2026-03-07T07:44:10.6388199' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (103, N'sp0103', N'DINAMIC', N'Thuốc được sử dụng để phòng và trị cỏ lá rộng và cỏ lá hẹp (hòa thảo) trên đất trồng mía. DINAMIC 700 WG chủ yếu diệt cỏ trước khi mọc, khi cỏ đang nảy mầm hoặc khi cỏ mới mọc còn nhỏ (1 - 3 lá).', N'### Cây trồng: Mía
- **Đối tượng (loại cỏ):** Cỏ hòa thảo và cỏ lá rộng
- **Liều lượng & cách pha:** 1,2 kg/Ha; Pha 1 gói 50 g thuốc với 18 – 20 lít nước
- **Lượng nước phun:** 400 – 500 lít/Ha
- **Thời điểm phun:** - Phủ đều lên mặt đất
  - Mía trồng mới: sau khi trồng 1 – 7 ngày
  - Mía lưu gốc: sau thu hoạch, dọn lá, xới đất 1 – 10 ngày
### Lưu ý
- Phun đều lên mặt đất, không để sót hay lối
- Pha thuốc vào nước, khuấy/lọc đều
- Tránh thuốc bay sang cây khác
- Chỉ dùng trị cỏ trên đất trồng mía
### An toàn
- Giữ bao bì gốc, đậy kín, nơi khô ráo
- Mang đồ bảo hộ khi pha/phun', N'Amicarbazone 700 g/kg; Chất mang, phụ gia: 300 g/kg.', CAST(120000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Mía', 3, 0, CAST(1.20 AS Decimal(18, 2)), N'Phun phủ đều mặt đất. Hiệu quả cao khi đất ẩm.', CAST(N'2026-03-07T07:44:10.6388203' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (104, N'sp0104', N'BUP 700SE', N'Thuốc trị hiệu quả nhóm cỏ hòa thảo (như lồng vực, đuôi phụng) và các loại cỏ lá rộng, cỏ chác lác trên ruộng lúa.', N'### Cây trồng: Lúa (sạ)
- **Đối tượng (loại cỏ):** Cỏ hòa thảo (lồng vực, đuôi phụng), cỏ lá rộng, chác lác
- **Liều lượng & cách pha:** Vui lòng tham khảo hướng dẫn trên bao bì
- **Lượng nước phun:** 400 lít/ha
- **Thời điểm phun:** Sau sạ 11 – 12 ngày, ruộng đủ ẩm, sau 24 giờ cho nước vào ruộng
### Lưu ý
- Thời gian cách ly: Không xác định
- Phun ướt đều lá cỏ
### An toàn
- Giữ bao bì gốc, đậy kín, nơi khô ráo
- Mang đồ bảo hộ khi pha/phun, không ăn uống', N'Butachlor 350 g/l; Propanil 350 g/l; Phụ gia: vừa đủ 1 lít.', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 3, 0, CAST(1.20 AS Decimal(18, 2)), N'Hậu nảy mầm sớm. Cho nước vào ruộng sau phun 24h.', CAST(N'2026-03-07T07:44:10.6388206' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (105, N'sp0105', N'BROADSAFE 200 EC', N'Thuốc diệt trị hiệu quả các loại cỏ thuộc nhóm hòa thảo như: Cỏ chỉ, mần trầu, túc, lông tây, đuôi chồn, lá tre, đuôi phụng, lồng vực. Sử dụng an toàn cho cây Đậu tương (đậu nành).', N'### Cây trồng: Đậu tương (đậu nành)
- **Đối tượng (loại cỏ):** Cỏ hòa thảo (Cỏ chỉ, mần trầu, túc, lông tây, đuôi chồn, lá tre, đuôi phụng, lồng vực)
- **Liều lượng & cách pha:** 0,4 lít/Ha; Pha 25 ml/bình 25 lít nước
- **Lượng nước phun:** 320 – 400 lít/Ha
- **Thời điểm phun:** Sau gieo hạt 10 – 15 ngày, khi cỏ 3 – 5 lá
### Lưu ý
- Phun ướt đều lá cỏ
- Hiệu quả cao khi đất đủ ẩm', N'Quizalofop-P-Ethyl 200 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(140000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Đậu tương', 3, 0, CAST(0.40 AS Decimal(18, 2)), N'Chuyên trị cỏ hòa thảo. An toàn cho cây lá rộng.', CAST(N'2026-03-07T07:44:10.6388209' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (106, N'sp0106', N'BETO 14WP', N'Thuốc chuyên dùng để trị các loại cỏ trên ruộng lúa cấy. Đặc biệt hiệu quả đối với các loại cỏ như: Cỏ lồng vực, đuôi phụng, cỏ chỉ, cỏ cháo, chác, rau mác, rảy bợ, cỏ xà bông, vẩy ốc, rau muống, và nhiều loại cỏ khác.', N'### Cây trồng: Lúa cấy
- **Đối tượng (loại cỏ):** Cỏ lồng vực, đuôi phụng, cỏ chỉ, cỏ cháo, chác, rau mác...
- **Liều lượng & cách pha:** 0,3 – 0,6 kg/Ha; Pha 1 gói 15 g với bình 12 lít nước
- **Lượng nước phun:** 320 – 500 lít/Ha
- **Thời điểm sử dụng:**
  - Vụ mùa: 5 – 7 ngày sau cấy
  - Vụ xuân: 7 – 10 ngày sau cấy
  - Phun khi lúa bén rễ hồi xanh và cỏ có 1 – 2 lá
- **Phương pháp xử lý:** Pha với nước để phun trực tiếp hoặc trộn với đất bột, phân bón để rải', N'Bensulfuron Methyl 2% w/w; Acetochlor 12% w/w; Chất mang, phụ gia: 86% w/w.', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa cấy', 3, 0, CAST(0.50 AS Decimal(18, 2)), N'Dùng cho lúa cấy. Có thể trộn với phân để rải.', CAST(N'2026-03-07T07:44:10.6388213' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (107, N'sp0107', N'BERON 10WP', N'Beron 10WP diệt cỏ ở giai đoạn tiền nảy mầm và hậu nảy mầm sớm (cỏ 1 – 2 lá). Dùng cho lúa sạ và lúa cấy. Diệt nhiều loại cỏ lá hẹp nhóm năn lác và cỏ lá rộng như: cỏ cháo, chác, năn, cỏ mương, xà bông, bợ bợ, rau mác bao, vẩy ốc...', N'### Cây trồng: Lúa sạ, Lúa cấy
- **Đối tượng (loại cỏ):** Cỏ lá hẹp nhóm năn lác và cỏ lá rộng
- **Liều lượng & cách pha:** 150 – 200 g/Ha với 320 lít nước; Pha 10 g/bình 16 lít
- **Lượng nước phun:** 320 lít/Ha
- **Thời điểm xử lý:** 1 – 5 ngày sau sạ hoặc cấy
- **Điều kiện ruộng:** Ruộng có nước xâm xấp 1 – 3 cm, đủ ẩm
### Kết hợp với thuốc khác
- Giai đoạn 1–5 ngày: Beron 10WP + Butoxim 60EC
- Giai đoạn 6–10 ngày: Beron 10WP + Pyanchor 5EC
### Lưu ý
- Không để mặt ruộng khô hoặc nứt nẻ', N'Bensulfuron Methyl 10% w/w; Phụ gia, chất mang: 90% w/w.', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 3, 0, CAST(0.20 AS Decimal(18, 2)), N'Trị cỏ cháo, chác. Giữ nước ruộng 2-5cm sau khi xử lý.', CAST(N'2026-03-07T07:44:10.6388216' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (108, N'sp0108', N'BES BU 30SE', N'Thuốc có hiệu quả diệt cỏ từ giai đoạn mầm đến khi cỏ mọc 1 - 2 lá. Đặc trị các loại cỏ như: cỏ chác, cỏ lác, cỏ lồng vực, cỏ đuôi phụng, và nhiều loại cỏ lá rộng khác trên ruộng lúa.', N'### Cây trồng: Lúa (sạ)
- **Đối tượng (loại cỏ):** Cỏ chác, cỏ lác, cỏ lồng vực, cỏ đuôi phụng và cỏ lá rộng
- **Liều lượng & cách pha:** 1,2 lít/Ha; Pha 50–60 ml/bình 16 lít hoặc 90 ml/bình 25 lít nước
- **Lượng nước phun:** 400 lít/Ha
- **Thời điểm & điều kiện ruộng:** Phun từ sau sạ đến 3–4 ngày; đất đủ ẩm; sau phun 1–3 ngày, cho nước vào ruộng và giữ nước liên tục
### An toàn
- Rất độc với sinh vật thủy sinh, không phun gần nguồn nước', N'Butachlor 28.5% w/w; Bensulfuron Methyl 1.5% w/w; Chất an toàn Fenclorim 10% w/w; Dung môi, phụ gia: 60% w/w.', CAST(130000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 3, 0, CAST(1.20 AS Decimal(18, 2)), N'Rất độc với sinh vật thủy sinh. Không phun gần nguồn nước.', CAST(N'2026-03-07T07:44:10.6388247' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (109, N'sp0109', N'BESBU 30WP', N'Hiệu quả cao với 3 nhóm cỏ chính: Cỏ hòa bản, cỏ năn lác, và cỏ lá rộng mọc từ hạt. Diệt các loại cỏ phổ biến như: đuôi phụng, lồng vực cạn, cỏ gạo, chác, lác, bợ bợ, vẩy ốc, xà bông, rau muống, mác… Ức chế mạnh sự phát triển của lúa rài (lúa cỏ).', N'### Cây trồng: Lúa (sạ)
- **Đối tượng (loại cỏ):** Cỏ hòa bản, năn lác, cỏ lá rộng mọc từ hạt, lúa rài
- **Liều lượng & cách pha:** 1,2 kg/ha; Pha 90 g/bình 25 lít hoặc 60 g/bình 16 lít nước
- **Lượng nước phun:** 320 lít/ha
- **Thời điểm & điều kiện ruộng:** Phun 0–4 ngày sau sạ; phun sớm để hiệu lực cao; ruộng đủ ẩm hoặc có màng nước mỏng
### Lưu ý
- Quậy thuốc tan đều trước khi phun
- Sau phun 2–3 ngày, cho nước vào ruộng
- Không để khô nứt hoặc ngập ngọn lúa', N'Butachlor 28.5% w/w; Bensulfuron Methyl 1.5% w/w; Chất an toàn (Fenclorim) 10% w/w; Chất mang, phụ gia: 60% w/w.', CAST(130000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 3, 0, CAST(1.20 AS Decimal(18, 2)), N'Ức chế lúa cỏ. Phun sớm 0-4 ngày sau sạ.', CAST(N'2026-03-07T07:44:10.6388251' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (110, N'sp0110', N'ANSARON 500SC', N'Diệt hiệu quả nhiều loại cỏ như: mần trầu, cỏ túc, cỏ ống, đuôi chồn, cỏ chân gà, dền gai, mần ri, sam, cỏ cháo, chác, mắc cỡ… Chủ yếu trừ cỏ ở giai đoạn tiền nảy mầm hoặc khi cỏ mới mọc còn nhỏ (1–2 lá). Hiệu lực kéo dài, giúp giảm chi phí trừ cỏ.', N'### Cây trồng: Mía
- **Đối tượng (loại cỏ):** Cỏ lá hẹp và lá rộng
- **Liều lượng & cách pha:** 2,5 – 3,0 lít/ha; Pha 100 – 120 ml/bình 16 lít nước
- **Lượng nước phun:** Khoảng 400 lít/ha
- **Thời điểm & điều kiện ruộng:** Phun ngay sau khi đặt hom 0–3 ngày; đất đủ ẩm; tránh phun trực tiếp ngọn mía đã mọc', N'Diuron 500 g/l; Dung môi và phụ gia: cho đủ 1 lít.', CAST(310000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Mía', 3, 0, CAST(2.80 AS Decimal(18, 2)), N'Tránh phun trực tiếp vào ngọn mía. Đất càng ẩm càng tốt.', CAST(N'2026-03-07T07:44:10.6388254' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (111, N'sp0111', N'ENSPRAY 99 EC', N'Đặc trị các loại sâu hại chích hút: nhện đỏ, nhện lông nhung, sâu hồng đục quả… Thuốc mạnh, ít hại thiên địch, an toàn cho con người và môi trường, không để lại dư lượng, thích hợp sản xuất nông sản sạch.', N'### Cây trồng: Chè (Trà)
- **Đối tượng:** Nhện đỏ
- **Liều lượng & cách pha:** 1,5 lít/Ha; Pha 75 ml/bình 25 lít nước
- **Thời điểm phun:** Khi nhện chớm xuất hiện
### Cây trồng: Cam
- **Đối tượng:** Nhện
- **Liều lượng & cách pha:** 0,3%; Pha 300 ml/100 lít nước
### Cây trồng: Nhãn
- **Đối tượng:** Nhện lông nhung
- **Liều lượng & cách pha:** 0,5%; Pha 500 ml/100 lít nước
### Cây trồng: Bưởi
- **Đối tượng:** Sâu hồng đục quả
- **Liều lượng & cách pha:** 1%; Pha 1 lít/100 lít nước
### Lưu ý
- Khuấy kỹ dầu tan đều trong nước trước và trong khi phun
- Không pha chung với các thuốc chưa được khuyến cáo', N'Phụ gia, dung môi: vừa đủ.', CAST(160000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Cây ăn trái, Chè', 4, 2, CAST(1.50 AS Decimal(18, 2)), N'Dầu khoáng an toàn. Thích hợp cho nông sản sạch. Khuấy kỹ khi pha.', CAST(N'2026-03-07T07:44:10.6388257' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (112, N'sp0112', N'SEU DO', N'Đặc trị rầy nâu hại lúa.', N'### Cây trồng: Chè (Trà)
- **Đối tượng:** Nhện đỏ
- **Liều lượng:** 1,5 lít/Ha; pha 75 ml/bình 25 lít nước
### Cây trồng: Cam
- **Đối tượng:** Nhện
- **Liều lượng:** Nồng độ 0,3%; pha 300 ml/100 lít nước
### Cây trồng: Nhãn
- **Đối tượng:** Nhện lông nhung
- **Liều lượng:** Nồng độ 0,5%; pha 500 ml/100 lít nước
### Cây trồng: Bưởi
- **Đối tượng:** Sâu hồng đục quả
- **Liều lượng:** Nồng độ 1%; pha 1 lít/100 lít nước
### Lưu ý
- Khuấy kỹ trước & trong khi phun
- Không phun khi cây bị úng nước hoặc khô hạn', N'Acetamiprid 30 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(310000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa, Cam', 3, 7, CAST(0.80 AS Decimal(18, 2)), N'Đặc trị rầy nâu. Không phun khi cây bị úng nước.', CAST(N'2026-03-07T07:44:10.6388261' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (113, N'sp0113', N'SECSAIGON', N'Hiệu quả trong phòng trị sâu cuốn lá lúa. Phòng trị sâu hồng hại bông vải.', N'### Cây trồng: Lúa
- **Đối tượng (sâu hại):** Sâu cuốn lá
- **Liều lượng & cách pha:** 0,4 lít/Ha; pha 30 ml/bình 25 lít nước
- **Thời điểm phun:** Khi sâu non mới xuất hiện
### Cây trồng: Bông (Bông vải)
- **Đối tượng (sâu hại):** Sâu hồng
- **Liều lượng & cách pha:** 0,4–0,6 lít/Ha; pha 40–100 ml/100 lít nước
### Lưu ý
- Phun đều thuốc lên cây, đặc biệt cành & lá
- Có thể pha chung nhiều thuốc khác; tránh pha với dung dịch kiềm cao hoặc thuốc chứa lưu huỳnh', N'Cypermethrin 25% w/w; Dung môi, phụ gia: 75% w/w (cho đủ 100%).', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa, Bông', 2, 14, CAST(0.50 AS Decimal(18, 2)), N'Nhóm Cúc tổng hợp. Rất độc với cá. Cách ly 14 ngày.', CAST(N'2026-03-07T07:44:10.6388264' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (114, N'sp0114', N'SAROMITA', N'Phòng trị hiệu quả các loại nhện hại cây trồng như: Nhện đỏ hại chè, Nhện gié, bọ phấn hại lúa, Nhện lông nhung hại nhãn.', N'### Cây trồng: Lúa
- **Đối tượng:** Bọ phấn, Nhện gié
- **Liều lượng & cách pha:** 0,4–0,8 lít/Ha
- **Thời điểm phun:** Khi mật độ bọ phấn 4–5 con/khóm hoặc nhện mới xuất hiện
### Cây trồng: Chè
- **Đối tượng:** Nhện đỏ
- **Liều lượng & cách pha:** 0,3–0,5 lít/Ha
### Cây trồng: Nhãn
- **Đối tượng:** Nhện lông nhung
- **Liều lượng & cách pha:** Nồng độ 0,07–0,1%
### Lưu ý chung
- Thời gian cách ly: 7 ngày trước thu hoạch
- Phun đều tán lá, bẹ lá, kỹ mặt dưới lá (chè)
- Có thể pha chung với thuốc trừ sâu bệnh khác, trừ thuốc tính kiềm cao và dầu khoáng', N'Propargite 570 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(240000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Chè, Lúa', 3, 7, CAST(0.60 AS Decimal(18, 2)), N'Đặc trị nhện. Không pha với dầu khoáng và thuốc tính kiềm.', CAST(N'2026-03-07T07:44:10.6388267' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (115, N'sp0115', N'SAPEN ALPHA', N'Thuốc trừ cỏ chuyên dùng cho ruộng lúa, phòng trừ hiệu quả các loại cỏ dại.', N'### Cây trồng: Lúa
- **Đối tượng:** Bọ phấn, Nhện gié
- **Liều lượng:** 0,4–0,8 lít/Ha
### Cây trồng: Chè
- **Đối tượng:** Nhện đỏ
- **Liều lượng:** 0,3–0,5 lít/Ha
### Cây trồng: Nhãn
- **Đối tượng:** Nhện lông nhung
- **Liều lượng:** Nồng độ 0,07–0,1%
### Lưu ý
- Phun kỹ 2 mặt lá
- Thời gian cách ly: 7 ngày', N'Đạm (N) 15% (min); Lân (P2O5) 15% (min); Kali (K2O) 15% (min).', CAST(250000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa, Chè', 2, 7, CAST(0.60 AS Decimal(18, 2)), N'Tiếp xúc, vị độc mạnh. Phun kỹ 2 mặt lá.', CAST(N'2026-03-07T07:44:10.6388271' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (116, N'sp0116', N'SAIVINA', N'Đặc trị rầy nâu hại lúa. Thuốc có hiệu quả với các loại sâu ăn lá và chích hút trên nhiều loại cây trồng (đăng ký cho rầy nâu trên lúa).', N'### Cây trồng: Lúa
- **Đối tượng (sâu hại):** Rầy nâu
- **Liều lượng & cách pha:** 1,0–2,0 lít/Ha; pha 80–100 ml/bình 25 lít nước
- **Lượng nước phun:** 500 lít/Ha
- **Thời điểm phun:** Khi rầy mới chớm xuất hiện (rầy tuổi nhỏ 1–2)
- **Cách phun:** Phun vào phần gốc lúa, nơi rầy sinh sống; tốt nhất buổi sáng sớm hoặc chiều mát
### Lưu ý
- Thời gian cách ly: 14 ngày trước thu hoạch', N'Carbaryl 430 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(220000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 3, 14, CAST(1.50 AS Decimal(18, 2)), N'Đặc trị rầy nâu. Phun vào gốc lúa. Cách ly 14 ngày.', CAST(N'2026-03-07T07:44:10.6388274' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (117, N'sp0117', N'SAIMIDA', N'Đặc biệt công hiệu trong việc trị các loại côn trùng chích hút trên cây cà phê, bao gồm: Rệp sáp gốc, Rệp sáp cành, trái.', N'### Cây trồng: Lúa
- **Đối tượng (sâu hại):** Rầy nâu
- **Liều lượng & cách pha:** 1,0–2,0 lít/Ha; pha 80–100 ml/bình 25 lít nước
- **Lượng nước phun:** 500 lít/Ha
- **Cách phun:** Phun vào phần gốc lúa
### Lưu ý
- Thời gian cách ly: 14 ngày', N'Imidacloprid 100 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(130000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa, Cà phê', 3, 14, CAST(1.50 AS Decimal(18, 2)), N'Lưu dẫn mạnh. Trị rệp sáp, rầy nâu. Độc với ong.', CAST(N'2026-03-07T07:44:10.6388277' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (118, N'sp0118', N'SAGO SUPPER', N'Phòng trừ hiệu quả sâu hại trên đọt, nõn và các ngã ba, ngã tư giữa thân và cành.', N'### Thông tin sản phẩm: SAGO SUPER 3GR
- **Dạng thuốc:** Hạt (granule)
- **Hoạt tính:** Tiếp xúc, vị độc; thấm sâu và xông hơi
- **Công dụng:** Trị sâu đục thân bên trong cây trồng hiệu quả
### Cách dùng
- **Bón gốc:** Rải vào gốc cây hoặc bỏ vào hốc sau khi tra hạt
- **Bón theo luống:** Gieo dọc luống trước hoặc trong lúc gieo trồng
- **Túi lọc tiện dụng:** Mỗi gói 30g đặt vào nách lá cây trồng', N'Chlorpyrifos Methyl 3% w/w; Chất mang, phụ gia: 97% w/w.', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Đa dụng', 2, 14, CAST(10.00 AS Decimal(18, 2)), N'Dạng hạt rải gốc. Xông hơi mạnh. Rất độc với thủy sinh.', CAST(N'2026-03-07T07:44:10.6388281' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (119, N'sp0119', N'SAGO CÂY DỪA', N'Phòng trừ hiệu quả các loại sâu hại như: Sâu đục thân lúa, sâu đục trái bắp (ngô), ve sầu hại cà phê.', N'### CÂY TRỒNG: Lúa
* **ĐỐI TƯỢNG (SÂU HẠI):** Sâu đục thân
* **LIỀU LƯỢNG & CÁCH DÙNG:** 15 – 20 kg/ha, rải đều thuốc trên mặt ruộng
* **ĐIỀU KIỆN XỬ LÝ:** Giữ mực nước trong ruộng 3 – 5 cm liên tục trong 3 – 5 ngày sau khi rải
---
### CÂY TRỒNG: Cà Phê
* **ĐỐI TƯỢNG (SÂU HẠI):** Ve sầu
* **LIỀU LƯỢNG & CÁCH DÙNG:** 50 – 70 kg/ha, rải đều thuốc quanh gốc cây, sau đó tưới nước đủ ẩm
---
### CÂY TRỒNG: Ngô (Bắp)
* **ĐỐI TƯỢNG (SÂU HẠI):** Sâu đục trái (hoặc sâu đục thân giai đoạn loa kèn)
* **LIỀU LƯỢNG & CÁCH DÙNG:** 20 – 30 kg/ha, rắc thuốc vào loa kèn (nõn) của cây', N'Chlorpyrifos Methyl 3% w/w; Chất mang, chất phụ gia: 97% w/w.', CAST(310000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa, Cà phê', 2, 14, CAST(15.00 AS Decimal(18, 2)), N'Rải gốc trị sâu đục thân, ve sầu. Giữ nước ruộng khi rải.', CAST(N'2026-03-07T07:44:10.6388284' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (120, N'sp0120', N'SAGOFORT 10 GR', N'Phòng trị tuyến trùng gây sưng rễ, thối rễ, giúp bảo vệ hệ rễ khỏe mạnh và tăng năng suất cây trồng.', N'### CÂY TRỒNG: Tiêu
* **ĐỐI TƯỢNG:** Tuyến trùng sưng rễ
* **LIỀU LƯỢNG:** 30 kg/ha
* **PHƯƠNG PHÁP XỬ LÝ:** Xới nhẹ đất quanh gốc, rắc thuốc đều, lấp đất và tưới đủ ẩm
---
### LƯU Ý
* Thời gian cách ly: 14 ngày
* Rất độc với sinh vật thủy sinh – tuyệt đối tránh nguồn nước', N'Fosthiazate 10% w/w.', CAST(220000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Tiêu', 3, 14, CAST(30.00 AS Decimal(18, 2)), N'Đặc trị tuyến trùng. Rất độc, tuyệt đối tránh nguồn nước.', CAST(N'2026-03-07T07:44:10.6388287' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (121, N'sp0121', N'SAGO SUPPER', N'Thuốc dạng bả mồi dùng ngay, diệt các loại chuột hại. Thuốc tác dụng trực tiếp đến hệ tiêu hóa chuột, gây xuất huyết, khiến chuột ngừng cắn phá và chết.', N'### THÔNG TIN HƯỚNG DẪN: BẢ DIỆT CHUỘT
* **LIỀU DÙNG:** 2 kg/ha
* **CÁCH DÙNG:** Rải **5 – 10 viên bả** trước hang chuột hoặc dọc các vị trí chuột hay qua lại (bờ ruộng, mép tường, đường kiếm ăn). Cách **3 – 4 mét rải một viên**.
* **LƯU Ý:** Thu gom và tiêu hủy xác chuột chết', N'Brodifacoum 0,005% w/w; Phụ gia, bả mồi: cho đủ 100% w/w.', CAST(220000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Chuột', 2, 14, CAST(30.00 AS Decimal(18, 2)), N'Bả diệt chuột. Rải 5-10 viên trước hang. Nguy hiểm cho vật nuôi.', CAST(N'2026-03-07T07:44:10.6388291' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (122, N'sp0122', N'SAGO RAT', N'Thuốc dạng bả mồi dùng ngay, diệt các loại chuột hại. Tác dụng trực tiếp đến hệ tiêu hóa, gây xuất huyết và làm chuột chết nhanh.', N'### HƯỚNG DẪN SỬ DỤNG BẢ DIỆT CHUỘT
* **LIỀU DÙNG:** 2 kg/ha
* **CÁCH DÙNG:** Rải **5 – 10 viên bả** tại nơi chuột thường xuất hiện. Khoảng cách mỗi viên: **3 – 4 mét**.
* **LƯU Ý:** Thu gom và tiêu hủy xác chuột chết để tránh vật nuôi ăn phải', N'Brodifacoum 0,005% w/w; Phụ gia, bả mồi: cho đủ 100% w/w.', CAST(130000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Chuột', 2, 0, CAST(2.00 AS Decimal(18, 2)), N'Bả diệt chuột. Thu gom xác chuột sau khi xử lý.', CAST(N'2026-03-07T07:44:10.6388294' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (123, N'sp0123', N'RONINDA', N'Thuốc trừ sâu thế hệ mới, điều hòa sinh trưởng côn trùng, ức chế quá trình trao đổi chitin. Hiệu quả cao với côn trùng hai cánh (Diptera) như dòi đục lá, ruồi đục quả, muỗi; ít hại thiên địch, an toàn cho ong ký sinh.', N'### CÂY TRỒNG: Cà chua
* **ĐỐI TƯỢNG:** Dòi đục lá (sâu vẽ bùa)
* **LIỀU LƯỢNG:** Nồng độ 0,45% (Pha 80 ml/20 lít nước)
* **LƯỢNG NƯỚC PHUN:** 400 – 500 lít/ha
* **THỜI ĐIỂM PHUN:** Phun khi tỷ lệ hại đạt **5 – 7%**, phun sáng sớm hoặc chiều mát, phun kỹ hai mặt lá', N'Cyromazine 100 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(130000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Cà chua', 3, 7, CAST(0.45 AS Decimal(18, 2)), N'Trị dòi đục lá. An toàn cho thiên địch.', CAST(N'2026-03-07T07:44:10.6388298' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (124, N'p0124', N'OSAGO 80WG', N'OSAGO 80WG đặc trị côn trùng chích hút như rầy, bọ phấn, rầy chổng cánh. Thuốc có tác dụng lưu dẫn hai chiều, thấm sâu, tiếp xúc, vị độc; hiệu lực mạnh và kéo dài; ít hại thiên địch và thân thiện với môi trường.', N'### CÂY ĂN TRÁI, RAU MÀU, LƯƠNG THỰC
- **Liều pha:** 25 – 50 g/25 lít nước (hoặc 200 – 400 g/phuy 200 lít)
- **Thời điểm phun:** Phun khi sâu rầy mới xuất hiện
- **Lưu ý:** Không phun khi trời nắng gắt hoặc cây nở hoa rộ', N'Pymetrozine 60% w/w; Nitenpyram 20% w/w; Chất mang, phụ gia: 20% w/w.', CAST(310000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa, Rau màu', 3, 7, CAST(0.40 AS Decimal(18, 2)), N'Đặc trị rầy, bọ phấn. Lưu dẫn 2 chiều.', CAST(N'2026-03-07T07:44:10.6388301' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (125, N'sp0125', N'NETOXIN 90 WP', N'NETOXIN 90 WP là thuốc trừ sâu tác dụng tiếp xúc, vị độc, có khả năng xông hơi và nội hấp nhẹ. Phổ tác dụng rộng, hiệu quả cao với sâu xanh hại lạc, sâu đục thân và sâu cuốn lá hại lúa.', N'### CÂY TRỒNG: Lúa
* **Đối tượng:** Sâu đục thân, sâu cuốn lá
* **Liều lượng:** 1,0 kg/ha (50 – 60 g/bình 25 lít nước)
* **Cách sử dụng:** Phun ướt đều tán lá khi sâu mới xuất hiện', N'Nereistoxin 90% w/w; Chất mang, phụ gia: 10% w/w.', CAST(130000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa', 2, 14, CAST(1.00 AS Decimal(18, 2)), N'Xông hơi nhẹ. Trị sâu đục thân, sâu cuốn lá.', CAST(N'2026-03-07T07:44:10.6388330' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (126, N'sp0126', N'MIPCIDE 50 WP', N'Đặc trị rầy nâu trên cây lúa, hiệu quả nhanh, diệt cả rầy trưởng thành và rầy non. Tăng hiệu quả khi pha chung với thuốc BUTYL.', N'### CÂY TRỒNG: Lúa
* **Đối tượng:** Rầy nâu
* **Liều lượng:** 1,0 kg/ha (50 – 60 g/bình 25 lít nước)
* **Cách sử dụng:** Phun ướt đều tán lá khi rầy vừa xuất hiện', N'Isoprocarb 50% w/w; Chất mang, phụ gia: 50% w/w.', CAST(210000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa', 2, 14, CAST(1.00 AS Decimal(18, 2)), N'Trị rầy nâu. Cách ly 14 ngày.', CAST(N'2026-03-07T07:44:10.6388334' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (127, N'sp0127', N'KINGSPIDER 93 SC', N'Đặc trị nhện đỏ trên cây cam. Hiệu quả diệt trứng, nhện non và nhện trưởng thành; ít ảnh hưởng đến thiên địch.', N'### CÂY TRỒNG: Cam
* **Đối tượng:** Nhện đỏ
* **Liều lượng:** 0,2% (200 ml/100 lít nước)
* **Cách sử dụng:** Phun ướt đều hai mặt lá, đặc biệt mặt dưới', N'Emamectin Benzoate 18 g/kg; Spirodiclofen 75 g/kg; Dung môi, phụ gia: 907 g/kg.', CAST(130000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Cam', 3, 7, CAST(0.20 AS Decimal(18, 2)), N'Trị nhện đỏ. Rất độc với sinh vật thủy sinh.', CAST(N'2026-03-07T07:44:10.6388337' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (128, N'sp0128', N'GÀ NÒI 95 SP', N'Đặc trị sâu đục thân và sâu cuốn lá trên lúa, hiệu quả cao khi phun sớm ở giai đoạn sâu non hoặc bướm rộ.', N'### CÂY TRỒNG: Lúa
* **Liều lượng:** 1,0 kg/ha (50 – 60 g/bình 25 lít)
* **Cách sử dụng:** Phun khi sâu non mới xuất hiện hoặc bướm rộ', N'Cartap Hydrochloride 95% w/w; Chất mang, phụ gia: 5% w/w.', CAST(310000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa', 2, 14, CAST(1.00 AS Decimal(18, 2)), N'Trị sâu đục thân. Phun sớm khi bướm rộ.', CAST(N'2026-03-07T07:44:10.6388341' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (129, N'sp0129', N'GÀ NÒI 4GR', N'Đặc trị sâu đục thân trên cây lúa, hiệu quả cao khi rải sớm ở giai đoạn sâu non hoặc bướm rộ.', N'### CÂY TRỒNG: Lúa
* **Liều lượng:** Theo khuyến cáo trên bao bì (thường 20-25 kg/ha)
* **Cách sử dụng:** Rải đều trên ruộng khi sâu non xuất hiện', N'Cartap Hydrochloride 4% w/w; Chất mang, phụ gia: 96% w/w.', CAST(130000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa', 3, 14, CAST(20.00 AS Decimal(18, 2)), N'Dạng hạt rải. Tránh rải khi mưa lớn.', CAST(N'2026-03-07T07:44:10.6388344' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (130, N'sp0130', N'ROLE 20WG', N'Đặc trị sâu đục quả trên cây cà chua. Hiệu quả cao nhờ khả năng nội hấp và thấm sâu. Hạn chế bị rửa trôi, phù hợp cho việc kiểm soát sâu hại.', N'### CÂY TRỒNG: Cà chua
* **Đối tượng:** Sâu đục quả
* **Liều lượng:** 150 g/ha (Pha 8 g/bình 25 lít nước)
* **Cách sử dụng:** Phun ướt đều tán lá khi sâu non tuổi 1 – 2 mới xuất hiện', N'Flubendiamide 20% w/w; Phụ gia: vừa đủ 100% w/w.', CAST(320000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Cà chua', 3, 5, CAST(0.15 AS Decimal(18, 2)), N'Trị sâu đục quả. Cách ly 5 ngày.', CAST(N'2026-03-07T07:44:10.6388348' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (131, N'sp0131', N'FENBIS 25 EC', N'Đặc trị bọ xít trên lúa, rệp trên đậu tương và bọ trĩ trên điều. Hiệu quả nhanh, diệt côn trùng hiệu quả nhờ cơ chế tiếp xúc, vị độc và nội hấp.', N'### CÂY TRỒNG: Lúa, Đậu tương, Điều
* **Đối tượng:** Bọ xít, Rệp, Bọ trĩ
* **Liều lượng:** 0,8 - 1,2 lít/ha
* **Cách sử dụng:** Phun ướt đều tán lá khi sâu mới xuất hiện', N'Fenvalerate 3,5% w/w; Dimethoate 21,5% w/w; Dung môi, phụ gia: 75% w/w.', CAST(220000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa, Đậu tương, Điều', 1, 14, CAST(1.00 AS Decimal(18, 2)), N'Rất độc với sinh vật thủy sinh. Tránh tiếp xúc với da.', CAST(N'2026-03-07T07:44:10.6388351' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (132, N'sp0132', N'DIOTO 830 WG', N'Đặc trị ốc bươu vàng trên cây lúa. Ngăn chặn ốc gây hại bằng cách làm gián đoạn hô hấp và tiêu hóa. Không gây ảnh hưởng đến sinh trưởng và phát triển của cây trồng.', N'### CÂY TRỒNG: Lúa
* **Đối tượng:** Ốc bươu vàng
* **Liều lượng:** 0,6 kg/ha
* **Cách sử dụng:** Phun đều trên ruộng khi mực nước 3 - 5 cm', N'Niclosamide olamine 830 g/kg; Chất mang, phụ gia: cho đủ 1 kg.', CAST(260000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa', 2, 0, CAST(0.60 AS Decimal(18, 2)), N'Không ảnh hưởng lúa. Rất độc cho cá, không dùng trong ruộng nuôi tôm cá.', CAST(N'2026-03-07T07:44:10.6388354' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (133, N'sp0133', N'DIOTO 250 EC', N'Đặc trị ốc bươu vàng trên cây lúa. Hiệu quả cao, diệt ốc nhanh chóng và triệt để.', N'### CÂY TRỒNG: Lúa
* **Đối tượng:** Ốc bươu vàng
* **Liều lượng:** 0,8 - 1,2 lít/ha
* **Cách sử dụng:** Phun đều trên ruộng khi mực nước 3 - 5 cm, giữ nước 2 - 3 ngày sau phun', N'Niclosamide 250 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(210000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa', 2, 0, CAST(1.00 AS Decimal(18, 2)), N'Nếu ruộng có nuôi tôm cá, phải đợi 7 ngày sau phun mới thả nước vào.', CAST(N'2026-03-07T07:44:10.6388358' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (134, N'sp0134', N'DIMENAT 20 EC', N'Đặc trị rệp sáp trên cây cà phê. Hiệu quả nhanh nhờ cơ chế tiếp xúc, vị độc và nội hấp mạnh.', N'### CÂY TRỒNG: Cà phê
* **Đối tượng:** Rệp sáp
* **Liều lượng:** 0,625 - 0,75 %
* **Cách sử dụng:** Phun ướt đều tán lá khi rệp sáp mới xuất hiện', N'Dimethoate 20% w/w; Dung môi, phụ gia: 80% w/w.', CAST(310000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Cà phê', 1, 14, CAST(2.00 AS Decimal(18, 2)), N'Thuốc có mùi hôi, xông hơi mạnh. Độc cao với ong và cá.', CAST(N'2026-03-07T07:44:10.6388361' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (135, N'sp0135', N'COMDA GOLD 5 WG', N'Đặc trị sâu cuốn lá, rầy nâu trên lúa. Hiệu quả cao đối với dòi đục lá (sâu vẽ bùa) trên cà chua, rầy xanh trên chè, bọ trĩ trên dưa hấu, sâu tơ trên bắp cải, nhện đỏ trên cam, nhện lông nhung trên nhãn.', N'### Cây trồng: Lúa, Cà chua, Chè, Dưa hấu, Bắp cải, Cam, Nhãn
- **Liều lượng:** 80 - 100 g/ha (hoặc nồng độ 0,02 - 0,075% tùy cây)
- **Cách sử dụng:** Phun ướt đều tán lá khi sâu mới xuất hiện', N'Emamectin benzoate 5% w/w; Chất mang, phụ gia: 95% w/w.', CAST(310000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Đa dụng', 3, 3, CAST(0.10 AS Decimal(18, 2)), N'Trị sâu cuốn lá, rầy nâu. Cách ly 3 ngày.', CAST(N'2026-03-07T07:44:10.6388364' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (136, N'sp0136', N'COMDA 250 EC', N'Đặc trị rệp muội, bọ trĩ, sâu tơ, sâu xanh da láng, bọ xít muỗi, rầy xanh, rệp sáp và rầy bông trên nhiều loại cây trồng. Hiệu quả nhanh nhờ cơ chế tiếp xúc, vị độc và khả năng bám dính tốt.', N'### Cây trồng: Hoa cúc, Dưa hấu, Bắp cải, Hành, Chè, Ớt, Cà phê, Xoài
- **Liều lượng:** 0,25 - 3 lít/ha (tùy loại cây và sâu hại)
- **Cách sử dụng:** Phun ướt đều cây khi sâu mới xuất hiện', N'Petroleum spray oil 245 g/l; Emamectin benzoate 5 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(130000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Đa dụng', 3, 0, CAST(1.00 AS Decimal(18, 2)), N'Dầu khoáng kết hợp Emamectin. Hiệu quả nhanh.', CAST(N'2026-03-07T07:44:10.6388368' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (137, N'sp0137', N'BUTYL 400 SC', N'Đặc trị rầy nâu trên lúa và rầy bông trên xoài. Hiệu quả kéo dài, kiểm soát rầy ở cả giai đoạn non và trưởng thành, ít tác dụng đến thiên địch.', N'### Cây trồng: Lúa, Xoài
- **Đối tượng:** Rầy nâu, Rầy bông
- **Liều lượng:** 0,1 - 0,125 lít/ha (Lúa)
- **Cách sử dụng:** Phun khi rầy mới xuất hiện', N'Buprofezin 400 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(310000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa, Xoài', 3, 7, CAST(0.13 AS Decimal(18, 2)), N'Đặc trị rầy nâu. Ít hại thiên địch.', CAST(N'2026-03-07T07:44:10.6388371' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (138, N'sp0138', N'BRIMGOLD 200WP', N'Đặc trị rầy nâu trên lúa và rệp sáp bột hồng trên sắn. Hiệu quả nhanh, mạnh, phù hợp cho các loại côn trùng gây hại ở giai đoạn tuổi nhỏ.', N'### Cây trồng: Lúa, Sắn (Khoai mì)
- **Đối tượng:** Rầy nâu, Rệp sáp bột hồng
- **Liều lượng:** 0,3 - 0,4 kg/ha
- **Cách sử dụng:** Phun kỹ nơi côn trùng tập trung', N'Dinotefuran 50 g/kg; Imidacloprid 150 g/kg; Chất mang, phụ gia: cho đủ 1 kg.', CAST(310000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa, Sắn', 3, 0, CAST(0.40 AS Decimal(18, 2)), N'Đặc trị rầy nâu, rệp sáp. Phun kỹ nơi côn trùng tập trung.', CAST(N'2026-03-07T07:44:10.6388374' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (139, N'sp0139', N'BOSAGO 12 AB', N'Đặc trị ốc bươu vàng trên cây lúa. Hiệu quả diệt ốc nhanh và kéo dài nhờ chất dẫn dụ mạnh. An toàn cho lúa và phù hợp với các giai đoạn canh tác.', N'### Cây trồng: Lúa
- **Đối tượng:** Ốc bươu vàng
- **Liều lượng:** 6 kg/ha
- **Cách sử dụng:** Rải đều trên ruộng', N'Metaldehyde 12% w/w; Bả mồi dẫn dụ, phụ gia: 88% w/w.', CAST(220000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa', 3, 0, CAST(6.00 AS Decimal(18, 2)), N'Bả diệt ốc. Rải đều trên ruộng.', CAST(N'2026-03-07T07:44:10.6388378' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (140, N'sp0140', N'BIOCIN', N'Đặc trị rầy nâu trên cây lúa. Hiệu quả nhanh, diệt cả rầy trưởng thành và rầy non. Tăng cường hiệu quả khi pha chung với thuốc BUTYL.', N'### Cây trồng: Lúa
- **Đối tượng:** Rầy nâu
- **Liều lượng:** 200 – 250 ml/ha
- **Cách sử dụng:** Phun mịn béc hoặc trộn phân rải', N'Bismerthiazol 250 g/kg; Phụ gia 750 g/kg.', CAST(210000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa', 2, 14, CAST(0.25 AS Decimal(18, 2)), N'Trị rầy nâu. Bảo quản nơi khô ráo.', CAST(N'2026-03-07T07:44:10.6388382' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (141, N'sp0141', N'BINHTOX 3.8 EC', N'Đặc trị rầy nâu trên cây lúa. Hiệu quả nhanh, diệt cả rầy trưởng thành và rầy non. Tăng cường hiệu quả khi pha chung với thuốc BUTYL.', N'### Cây trồng: Lúa
- **Đối tượng:** Rầy nâu
- **Liều lượng:** 1,0 kg/ha
- **Cách sử dụng:** Phun ướt đều tán lá khi rầy vừa xuất hiện', N'Đạm (N) 15% (min); Lân (P2O5) 15% (min); Kali (K2O) 15% (min).', CAST(310000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa', 2, 14, CAST(1.00 AS Decimal(18, 2)), N'Trị rầy nâu. Cách ly 14 ngày.', CAST(N'2026-03-07T07:44:10.6388385' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (142, N'sp0142', N'BASCIDE', N'Thuốc trừ sâu rầy, đặc trị bọ phấn, nhện gié trên lúa; nhện đỏ trên chè; nhện lông nhung trên nhãn.', N'### Cây trồng: Lúa, Chè, Nhãn
- **Đối tượng:** Bọ phấn, Nhện gié, Nhện đỏ, Nhện lông nhung
- **Liều lượng:** 0,3 - 0,8 lít/Ha (tùy cây trồng)
- **Cách sử dụng:** Phun ướt đều tán lá khi sâu hại mới xuất hiện', N'Isoprocarb 50% w/w; Chất mang, phụ gia: 50% w/w.', CAST(310000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa, Chè, Nhãn', 2, 14, CAST(0.60 AS Decimal(18, 2)), N'Trừ bọ phấn, nhện. Phun ướt đều tán lá.', CAST(N'2026-03-07T07:44:10.6388388' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (143, N'sp0143', N'VOVINAM 2.5EC', N'Thuốc trừ sâu sinh học, hiệu quả cao với sâu cuốn lá, sâu đục thân.', N'### Cây trồng: Lúa
- **Đối tượng:** Sâu hại (Sâu cuốn lá)
- **Cách sử dụng:** Phun khi sâu non tuổi 1 – 2, phun ướt đều', N'Hoạt chất chính: Emamectin Benzoate (Dự đoán từ tên thương mại thường gặp, mô tả gốc bị sai công thức NPK).', CAST(130000.00 AS Decimal(18, 2)), 50, 1, NULL, N'Lúa', 2, 7, CAST(0.80 AS Decimal(18, 2)), N'Phun khi sâu non tuổi 1-2. Mang đầy đủ bảo hộ.', CAST(N'2026-03-07T07:44:10.6388408' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (144, N'sp0144', N'SHERZOL', N'Thuốc trừ bệnh phổ rộng (Mô tả gốc bị nhầm lẫn sang thuốc chuột, giữ nguyên mô tả theo yêu cầu dù tên hoạt chất là thuốc bệnh).', N'### Hướng dẫn sử dụng bả diệt chuột
- **Liều dùng:** 2 kg/ha
- **Cách dùng:** Rải 5–10 viên bả tại các vị trí chuột thường đi lại (trước hang, bờ ruộng...)', N'Bismerthiazol 250 g/kg; Phụ gia 750 g/kg. Quy cách: Gói 80 g; Gói 400 g.', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Chuột', 1, 0, CAST(2.00 AS Decimal(18, 2)), N'Bả diệt chuột. Rải 5-10 viên trước hang. Nguy hiểm cho vật nuôi.', CAST(N'2026-03-07T07:44:10.6388412' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (145, N'sp0145', N'SALIPHOS 35 EC', N'Đặc trị sâu cuốn lá trên lúa, sâu keo trên ngô, rệp sáp trên cà phê và bọ xít muỗi trên điều. Hiệu quả nhanh, giảm thiểu dư lượng nhờ khả năng phân hủy nhanh.', N'### Cây trồng: Lúa, Ngô, Cà phê, Điều
- **Đối tượng:** Sâu cuốn lá, Sâu keo, Rệp sáp, Bọ xít muỗi
- **Liều lượng:** 1,5–2,0 lít/ha (hoặc nồng độ 0,33% cho cà phê)
- **Cách sử dụng:** Phun ướt đều tán lá', N'Phosalone 35% w/w; Dung môi, phụ gia: cho đủ 1 lít.', CAST(310000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa, Ngô, Cà phê', 1, 15, CAST(1.80 AS Decimal(18, 2)), N'Cách ly dài ngày (15 ngày). Không rửa dụng cụ ở nguồn nước.', CAST(N'2026-03-07T07:44:10.6388416' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (146, N'sp0146', N'SAIKUMI', N'Đặc trị rầy nâu trên cây lúa. Hiệu quả nhanh, diệt cả rầy trưởng thành và rầy non. Tăng cường hiệu quả khi pha chung với thuốc BUTYL.', N'### Cây trồng: Lúa
- **Đối tượng:** Rầy nâu
- **Liều lượng:** 1,0 kg/ha
- **Cách sử dụng:** Phun ướt đều tán lá khi rầy vừa xuất hiện', N'Isoprocarb 50% w/w; Chất mang, phụ gia: 50% w/w.', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 2, 14, CAST(1.00 AS Decimal(18, 2)), N'Trị rầy nâu. Có thể pha chung với Butyl.', CAST(N'2026-03-07T07:44:10.6388419' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (147, N'sp0147', N'SAGOMETRO', N'Thuốc trừ sâu sinh học, 100% nguồn gốc từ thực vật. Trừ sâu tơ bắp cải, sâu xanh cà chua, rầy bông xoài, sâu vẽ bùa trên cam. An toàn cho môi trường, không để lại dư lượng trên cây trồng, không diệt thiên địch.', N'### Cây trồng: Lúa, Rau màu, Cây ăn trái
- **Liều lượng:** 200–250 ml/ha
- **Cách sử dụng:** Phun ướt đều tán lá', N'Hoạt chất: Emamectin Benzoate hoặc Abamectin (Dự đoán vì mô tả là thuốc sâu sinh học, mô tả gốc bị nhầm sang thuốc chuột Brodifacoum).', CAST(220000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 3, 3, CAST(0.25 AS Decimal(18, 2)), N'Nguồn gốc thực vật. Không diệt thiên địch.', CAST(N'2026-03-07T07:44:10.6388422' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (148, N'sp0148', N'ROLE 20WG (Chuột)', N'Thuốc diệt chuột dạng bả (Tên sản phẩm trùng với thuốc sâu nhưng mô tả là thuốc chuột).', N'### Liều dùng & cách sử dụng
- **Liều dùng:** 2 kg/ha
- **Cách dùng:** Rải 5–10 viên trước hang chuột hoặc đường đi', N'Hoạt chất diệt chuột (Mô tả gốc bị nhầm công thức NPK).', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Chuột', 1, 0, CAST(2.00 AS Decimal(18, 2)), N'Bả diệt chuột. Thu gom xác chuột sau khi xử lý.', CAST(N'2026-03-07T07:44:10.6388426' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (149, N'sp0149', N'BIOCIN 10WP', N'Thuốc đặc trị vi khuẩn (Mô tả gốc bị nhầm sang thuốc chuột).', N'### Cây trồng: Lúa, Chè, Nhãn
- **Đối tượng:** Bọ phấn, Nhện gié, Nhện đỏ, Nhện lông nhung
- **Liều lượng:** 0,3–0,8 lít/ha (tùy cây)
- **Cách sử dụng:** Phun ướt đều tán lá', N'Bismerthiazol 250 g/kg; Phụ gia 750 g/kg.', CAST(220000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa, Chè, Nhãn', 2, 7, CAST(0.60 AS Decimal(18, 2)), N'Trừ bọ phấn, nhện. Ngưng phun trước thu hoạch.', CAST(N'2026-03-07T07:44:10.6388429' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (150, N'sp0150', N'BIOCIN 16WP', N'Đặc trị rầy nâu trên cây lúa. Hiệu quả nhanh, diệt cả rầy trưởng thành và rầy non. Tăng cường hiệu quả khi pha chung với thuốc BUTYL.', N'### Hướng dẫn sử dụng
- **Đối tượng:** Rầy nâu
- **Liều lượng:** 400–500 lít/ha (nước thuốc)
- **Cách sử dụng:** Phun khi sâu non tuổi 1–2', N'Isoprocarb 50% w/w; Chất mang, phụ gia: 50% w/w.', CAST(210000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 2, 14, CAST(1.00 AS Decimal(18, 2)), N'Phun khi sâu non tuổi 1-2. Mang kính, găng tay khi phun.', CAST(N'2026-03-07T07:44:10.6388433' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (151, N'sp0151', N'BUTTYL', N'Thuốc trừ rầy nâu (Mô tả gốc bị nhầm sang thuốc cỏ).', N'### Cây trồng: Lúa
- **Đối tượng:** Rầy nâu
- **Liều lượng:** 1,0 kg/ha
- **Cách sử dụng:** Phun ướt đều tán lá khi rầy vừa xuất hiện', N'Isoprocarb 50% w/w; Chất mang, phụ gia: 50% w/w.', CAST(310000.00 AS Decimal(18, 2)), 57, 0, NULL, N'Lúa', 2, 14, CAST(1.00 AS Decimal(18, 2)), N'Trị rầy nâu. Cách ly 14 ngày.', CAST(N'2026-03-07T07:44:10.6388436' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (152, N'sp0152', N'ANSARON CỐM', N'Thuốc trừ sâu rầy (Mô tả gốc bị nhầm sang thuốc cỏ).', N'### Cây trồng: Lúa, Chè, Nhãn
- **Đối tượng:** Bọ phấn, Nhện gié, Nhện đỏ, Nhện lông nhung
- **Liều lượng:** 0,3 – 0,5 lít/Ha (tùy cây)
- **Cách sử dụng:** Phun ướt đều tán lá', N'Isoprocarb 50% w/w; Chất mang, phụ gia: 50% w/w.', CAST(130000.00 AS Decimal(18, 2)), 60, 0, NULL, N'Lúa, Chè', 2, 14, CAST(0.50 AS Decimal(18, 2)), N'Trừ rầy, nhện. Phun ướt đều tán lá.', CAST(N'2026-03-07T07:44:10.6388439' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (153, N'sp0153', N'PYANCHOR 3EC', N'Bả diệt chuột (Mô tả gốc bị nhầm lẫn sang phân bón).', N'### Hướng dẫn sử dụng bả diệt chuột
- **Liều dùng:** 2 kg/ha
- **Cách dùng:** Rải 5–10 viên trước hang chuột hoặc đường đi', N'Brodifacoum 0,005% w/w; Phụ gia, bả mồi: cho đủ 100% w/w (Mô tả gốc là thuốc chuột nhưng tên là Pyanchor - thuốc cỏ. Giữ theo mô tả thuốc chuột).', CAST(310000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Chuột', 1, 0, CAST(2.00 AS Decimal(18, 2)), N'Bả diệt chuột. Cẩn thận với vật nuôi.', CAST(N'2026-03-07T07:44:10.6388443' AS DateTime2), NULL, 1, 4, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (154, N'sp0154', N'PYAN PLUS', N'Đặc trị các loại cỏ hại lúa như cỏ đuôi phụng, cỏ lồng vực, cỏ cháo chác, rau mác, cỏ xà bông, rau muống.', N'### Hướng dẫn sử dụng
- **Đối tượng:** Cỏ lồng vực, cỏ đuôi phụng
- **Cách sử dụng:** Phun đều khi cỏ ở giai đoạn 2–3 lá (7–10 ngày sau sạ)', N'Pyribenzoxim 50 g/l; Fenoxaprop 8 g/l; Dung môi, phụ gia: cho đủ 1 lít.', CAST(240000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 2, 0, CAST(1.00 AS Decimal(18, 2)), N'Trừ cỏ lồng vực. Vô nước ngập ruộng sau phun 24h.', CAST(N'2026-03-07T07:44:10.6388446' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (155, N'sp0155', N'PUSH 50WP', N'Đặc trị cỏ lồng vực và cỏ đuôi phụng trên ruộng lúa. An toàn cho lúa, hiệu quả cao khi phun sớm.', N'### Hướng dẫn sử dụng
- **Đối tượng:** Cỏ lồng vực, cỏ đuôi phụng
- **Cách sử dụng:** Phun đều khi cỏ ở giai đoạn 2–3 lá', N'Cyhalofop-butyl 300 g/l; Ethoxysulfuron 30 g/l; Phụ gia: 670 g/l.', CAST(310000.00 AS Decimal(18, 2)), 49, 0, NULL, N'Lúa', 2, 0, CAST(0.50 AS Decimal(18, 2)), N'An toàn cho lúa. Phun khi đất đủ ẩm.', CAST(N'2026-03-07T07:44:10.6388449' AS DateTime2), CAST(N'2026-03-19T04:33:54.3258672' AS DateTime2), 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (156, N'sp0156', N'PESLE SUPER 374SL', N'Thuốc trừ cỏ chuyên dùng cho ruộng lúa (Mô tả gốc bị nhầm).', N'### Hướng dẫn sử dụng
- **Đối tượng:** Rầy nâu
- **Liều lượng:** 1,0 kg/ha
- **Cách sử dụng:** Phun ướt đều tán lá khi rầy vừa xuất hiện', N'Đạm (N) 15% (min)... (Mô tả gốc bị sai công thức NPK).', CAST(130000.00 AS Decimal(18, 2)), 49, 0, NULL, N'Lúa', 2, 14, CAST(1.00 AS Decimal(18, 2)), N'Trị rầy nâu. Cách ly 14 ngày.', CAST(N'2026-03-07T07:44:10.6388453' AS DateTime2), CAST(N'2026-03-19T04:33:54.4005151' AS DateTime2), 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (157, N'sp0157', N'PATAXIM', N'Thuốc trừ cỏ chuyên dùng cho ruộng lúa.', N'### CÂY TRỒNG: Lúa
- **Đối tượng:** Các loại cỏ dại phổ biến trên ruộng lúa
- **Liều lượng:** 200 – 250 ml/ha
- **Cách sử dụng:** Phun hoặc trộn phân rải', N'Diuron 500 g/l; Dung môi và phụ gia: cho đủ 1 lít.', CAST(310000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 2, 0, CAST(0.25 AS Decimal(18, 2)), N'Trừ cỏ dại trên lúa. Điều chỉnh lượng nước phù hợp.', CAST(N'2026-03-07T07:44:10.6388456' AS DateTime2), NULL, 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (158, N'sp0158', N'ANSARONON 80WP', N'Đặc trị rầy nâu (Mô tả gốc bị nhầm).', N'### CÂY TRỒNG: Lúa
- **Đối tượng:** Cỏ dại phổ biến trên ruộng lúa
- **Liều lượng:** 200 – 250 ml/ha
- **Cách sử dụng:** Phun hoặc trộn phân rải', N'Brodifacoum 0,005% w/w... (Mô tả gốc bị nhầm lẫn giữa thuốc cỏ và thuốc chuột).', CAST(130000.00 AS Decimal(18, 2)), 49, 0, NULL, N'Lúa', 2, 0, CAST(0.25 AS Decimal(18, 2)), N'Trừ cỏ. Lưu ý giống lúa mẫn cảm.', CAST(N'2026-03-07T07:44:10.6388459' AS DateTime2), CAST(N'2026-03-18T23:38:34.3184867' AS DateTime2), 1, 3, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (159, N'sp0159', N'PYANCHOR 5 EC', N'Đặc trị rầy nâu trên cây lúa. Hiệu quả nhanh, diệt cả rầy trưởng thành và rầy non.', N'### HƯỚNG DẪN PHUN THUỐC TRỪ SÂU
- **Thời điểm phun:** Khi sâu non ở tuổi 1 – 2
- **Cách phun:** Phun ướt đều toàn cây', N'Hoạt chất Diuron 80% w/w (giả định); chất mang và phụ gia: 20% w/w.', CAST(130000.00 AS Decimal(18, 2)), 50, 0, NULL, N'Lúa', 2, 14, CAST(0.50 AS Decimal(18, 2)), N'Trừ sâu. Rửa sạch tay chân sau khi sử dụng.', CAST(N'2026-03-07T07:44:10.6388505' AS DateTime2), NULL, 1, 1, NULL, NULL)
INSERT [dbo].[Products] ([Id], [SKU], [Name], [Description], [UsageInstructions], [Formulation], [Price], [StockQuantity], [ExpirationDays], [ExpirationDate], [UsageTarget], [ToxicityLevel], [PreHarvestInterval], [DoseRate], [SafetyInformation], [CreatedAt], [UpdatedAt], [IsActive], [CategoryId], [CreatedByAdminId], [ManagedByStaffId]) VALUES (160, N'sp0160', N'PYANCHOR 3 EC', N'Đặc trị rầy nâu trên cây lúa. Hiệu quả nhanh, diệt cả rầy trưởng thành và rầy non.', N'### HƯỚNG DẪN SỬ DỤNG BẢ DIỆT CHUỘT
- **Liều dùng:** 2 kg/ha
- **Cách dùng:** Rải 5 – 10 viên bả tại nơi chuột thường xuyên xuất hiện', N'Isoprocarb 50% w/w; chất mang và phụ gia: 50% w/w', CAST(220000.00 AS Decimal(18, 2)), 49, 0, NULL, N'Chuột', 1, 0, CAST(2.00 AS Decimal(18, 2)), N'Bả diệt chuột. Kiểm tra hiệu quả sau 3-5 ngày.', CAST(N'2026-03-07T07:44:10.6388508' AS DateTime2), CAST(N'2026-03-23T08:02:15.8900374' AS DateTime2), 1, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Provinces] ON 

INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (1, N'An Giang', N'AG')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (2, N'Ba Ria - Vung Tau', N'BRVT')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (3, N'Bac Giang', N'BG')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (4, N'Bac Kan', N'BK')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (5, N'Bac Lieu', N'BL')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (6, N'Bac Ninh', N'BN')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (7, N'Ben Tre', N'BT')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (8, N'Binh Dinh', N'BDI')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (9, N'Binh Duong', N'BDU')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (10, N'Binh Phuoc', N'BPC')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (11, N'Binh Thuan', N'BTH')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (12, N'Ca Mau', N'CM')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (13, N'Can Tho', N'CT')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (14, N'Cao Bang', N'CB')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (15, N'Da Nang', N'DN')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (16, N'Dak Lak', N'DLK')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (17, N'Dak Nong', N'DNO')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (18, N'Dien Bien', N'DB')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (19, N'Dong Nai', N'DNA')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (20, N'Dong Thap', N'DT')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (21, N'Gia Lai', N'GL')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (22, N'Ha Giang', N'HGI')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (23, N'Ha Nam', N'HNA')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (24, N'Ha Noi', N'HN')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (25, N'Ha Tinh', N'HT')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (26, N'Hai Duong', N'HD')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (27, N'Hai Phong', N'HP')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (28, N'Hau Giang', N'HUG')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (29, N'Hoa Binh', N'HB')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (30, N'Hung Yen', N'HY')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (31, N'Khanh Hoa', N'KH')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (32, N'Kien Giang', N'KG')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (33, N'Kon Tum', N'KT')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (34, N'Lai Chau', N'LC')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (35, N'Lam Dong', N'LD')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (36, N'Lang Son', N'LS')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (37, N'Lao Cai', N'LCA')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (38, N'Long An', N'LA')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (39, N'Nam Dinh', N'ND')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (40, N'Nghe An', N'NA')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (41, N'Ninh Binh', N'NB')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (42, N'Ninh Thuan', N'NT')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (85, N'Phu Tho', N'PT')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (86, N'Phu Yen', N'PY')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (87, N'Quang Binh', N'QB')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (88, N'Quang Nam', N'QNA')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (89, N'Quang Ngai', N'QNG')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (90, N'Quang Ninh', N'QNH')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (91, N'Quang Tri', N'QT')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (92, N'Soc Trang', N'ST')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (93, N'Son La', N'SL')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (94, N'Tay Ninh', N'TN')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (95, N'Thai Binh', N'TB')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (96, N'Thai Nguyen', N'TNG')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (97, N'Thanh Hoa', N'TH')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (98, N'Thua Thien Hue', N'TTH')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (99, N'Tien Giang', N'TG')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (100, N'TP Ho Chi Minh', N'HCM')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (101, N'Tra Vinh', N'TV')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (102, N'Tuyen Quang', N'TQ')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (103, N'Vinh Long', N'VL')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (104, N'Vinh Phuc', N'VP')
INSERT [dbo].[Provinces] ([Id], [Name], [Code]) VALUES (105, N'Yen Bai', N'YB')
SET IDENTITY_INSERT [dbo].[Provinces] OFF
GO
SET IDENTITY_INSERT [dbo].[ReviewTags] ON 

INSERT [dbo].[ReviewTags] ([Id], [Label]) VALUES (1, N'Fast delivery')
INSERT [dbo].[ReviewTags] ([Id], [Label]) VALUES (2, N'Carefully packaged')
INSERT [dbo].[ReviewTags] ([Id], [Label]) VALUES (3, N'Genuine products')
INSERT [dbo].[ReviewTags] ([Id], [Label]) VALUES (4, N'Good results')
INSERT [dbo].[ReviewTags] ([Id], [Label]) VALUES (5, N'Enthusiastic advice')
SET IDENTITY_INSERT [dbo].[ReviewTags] OFF
GO
SET IDENTITY_INSERT [dbo].[Staffs] ON 

INSERT [dbo].[Staffs] ([Id], [FirstName], [LastName], [Email], [Phone], [Role], [AvatarUrl], [CreatedAt], [UpdatedAt], [IsDeleted], [PasswordHash], [CreatedByAdminId]) VALUES (1, N'Sample', N'Staff', N'staff@gmail.com', N'0987654321', N'Staff', NULL, CAST(N'2026-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2026-03-18T15:58:33.5592937' AS DateTime2), 0, N'$2a$11$HkAeUqNVTPhf5k137FANQuViMexXQUkfe6Aejh4dDF3YZD4QN9I5C', NULL)
INSERT [dbo].[Staffs] ([Id], [FirstName], [LastName], [Email], [Phone], [Role], [AvatarUrl], [CreatedAt], [UpdatedAt], [IsDeleted], [PasswordHash], [CreatedByAdminId]) VALUES (4, N'Trần', N'Thị Bò', N'tranthib@company.com', N'0912345678', N'Staff', NULL, CAST(N'2026-01-01T11:04:53.4400000' AS DateTime2), CAST(N'2026-01-01T23:33:13.0879576' AS DateTime2), 0, N'', NULL)
INSERT [dbo].[Staffs] ([Id], [FirstName], [LastName], [Email], [Phone], [Role], [AvatarUrl], [CreatedAt], [UpdatedAt], [IsDeleted], [PasswordHash], [CreatedByAdminId]) VALUES (5, N'Lê', N'Văn Cò', N'levanc@company.com', N'0923456789', N'Staff', NULL, CAST(N'2026-01-01T11:04:53.4400000' AS DateTime2), CAST(N'2026-01-01T12:03:26.7067813' AS DateTime2), 0, N'', NULL)
INSERT [dbo].[Staffs] ([Id], [FirstName], [LastName], [Email], [Phone], [Role], [AvatarUrl], [CreatedAt], [UpdatedAt], [IsDeleted], [PasswordHash], [CreatedByAdminId]) VALUES (6, N'Phạm', N'Thị D', N'phamthid@company.com', N'0934567895', N'Staff', NULL, CAST(N'2026-01-01T11:04:53.4400000' AS DateTime2), CAST(N'2026-01-27T15:01:58.3162406' AS DateTime2), 1, N'', NULL)
INSERT [dbo].[Staffs] ([Id], [FirstName], [LastName], [Email], [Phone], [Role], [AvatarUrl], [CreatedAt], [UpdatedAt], [IsDeleted], [PasswordHash], [CreatedByAdminId]) VALUES (17, N'Huỳnh Lê', N'Công Biên', N'hlcongbien2004@gmail.com', N'0912345678', N'Staff', NULL, CAST(N'2026-01-01T05:36:33.4628409' AS DateTime2), NULL, 1, N'$2a$11$WqvmdPQL.H1LNXDxd/uzZOKdEpGrD4VP7dmbY3Ubd6i1GnkCuzlqi', NULL)
INSERT [dbo].[Staffs] ([Id], [FirstName], [LastName], [Email], [Phone], [Role], [AvatarUrl], [CreatedAt], [UpdatedAt], [IsDeleted], [PasswordHash], [CreatedByAdminId]) VALUES (18, N'Phạm', N'Thị E', N'phamthiE@company.com', N'0934567898', N'Staff', NULL, CAST(N'2026-01-27T08:01:38.6040309' AS DateTime2), CAST(N'2026-03-18T15:53:40.7653632' AS DateTime2), 0, N'$2a$11$xcOcHZ/3hyWd4j4e7icHae/5ax8raoQCPhcVwYQL4h2SqgziOXzq.', NULL)
INSERT [dbo].[Staffs] ([Id], [FirstName], [LastName], [Email], [Phone], [Role], [AvatarUrl], [CreatedAt], [UpdatedAt], [IsDeleted], [PasswordHash], [CreatedByAdminId]) VALUES (19, N'Bienfgfg', N'Huynh', N'hlcongbien2004fgfgfg@gmail.com', N'0934567892', NULL, NULL, CAST(N'2026-01-27T16:32:16.1298576' AS DateTime2), CAST(N'2026-01-27T23:32:26.2759120' AS DateTime2), 1, N'$2a$11$6JHyuNe6f5Zr1GrRKuP4seu1R7.WJOO20Y8/fb7QvZjEYrY6X5QuO', NULL)
INSERT [dbo].[Staffs] ([Id], [FirstName], [LastName], [Email], [Phone], [Role], [AvatarUrl], [CreatedAt], [UpdatedAt], [IsDeleted], [PasswordHash], [CreatedByAdminId]) VALUES (31, N'Huỳnh Lê', N'Công Biên', N'hlcongbien2003@gmail.com', N'0934567895', N'Staff', NULL, CAST(N'2026-01-28T02:29:32.6211336' AS DateTime2), NULL, 0, N'$2a$12$xDgCvlpNpjOIw6uRhH8aKOK3snZ976kuUyIgVVTAJ1fIrUyjUtwZC', NULL)
INSERT [dbo].[Staffs] ([Id], [FirstName], [LastName], [Email], [Phone], [Role], [AvatarUrl], [CreatedAt], [UpdatedAt], [IsDeleted], [PasswordHash], [CreatedByAdminId]) VALUES (45, N'Bien', N'ye', N'jkg@gmail.com', N'0934567256', N'Staff', NULL, CAST(N'2026-03-01T06:09:17.0968870' AS DateTime2), NULL, 0, N'$2a$11$XVhFhNDuVJN0/pEzLCyxNeCMfJIS1ogzr9ku4yibZsoU35NC9sfRC', NULL)
SET IDENTITY_INSERT [dbo].[Staffs] OFF
GO
SET IDENTITY_INSERT [dbo].[UsageInstructions] ON 

INSERT [dbo].[UsageInstructions] ([Id], [ProductId], [CropId], [PestId], [DosageAmount], [DosageUnit], [WaterLiters], [AmountPerHectare]) VALUES (1, 4, 2, 2, CAST(8.00 AS Decimal(18, 2)), N'g', CAST(25.00 AS Decimal(18, 2)), CAST(150.00 AS Decimal(18, 2)))
INSERT [dbo].[UsageInstructions] ([Id], [ProductId], [CropId], [PestId], [DosageAmount], [DosageUnit], [WaterLiters], [AmountPerHectare]) VALUES (2, 6, 1, 1, CAST(40.00 AS Decimal(18, 2)), N'ml', CAST(25.00 AS Decimal(18, 2)), CAST(1800.00 AS Decimal(18, 2)))
INSERT [dbo].[UsageInstructions] ([Id], [ProductId], [CropId], [PestId], [DosageAmount], [DosageUnit], [WaterLiters], [AmountPerHectare]) VALUES (3, 7, 1, 1, CAST(50.00 AS Decimal(18, 2)), N'ml', CAST(25.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)))
INSERT [dbo].[UsageInstructions] ([Id], [ProductId], [CropId], [PestId], [DosageAmount], [DosageUnit], [WaterLiters], [AmountPerHectare]) VALUES (4, 2, 3, 3, CAST(100.00 AS Decimal(18, 2)), N'ml', CAST(25.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[UsageInstructions] ([Id], [ProductId], [CropId], [PestId], [DosageAmount], [DosageUnit], [WaterLiters], [AmountPerHectare]) VALUES (5, 5, 4, 4, CAST(45.00 AS Decimal(18, 2)), N'ml', CAST(25.00 AS Decimal(18, 2)), NULL)
SET IDENTITY_INSERT [dbo].[UsageInstructions] OFF
GO
SET IDENTITY_INSERT [dbo].[WarehouseLogs] ON 

INSERT [dbo].[WarehouseLogs] ([Id], [WarehouseId], [ProductId], [QuantityChange], [Note], [CreatedAt], [StaffId], [AdminId]) VALUES (1, 1, 160, 8, NULL, CAST(N'2026-02-28T09:12:54.3883136' AS DateTime2), NULL, NULL)
INSERT [dbo].[WarehouseLogs] ([Id], [WarehouseId], [ProductId], [QuantityChange], [Note], [CreatedAt], [StaffId], [AdminId]) VALUES (2, 1, 152, 5, NULL, CAST(N'2026-02-28T09:12:54.5289042' AS DateTime2), NULL, NULL)
INSERT [dbo].[WarehouseLogs] ([Id], [WarehouseId], [ProductId], [QuantityChange], [Note], [CreatedAt], [StaffId], [AdminId]) VALUES (3, 1, 160, 50, NULL, CAST(N'2026-02-28T09:16:59.8304555' AS DateTime2), NULL, NULL)
INSERT [dbo].[WarehouseLogs] ([Id], [WarehouseId], [ProductId], [QuantityChange], [Note], [CreatedAt], [StaffId], [AdminId]) VALUES (4, 1, 152, 55, N'Biên test', CAST(N'2026-02-28T09:18:32.6129763' AS DateTime2), NULL, NULL)
INSERT [dbo].[WarehouseLogs] ([Id], [WarehouseId], [ProductId], [QuantityChange], [Note], [CreatedAt], [StaffId], [AdminId]) VALUES (5, 1, 160, 5, NULL, CAST(N'2026-02-28T09:19:09.4826633' AS DateTime2), NULL, NULL)
INSERT [dbo].[WarehouseLogs] ([Id], [WarehouseId], [ProductId], [QuantityChange], [Note], [CreatedAt], [StaffId], [AdminId]) VALUES (6, 1, 45, 7, N'Biên test hehehe', CAST(N'2026-03-05T02:12:38.2795835' AS DateTime2), NULL, NULL)
INSERT [dbo].[WarehouseLogs] ([Id], [WarehouseId], [ProductId], [QuantityChange], [Note], [CreatedAt], [StaffId], [AdminId]) VALUES (7, 1, 152, 5, N'BienTest', CAST(N'2026-03-15T07:39:31.1595476' AS DateTime2), NULL, NULL)
INSERT [dbo].[WarehouseLogs] ([Id], [WarehouseId], [ProductId], [QuantityChange], [Note], [CreatedAt], [StaffId], [AdminId]) VALUES (8, 1, 151, 7, N'BienTest', CAST(N'2026-03-15T07:39:31.2455386' AS DateTime2), NULL, NULL)
SET IDENTITY_INSERT [dbo].[WarehouseLogs] OFF
GO
INSERT [dbo].[WarehouseProducts] ([WarehouseId], [ProductId], [Quantity]) VALUES (1, 45, 7)
INSERT [dbo].[WarehouseProducts] ([WarehouseId], [ProductId], [Quantity]) VALUES (1, 151, 7)
INSERT [dbo].[WarehouseProducts] ([WarehouseId], [ProductId], [Quantity]) VALUES (1, 152, 65)
INSERT [dbo].[WarehouseProducts] ([WarehouseId], [ProductId], [Quantity]) VALUES (1, 160, 63)
GO
SET IDENTITY_INSERT [dbo].[Warehouses] ON 

INSERT [dbo].[Warehouses] ([Id], [Name], [Location], [CreatedAt], [UpdatedAt], [CreatedByAdminId], [ManagedByStaffId]) VALUES (1, N'Default Warehouse', N'Main', CAST(N'2026-02-28T09:12:23.6375127' AS DateTime2), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Warehouses] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Admins_Email]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Admins_Email] ON [dbo].[Admins]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ArticleImages_ArticleId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_ArticleImages_ArticleId] ON [dbo].[ArticleImages]
(
	[ArticleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Articles_CreatedByAdminId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Articles_CreatedByAdminId] ON [dbo].[Articles]
(
	[CreatedByAdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Articles_ManagedByStaffId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Articles_ManagedByStaffId] ON [dbo].[Articles]
(
	[ManagedByStaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CartItems_CartId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_CartItems_CartId] ON [dbo].[CartItems]
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CartItems_ProductId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_CartItems_ProductId] ON [dbo].[CartItems]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Carts_CustomerId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Carts_CustomerId] ON [dbo].[Carts]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Categories_CreatedByAdminId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Categories_CreatedByAdminId] ON [dbo].[Categories]
(
	[CreatedByAdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Categories_ManagedByStaffId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Categories_ManagedByStaffId] ON [dbo].[Categories]
(
	[ManagedByStaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ChemicalConflicts_ChemicalAId_ChemicalBId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ChemicalConflicts_ChemicalAId_ChemicalBId] ON [dbo].[ChemicalConflicts]
(
	[ChemicalAId] ASC,
	[ChemicalBId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ChemicalConflicts_ChemicalBId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_ChemicalConflicts_ChemicalBId] ON [dbo].[ChemicalConflicts]
(
	[ChemicalBId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ChemicalProfiles_CreatedByAdminId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_ChemicalProfiles_CreatedByAdminId] ON [dbo].[ChemicalProfiles]
(
	[CreatedByAdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ChemicalProfiles_ManagedByStaffId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_ChemicalProfiles_ManagedByStaffId] ON [dbo].[ChemicalProfiles]
(
	[ManagedByStaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customers_DistrictId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customers_DistrictId] ON [dbo].[Customers]
(
	[DistrictId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customers_ManagedByStaffId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Customers_ManagedByStaffId] ON [dbo].[Customers]
(
	[ManagedByStaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Discounts_CreatedByAdminId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Discounts_CreatedByAdminId] ON [dbo].[Discounts]
(
	[CreatedByAdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Discounts_ProductId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Discounts_ProductId] ON [dbo].[Discounts]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Districts_ProvinceId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Districts_ProvinceId] ON [dbo].[Districts]
(
	[ProvinceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FeedbackImages_FeedbackId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_FeedbackImages_FeedbackId] ON [dbo].[FeedbackImages]
(
	[FeedbackId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FeedbackReplies_FeedbackId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_FeedbackReplies_FeedbackId] ON [dbo].[FeedbackReplies]
(
	[FeedbackId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FeedbackReplies_StaffId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_FeedbackReplies_StaffId] ON [dbo].[FeedbackReplies]
(
	[StaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_FeedbackReviewTags_ReviewTagId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_FeedbackReviewTags_ReviewTagId] ON [dbo].[FeedbackReviewTags]
(
	[ReviewTagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Feedbacks_CustomerId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Feedbacks_CustomerId] ON [dbo].[Feedbacks]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Feedbacks_OrderId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Feedbacks_OrderId] ON [dbo].[Feedbacks]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Feedbacks_ProductId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Feedbacks_ProductId] ON [dbo].[Feedbacks]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderDetails_ProductId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_OrderDetails_ProductId] ON [dbo].[OrderDetails]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_CustomerId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_CustomerId] ON [dbo].[Orders]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Orders_ManagedByStaffId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Orders_ManagedByStaffId] ON [dbo].[Orders]
(
	[ManagedByStaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Payments_OrderId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Payments_OrderId] ON [dbo].[Payments]
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Payments_TransactionId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Payments_TransactionId] ON [dbo].[Payments]
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductChemicals_ChemicalProfileId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductChemicals_ChemicalProfileId] ON [dbo].[ProductChemicals]
(
	[ChemicalProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductImages_ProductId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProductImages_ProductId] ON [dbo].[ProductImages]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_CategoryId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_CategoryId] ON [dbo].[Products]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_CreatedByAdminId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_CreatedByAdminId] ON [dbo].[Products]
(
	[CreatedByAdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_ManagedByStaffId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Products_ManagedByStaffId] ON [dbo].[Products]
(
	[ManagedByStaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Staffs_CreatedByAdminId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Staffs_CreatedByAdminId] ON [dbo].[Staffs]
(
	[CreatedByAdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Staffs_Email]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Staffs_Email] ON [dbo].[Staffs]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UsageInstructions_CropId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_UsageInstructions_CropId] ON [dbo].[UsageInstructions]
(
	[CropId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UsageInstructions_PestId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_UsageInstructions_PestId] ON [dbo].[UsageInstructions]
(
	[PestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UsageInstructions_ProductId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_UsageInstructions_ProductId] ON [dbo].[UsageInstructions]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Wards_DistrictId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Wards_DistrictId] ON [dbo].[Wards]
(
	[DistrictId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_WarehouseLogs_AdminId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_WarehouseLogs_AdminId] ON [dbo].[WarehouseLogs]
(
	[AdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_WarehouseLogs_ProductId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_WarehouseLogs_ProductId] ON [dbo].[WarehouseLogs]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_WarehouseLogs_StaffId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_WarehouseLogs_StaffId] ON [dbo].[WarehouseLogs]
(
	[StaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_WarehouseLogs_WarehouseId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_WarehouseLogs_WarehouseId] ON [dbo].[WarehouseLogs]
(
	[WarehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_WarehouseProducts_ProductId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_WarehouseProducts_ProductId] ON [dbo].[WarehouseProducts]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Warehouses_CreatedByAdminId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Warehouses_CreatedByAdminId] ON [dbo].[Warehouses]
(
	[CreatedByAdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Warehouses_ManagedByStaffId]    Script Date: 5/11/2026 3:30:15 PM ******/
CREATE NONCLUSTERED INDEX [IX_Warehouses_ManagedByStaffId] ON [dbo].[Warehouses]
(
	[ManagedByStaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (CONVERT([bit],(0))) FOR [IsRefunded]
GO
ALTER TABLE [dbo].[Staffs] ADD  DEFAULT (N'') FOR [PasswordHash]
GO
ALTER TABLE [dbo].[ArticleImages]  WITH CHECK ADD  CONSTRAINT [FK_ArticleImages_Articles_ArticleId] FOREIGN KEY([ArticleId])
REFERENCES [dbo].[Articles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ArticleImages] CHECK CONSTRAINT [FK_ArticleImages_Articles_ArticleId]
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [FK_Articles_Admins_CreatedByAdminId] FOREIGN KEY([CreatedByAdminId])
REFERENCES [dbo].[Admins] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [FK_Articles_Admins_CreatedByAdminId]
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [FK_Articles_Staffs_ManagedByStaffId] FOREIGN KEY([ManagedByStaffId])
REFERENCES [dbo].[Staffs] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [FK_Articles_Staffs_ManagedByStaffId]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Carts_CartId] FOREIGN KEY([CartId])
REFERENCES [dbo].[Carts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Carts_CartId]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Products_ProductId]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Customers_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Customers_CustomerId]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Admins_CreatedByAdminId] FOREIGN KEY([CreatedByAdminId])
REFERENCES [dbo].[Admins] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Admins_CreatedByAdminId]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Staffs_ManagedByStaffId] FOREIGN KEY([ManagedByStaffId])
REFERENCES [dbo].[Staffs] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Staffs_ManagedByStaffId]
GO
ALTER TABLE [dbo].[ChemicalConflicts]  WITH CHECK ADD  CONSTRAINT [FK_ChemicalConflicts_ChemicalProfiles_ChemicalAId] FOREIGN KEY([ChemicalAId])
REFERENCES [dbo].[ChemicalProfiles] ([Id])
GO
ALTER TABLE [dbo].[ChemicalConflicts] CHECK CONSTRAINT [FK_ChemicalConflicts_ChemicalProfiles_ChemicalAId]
GO
ALTER TABLE [dbo].[ChemicalConflicts]  WITH CHECK ADD  CONSTRAINT [FK_ChemicalConflicts_ChemicalProfiles_ChemicalBId] FOREIGN KEY([ChemicalBId])
REFERENCES [dbo].[ChemicalProfiles] ([Id])
GO
ALTER TABLE [dbo].[ChemicalConflicts] CHECK CONSTRAINT [FK_ChemicalConflicts_ChemicalProfiles_ChemicalBId]
GO
ALTER TABLE [dbo].[ChemicalProfiles]  WITH CHECK ADD  CONSTRAINT [FK_ChemicalProfiles_Admins_CreatedByAdminId] FOREIGN KEY([CreatedByAdminId])
REFERENCES [dbo].[Admins] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[ChemicalProfiles] CHECK CONSTRAINT [FK_ChemicalProfiles_Admins_CreatedByAdminId]
GO
ALTER TABLE [dbo].[ChemicalProfiles]  WITH CHECK ADD  CONSTRAINT [FK_ChemicalProfiles_Staffs_ManagedByStaffId] FOREIGN KEY([ManagedByStaffId])
REFERENCES [dbo].[Staffs] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[ChemicalProfiles] CHECK CONSTRAINT [FK_ChemicalProfiles_Staffs_ManagedByStaffId]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Districts_DistrictId] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[Districts] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Districts_DistrictId]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Staffs_ManagedByStaffId] FOREIGN KEY([ManagedByStaffId])
REFERENCES [dbo].[Staffs] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Staffs_ManagedByStaffId]
GO
ALTER TABLE [dbo].[Discounts]  WITH CHECK ADD  CONSTRAINT [FK_Discounts_Admins_CreatedByAdminId] FOREIGN KEY([CreatedByAdminId])
REFERENCES [dbo].[Admins] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Discounts] CHECK CONSTRAINT [FK_Discounts_Admins_CreatedByAdminId]
GO
ALTER TABLE [dbo].[Discounts]  WITH CHECK ADD  CONSTRAINT [FK_Discounts_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Discounts] CHECK CONSTRAINT [FK_Discounts_Products_ProductId]
GO
ALTER TABLE [dbo].[Districts]  WITH CHECK ADD  CONSTRAINT [FK_Districts_Provinces_ProvinceId] FOREIGN KEY([ProvinceId])
REFERENCES [dbo].[Provinces] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Districts] CHECK CONSTRAINT [FK_Districts_Provinces_ProvinceId]
GO
ALTER TABLE [dbo].[FeedbackImages]  WITH CHECK ADD  CONSTRAINT [FK_FeedbackImages_Feedbacks_FeedbackId] FOREIGN KEY([FeedbackId])
REFERENCES [dbo].[Feedbacks] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FeedbackImages] CHECK CONSTRAINT [FK_FeedbackImages_Feedbacks_FeedbackId]
GO
ALTER TABLE [dbo].[FeedbackReplies]  WITH CHECK ADD  CONSTRAINT [FK_FeedbackReplies_Feedbacks_FeedbackId] FOREIGN KEY([FeedbackId])
REFERENCES [dbo].[Feedbacks] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FeedbackReplies] CHECK CONSTRAINT [FK_FeedbackReplies_Feedbacks_FeedbackId]
GO
ALTER TABLE [dbo].[FeedbackReplies]  WITH CHECK ADD  CONSTRAINT [FK_FeedbackReplies_Staffs_StaffId] FOREIGN KEY([StaffId])
REFERENCES [dbo].[Staffs] ([Id])
GO
ALTER TABLE [dbo].[FeedbackReplies] CHECK CONSTRAINT [FK_FeedbackReplies_Staffs_StaffId]
GO
ALTER TABLE [dbo].[FeedbackReviewTags]  WITH CHECK ADD  CONSTRAINT [FK_FeedbackReviewTags_Feedbacks_FeedbackId] FOREIGN KEY([FeedbackId])
REFERENCES [dbo].[Feedbacks] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FeedbackReviewTags] CHECK CONSTRAINT [FK_FeedbackReviewTags_Feedbacks_FeedbackId]
GO
ALTER TABLE [dbo].[FeedbackReviewTags]  WITH CHECK ADD  CONSTRAINT [FK_FeedbackReviewTags_ReviewTags_ReviewTagId] FOREIGN KEY([ReviewTagId])
REFERENCES [dbo].[ReviewTags] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FeedbackReviewTags] CHECK CONSTRAINT [FK_FeedbackReviewTags_ReviewTags_ReviewTagId]
GO
ALTER TABLE [dbo].[Feedbacks]  WITH CHECK ADD  CONSTRAINT [FK_Feedbacks_Customers_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Feedbacks] CHECK CONSTRAINT [FK_Feedbacks_Customers_CustomerId]
GO
ALTER TABLE [dbo].[Feedbacks]  WITH CHECK ADD  CONSTRAINT [FK_Feedbacks_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[Feedbacks] CHECK CONSTRAINT [FK_Feedbacks_Orders_OrderId]
GO
ALTER TABLE [dbo].[Feedbacks]  WITH CHECK ADD  CONSTRAINT [FK_Feedbacks_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Feedbacks] CHECK CONSTRAINT [FK_Feedbacks_Products_ProductId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders_OrderId]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products_ProductId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers_CustomerId]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Staffs_ManagedByStaffId] FOREIGN KEY([ManagedByStaffId])
REFERENCES [dbo].[Staffs] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Staffs_ManagedByStaffId]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Orders_OrderId] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Orders_OrderId]
GO
ALTER TABLE [dbo].[ProductChemicals]  WITH CHECK ADD  CONSTRAINT [FK_ProductChemicals_ChemicalProfiles_ChemicalProfileId] FOREIGN KEY([ChemicalProfileId])
REFERENCES [dbo].[ChemicalProfiles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductChemicals] CHECK CONSTRAINT [FK_ProductChemicals_ChemicalProfiles_ChemicalProfileId]
GO
ALTER TABLE [dbo].[ProductChemicals]  WITH CHECK ADD  CONSTRAINT [FK_ProductChemicals_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductChemicals] CHECK CONSTRAINT [FK_ProductChemicals_Products_ProductId]
GO
ALTER TABLE [dbo].[ProductImages]  WITH CHECK ADD  CONSTRAINT [FK_ProductImages_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductImages] CHECK CONSTRAINT [FK_ProductImages_Products_ProductId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Admins_CreatedByAdminId] FOREIGN KEY([CreatedByAdminId])
REFERENCES [dbo].[Admins] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Admins_CreatedByAdminId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories_CategoryId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Staffs_ManagedByStaffId] FOREIGN KEY([ManagedByStaffId])
REFERENCES [dbo].[Staffs] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Staffs_ManagedByStaffId]
GO
ALTER TABLE [dbo].[Staffs]  WITH CHECK ADD  CONSTRAINT [FK_Staffs_Admins_CreatedByAdminId] FOREIGN KEY([CreatedByAdminId])
REFERENCES [dbo].[Admins] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Staffs] CHECK CONSTRAINT [FK_Staffs_Admins_CreatedByAdminId]
GO
ALTER TABLE [dbo].[UsageInstructions]  WITH CHECK ADD  CONSTRAINT [FK_UsageInstructions_Crops_CropId] FOREIGN KEY([CropId])
REFERENCES [dbo].[Crops] ([Id])
GO
ALTER TABLE [dbo].[UsageInstructions] CHECK CONSTRAINT [FK_UsageInstructions_Crops_CropId]
GO
ALTER TABLE [dbo].[UsageInstructions]  WITH CHECK ADD  CONSTRAINT [FK_UsageInstructions_Pests_PestId] FOREIGN KEY([PestId])
REFERENCES [dbo].[Pests] ([Id])
GO
ALTER TABLE [dbo].[UsageInstructions] CHECK CONSTRAINT [FK_UsageInstructions_Pests_PestId]
GO
ALTER TABLE [dbo].[UsageInstructions]  WITH CHECK ADD  CONSTRAINT [FK_UsageInstructions_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UsageInstructions] CHECK CONSTRAINT [FK_UsageInstructions_Products_ProductId]
GO
ALTER TABLE [dbo].[Wards]  WITH CHECK ADD  CONSTRAINT [FK_Wards_Districts_DistrictId] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[Districts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Wards] CHECK CONSTRAINT [FK_Wards_Districts_DistrictId]
GO
ALTER TABLE [dbo].[WarehouseLogs]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseLogs_Admins_AdminId] FOREIGN KEY([AdminId])
REFERENCES [dbo].[Admins] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[WarehouseLogs] CHECK CONSTRAINT [FK_WarehouseLogs_Admins_AdminId]
GO
ALTER TABLE [dbo].[WarehouseLogs]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseLogs_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[WarehouseLogs] CHECK CONSTRAINT [FK_WarehouseLogs_Products_ProductId]
GO
ALTER TABLE [dbo].[WarehouseLogs]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseLogs_Staffs_StaffId] FOREIGN KEY([StaffId])
REFERENCES [dbo].[Staffs] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[WarehouseLogs] CHECK CONSTRAINT [FK_WarehouseLogs_Staffs_StaffId]
GO
ALTER TABLE [dbo].[WarehouseLogs]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseLogs_Warehouses_WarehouseId] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[Warehouses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WarehouseLogs] CHECK CONSTRAINT [FK_WarehouseLogs_Warehouses_WarehouseId]
GO
ALTER TABLE [dbo].[WarehouseProducts]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseProducts_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[WarehouseProducts] CHECK CONSTRAINT [FK_WarehouseProducts_Products_ProductId]
GO
ALTER TABLE [dbo].[WarehouseProducts]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseProducts_Warehouses_WarehouseId] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[Warehouses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WarehouseProducts] CHECK CONSTRAINT [FK_WarehouseProducts_Warehouses_WarehouseId]
GO
ALTER TABLE [dbo].[Warehouses]  WITH CHECK ADD  CONSTRAINT [FK_Warehouses_Admins_CreatedByAdminId] FOREIGN KEY([CreatedByAdminId])
REFERENCES [dbo].[Admins] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Warehouses] CHECK CONSTRAINT [FK_Warehouses_Admins_CreatedByAdminId]
GO
ALTER TABLE [dbo].[Warehouses]  WITH CHECK ADD  CONSTRAINT [FK_Warehouses_Staffs_ManagedByStaffId] FOREIGN KEY([ManagedByStaffId])
REFERENCES [dbo].[Staffs] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Warehouses] CHECK CONSTRAINT [FK_Warehouses_Staffs_ManagedByStaffId]
GO
USE [master]
GO
ALTER DATABASE [BioPestControlDb] SET  READ_WRITE 
GO
