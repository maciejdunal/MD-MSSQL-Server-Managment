USE [Wypozyczalnia_Gier_komputerowych]
GO
/****** Object:  User [test]    Script Date: 2/22/2021 9:05:13 PM ******/
CREATE USER [test] FOR LOGIN [test] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [test]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [test]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [test]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [test]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [test]
GO
ALTER ROLE [db_datareader] ADD MEMBER [test]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [test]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [test]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [test]
GO
/****** Object:  Schema [Project]    Script Date: 2/22/2021 9:05:13 PM ******/
CREATE SCHEMA [Project]
GO
/****** Object:  Table [dbo].[Gry]    Script Date: 2/22/2021 9:05:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gry](
	[ID_gry] [int] NOT NULL,
	[Nazwa] [nchar](50) NOT NULL,
	[Kategoria] [nchar](50) NOT NULL,
	[Kategoria_wiekowa] [nchar](50) NOT NULL,
	[Data_wydania] [nchar](10) NOT NULL,
	[Cena_dzien] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_gry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Klienci]    Script Date: 2/22/2021 9:05:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Klienci](
	[ID_klienta] [int] NOT NULL,
	[Nazwisko] [nchar](50) NOT NULL,
	[Imie] [nchar](50) NOT NULL,
	[Adres] [nchar](50) NOT NULL,
	[Kod_pocztowy] [nchar](10) NOT NULL,
	[Data_urodzenia] [date] NOT NULL,
	[Numer_DO] [nchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_klienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pracownicy]    Script Date: 2/22/2021 9:05:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pracownicy](
	[ID_pracownika] [int] NOT NULL,
	[Imie] [nchar](50) NOT NULL,
	[Nazwisko] [nchar](50) NOT NULL,
	[Data_urodzenia] [date] NOT NULL,
	[Adres] [nchar](50) NOT NULL,
	[Stanowisko] [nchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_pracownika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wypozyczenia]    Script Date: 2/22/2021 9:05:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wypozyczenia](
	[ID_wypozyczenia] [int] NOT NULL,
	[ID_Gry] [int] NOT NULL,
	[ID_pracownika] [int] NOT NULL,
	[ID_klienta] [int] NOT NULL,
	[Data_wypozyczenia] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_wypozyczenia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zwroty]    Script Date: 2/22/2021 9:05:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zwroty](
	[ID_wypozyczenia] [int] NOT NULL,
	[ID_pracownika] [int] NOT NULL,
	[data_zwrotu] [date] NOT NULL,
	[doplaty] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_wypozyczenia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Wypozyczenia]  WITH CHECK ADD  CONSTRAINT [RelacjaDoKlient] FOREIGN KEY([ID_klienta])
REFERENCES [dbo].[Klienci] ([ID_klienta])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Wypozyczenia] CHECK CONSTRAINT [RelacjaDoKlient]
GO
ALTER TABLE [dbo].[Wypozyczenia]  WITH CHECK ADD  CONSTRAINT [RelacjaGry] FOREIGN KEY([ID_Gry])
REFERENCES [dbo].[Gry] ([ID_gry])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Wypozyczenia] CHECK CONSTRAINT [RelacjaGry]
GO
ALTER TABLE [dbo].[Wypozyczenia]  WITH CHECK ADD  CONSTRAINT [RelacjaPracownicy] FOREIGN KEY([ID_pracownika])
REFERENCES [dbo].[Pracownicy] ([ID_pracownika])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Wypozyczenia] CHECK CONSTRAINT [RelacjaPracownicy]
GO
ALTER TABLE [dbo].[Zwroty]  WITH CHECK ADD  CONSTRAINT [Relacjapracownicy2] FOREIGN KEY([ID_pracownika])
REFERENCES [dbo].[Pracownicy] ([ID_pracownika])
GO
ALTER TABLE [dbo].[Zwroty] CHECK CONSTRAINT [Relacjapracownicy2]
GO
ALTER TABLE [dbo].[Zwroty]  WITH CHECK ADD  CONSTRAINT [RelacjaWypozyczenia] FOREIGN KEY([ID_wypozyczenia])
REFERENCES [dbo].[Wypozyczenia] ([ID_wypozyczenia])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Zwroty] CHECK CONSTRAINT [RelacjaWypozyczenia]
GO
