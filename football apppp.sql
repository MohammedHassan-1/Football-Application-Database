create schema football ;
create table customers (
CustomerID INT PRIMARY KEY IDENTITY(1,1),
first_name varchar(100)not null,
last_name varchar(100)not null,
email varchar (100) unique not null,
Phone VARCHAR(15) unique NOT NULL,
address varchar (100) not null,	
Gender	VARCHAR(10)	CHECK(Gender IN ('Male', 'Female')),
DateOfBirth	DATE ,
);
CREATE TABLE staff (
StaffID INT PRIMARY KEY IDENTITY(1,1),
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE NOT NULL,
Phone VARCHAR(15) UNIQUE NOT NULL,
Username VARCHAR(50) UNIQUE NOT NULL,
Password VARCHAR(255) NOT NULL
);

CREATE TABLE Stadiums (
StadiumID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(100) NOT NULL,
Location VARCHAR(100) NOT NULL,
Capacity INT CHECK (Capacity > 0),
City VARCHAR(100) NOT NULL
);
CREATE TABLE Teams (
TeamID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(100) UNIQUE NOT NULL,
Coach VARCHAR(100) NULL,
Logo VARCHAR(100) NULL,
StadiumID INT NOT NULL,
FoundedYear INT CHECK (FoundedYear >= 1800),
FOREIGN KEY (StadiumID) REFERENCES Stadiums(StadiumID)
);
CREATE TABLE Tickets (
TicketID INT PRIMARY KEY IDENTITY(1,1),
MatchID INT NOT NULL,
CustomerID INT NOT NULL,
SeatNumber VARCHAR(10) NOT NULL,
Price DECIMAL(10,2) CHECK (Price >= 0),
BookingDate DATE ,
PaymentStatus VARCHAR(20) CHECK (PaymentStatus IN ('Paid', 'Pending')),
TicketType VARCHAR(20) CHECK (TicketType IN ('VIP', 'Regular')),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE Payments (
PaymentID INT PRIMARY KEY IDENTITY(1,1),
TicketID INT NOT NULL,
CustomerID INT NOT NULL,
Amount DECIMAL(10,2) NOT NULL CHECK (Amount >= 0),
PaymentMethod VARCHAR(50) NOT NULL,
PaymentDate DATETIME ,
Status VARCHAR(20) CHECK (Status IN ('Success', 'Failed', 'Pending')),
FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Matches (
MatchID INT PRIMARY KEY IDENTITY(1,1),
HomeTeam INT NOT NULL,
AwayTeam INT NOT NULL,
MatchDate DATE NOT NULL,
MatchTime TIME NOT NULL,
StadiumID INT NOT NULL,
Status VARCHAR(20) DEFAULT 'Scheduled',
FOREIGN KEY (HomeTeam) REFERENCES Teams(TeamID),
FOREIGN KEY (AwayTeam) REFERENCES Teams(TeamID),
FOREIGN KEY (StadiumID) REFERENCES Stadiums(StadiumID)
);
CREATE TABLE Reservations (
ReservationID INT PRIMARY KEY IDENTITY(1,1),
CustomerID INT NOT NULL,
TicketID INT NOT NULL,
ReservationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
Status VARCHAR(20) CHECK (Status IN ('Confirmed', 'Cancelled')),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID)
);
CREATE TABLE Seats (
SeatID INT PRIMARY KEY IDENTITY(1,1),
StadiumID INT NOT NULL,
Section VARCHAR(20) NOT NULL,
Rows VARCHAR(10) NOT NULL,
Number VARCHAR(10) NOT NULL,
SeatType VARCHAR(20) CHECK (SeatType IN ('VIP', 'Regular')),
FOREIGN KEY (StadiumID) REFERENCES Stadiums(StadiumID)
);
CREATE TABLE UserAccounts (
UserID  INT PRIMARY KEY IDENTITY(1,1),
Username VARCHAR(50) UNIQUE NOT NULL,
PasswordHash VARCHAR(255) NOT NULL
);
CREATE TABLE MatchOfficials (
OfficialID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(100) NOT NULL,
Nationality VARCHAR(50) NOT NULL,
AssignedMatchID INT NULL,
FOREIGN KEY (AssignedMatchID) REFERENCES Matches(MatchID)
);
CREATE TABLE Players (
PlayerID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(100) NOT NULL,
TeamID INT NOT NULL,
Position VARCHAR(30) NOT NULL,
JerseyNumber INT CHECK (JerseyNumber >= 1 AND JerseyNumber <= 99),
DateOfBirth DATE NOT NULL,
Nationality VARCHAR(50) NOT NULL,
FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);
CREATE TABLE Seasons (
SeasonID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(100) NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL, 
Type VARCHAR(20) CHECK (Type IN ('League', 'Cup', 'Friendly'))
);
CREATE TABLE MatchStatistics (
StatID INT PRIMARY KEY IDENTITY(1,1),
MatchID INT NOT NULL,
TeamID INT NOT NULL,
Possession DECIMAL(5,2) CHECK (Possession BETWEEN 0 AND 100),
ShotsOnTarget INT CHECK (ShotsOnTarget >= 0),
Fouls INT CHECK (Fouls >= 0),
YellowCards INT CHECK (YellowCards >= 0),
RedCards INT CHECK (RedCards >= 0),
Goals INT CHECK (Goals >= 0),
FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);
CREATE TABLE Reviews (
ReviewID INT PRIMARY KEY IDENTITY(1,1),
CustomerID INT NOT NULL,
MatchID INT NOT NULL,
Rating INT CHECK (Rating BETWEEN 1 AND 5),
Comment TEXT NULL,
Date DATETIME, 
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (MatchID) REFERENCES Matches(MatchID)
);
CREATE TABLE Notifications (
NotificationID INT PRIMARY KEY IDENTITY(1,1),
UserID INT NOT NULL,
Message TEXT NOT NULL,
Date DATETIME DEFAULT CURRENT_TIMESTAMP,
Status VARCHAR(10) CHECK (Status IN ('Read', 'Unread')) DEFAULT 'Unread',  
FOREIGN KEY (UserID) REFERENCES UserAccounts(UserID)
);
CREATE TABLE Promotions (
PromoID INT PRIMARY KEY IDENTITY(1,1),
Code VARCHAR(20) UNIQUE NOT NULL,
DiscountPercent DECIMAL(5,2) CHECK (DiscountPercent BETWEEN 0 AND 100),
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
UsageLimit INT CHECK (UsageLimit >= 0) NULL
);
create table refees(
refee_id INT PRIMARY KEY IDENTITY(1,1),
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE NOT NULL,
refee_salary  DECIMAL(6,2) CHECK (refee_salary BETWEEN 5000 AND 10000)
);
INSERT INTO UserAccounts (Username, PasswordHash) VALUES
('user1', 'pass1'), ('user2', 'pass2'), ('user3', 'pass3'), ('user4', 'pass4'),
('user5', 'pass5'), ('user6', 'pass6'), ('user7', 'pass7'), ('user8', 'pass8'),
('user9', 'pass9'), ('user10', 'pass10'), ('user11', 'pass11'), ('user12', 'pass12'),
('user13', 'pass13'), ('user14', 'pass14'), ('user15', 'pass15'), ('user16', 'pass16'),
('user17', 'pass17'), ('user18', 'pass18'), ('user19', 'pass19'), ('user20', 'pass20');
INSERT INTO Customers (first_name, last_name, email, Phone, address, Gender, DateOfBirth) VALUES
('John', 'Smith', 'john.smith@gmail.com', '5551230001', '123 Main St, London', 'Male', '1990-05-14'),
('Emma', 'Johnson', 'emma.johnson@yahoo.com', '5551230002', '45 Queen Ave, Birmingham', 'Female', '1992-08-22'),
('Liam', 'Williams', 'liam.williams@outlook.com', '5551230003', '76 King St, Liverpool', 'Male', '1988-01-10'),
('Olivia', 'Brown', 'olivia.brown@gmail.com', '5551230004', '34 Hill Rd, Manchester', 'Female', '1995-03-30'),
('Noah', 'Jones', 'noah.jones@gmail.com', '5551230005', '98 Ocean Dr, Leeds', 'Male', '1993-12-12'),
('Ava', 'Taylor', 'ava.taylor@hotmail.com', '5551230006', '12 Bridge Ln, Sheffield', 'Female', '1991-06-15'),
('William', 'Davies', 'will.davies@aol.com', '5551230007', '102 Rose St, Newcastle', 'Male', '1989-04-04'),
('Sophia', 'Evans', 'sophia.evans@gmail.com', '5551230008', '87 Park Ave, Nottingham', 'Female', '1996-11-19'),
('James', 'Thomas', 'james.thomas@mail.com', '5551230009', '63 Church St, Southampton', 'Male', '1994-02-23'),
('Isabella', 'Roberts', 'bella.roberts@gmail.com', '5551230010', '50 River Rd, Brighton', 'Female', '1997-10-05'),
('Benjamin', 'Walker', 'ben.walker@yahoo.com', '5551230011', '29 Forest Dr, Bristol', 'Male', '1987-09-16'),
('Mia', 'White', 'mia.white@outlook.com', '5551230012', '73 City Rd, Leicester', 'Female', '1990-07-07'),
('Elijah', 'Green', 'elijah.green@gmail.com', '5551230013', '22 Castle St, Oxford', 'Male', '1991-01-28'),
('Charlotte', 'Hall', 'charlotte.hall@hotmail.com', '5551230014', '11 Victoria Sq, Bath', 'Female', '1988-06-03'),
('Lucas', 'Allen', 'lucas.allen@mail.com', '5551230015', '19 Market St, Coventry', 'Male', '1992-03-18'),
('Amelia', 'Wright', 'amelia.wright@gmail.com', '5551230016', '56 Crown Rd, Derby', 'Female', '1996-09-12'),
('Henry', 'Scott', 'henry.scott@gmail.com', '5551230017', '61 Garden Ln, York', 'Male', '1986-12-01'),
('Harper', 'Adams', 'harper.adams@yahoo.com', '5551230018', '39 Station St, Reading', 'Female', '1993-04-27'),
('Alexander', 'Baker', 'alex.baker@outlook.com', '5551230019', '88 Hilltop Rd, Portsmouth', 'Male', '1990-11-09'),
('Evelyn', 'Turner', 'evelyn.turner@gmail.com', '5551230020', '27 Lane End, Swansea', 'Female', '1994-08-25');

INSERT INTO staff (first_name, last_name, Email, Phone, Username, Password) VALUES
('Staff1', 'A', 'staff1@club.com', '2000000001', 'staff1', 'pass1'),
('Staff2', 'B', 'staff2@club.com', '2000000002', 'staff2', 'pass2'),
('Staff3', 'C', 'staff3@club.com', '2000000003', 'staff3', 'pass3'),
('Staff4', 'D', 'staff4@club.com', '2000000004', 'staff4', 'pass4'),
('Staff5', 'E', 'staff5@club.com', '2000000005', 'staff5', 'pass5'),
('Staff6', 'F', 'staff6@club.com', '2000000006', 'staff6', 'pass6'),
('Staff7', 'G', 'staff7@club.com', '2000000007', 'staff7', 'pass7'),
('Staff8', 'H', 'staff8@club.com', '2000000008', 'staff8', 'pass8'),
('Staff9', 'I', 'staff9@club.com', '2000000009', 'staff9', 'pass9'),
('Staff10', 'J', 'staff10@club.com', '2000000010', 'staff10', 'pass10'),
('Staff11', 'K', 'staff11@club.com', '2000000011', 'staff11', 'pass11'),
('Staff12', 'L', 'staff12@club.com', '2000000012', 'staff12', 'pass12'),
('Staff13', 'M', 'staff13@club.com', '2000000013', 'staff13', 'pass13'),
('Staff14', 'N', 'staff14@club.com', '2000000014', 'staff14', 'pass14'),
('Staff15', 'O', 'staff15@club.com', '2000000015', 'staff15', 'pass15'),
('Staff16', 'P', 'staff16@club.com', '2000000016', 'staff16', 'pass16'),
('Staff17', 'Q', 'staff17@club.com', '2000000017', 'staff17', 'pass17'),
('Staff18', 'R', 'staff18@club.com', '2000000018', 'staff18', 'pass18'),
('Staff19', 'S', 'staff19@club.com', '2000000019', 'staff19', 'pass19'),
('Staff20', 'T', 'staff20@club.com', '2000000020', 'staff20', 'pass20');
INSERT INTO Stadiums (Name, Location, Capacity, City) VALUES
('Old Trafford', 'Manchester', 74000, 'Manchester'),
('Camp Nou', 'Barcelona', 99354, 'Barcelona'),
('Anfield', 'Liverpool', 54000, 'Liverpool'),
('San Siro', 'Milan', 80000, 'Milan'),
('Allianz Arena', 'Munich', 75000, 'Munich'),
('Santiago Bernabéu', 'Madrid', 81000, 'Madrid'),
('Parc des Princes', 'Paris', 48000, 'Paris'),
('Emirates Stadium', 'London', 60000, 'London'),
('Signal Iduna Park', 'Dortmund', 81365, 'Dortmund'),
('Etihad Stadium', 'Manchester', 55000, 'Manchester'),
('Stamford Bridge', 'London', 42000, 'London'),
('Tottenham Hotspur Stadium', 'London', 62000, 'London'),
('Red Bull Arena', 'Leipzig', 42558, 'Leipzig'),
('Groupama Stadium', 'Lyon', 59000, 'Lyon'),
('Amsterdam Arena', 'Amsterdam', 54000, 'Amsterdam'),
('Estadio do Dragão', 'Porto', 50033, 'Porto'),
('Estadio da Luz', 'Lisbon', 64642, 'Lisbon'),
('Turk Telekom Stadium', 'Istanbul', 52650, 'Istanbul'),
('Luzhniki Stadium', 'Moscow', 81000, 'Moscow'),
('Maracanã', 'Rio de Janeiro', 78838, 'Rio');
INSERT INTO Promotions (Code, DiscountPercent, StartDate, EndDate, UsageLimit) VALUES
('PROMO10', 10.00, '2025-01-01', '2025-06-30', 100),
('WELCOME5', 5.00, '2025-01-15', '2025-07-15', 50),
('VIP20', 20.00, '2025-03-01', '2025-09-01', 25),
('SAVE15', 15.00, '2025-02-10', '2025-05-10', 200),
('REGULAR10', 10.00, '2025-03-01', '2025-08-01', 75),
('SEASON2025', 12.00, '2025-04-01', '2025-10-01', 150),
('MATCHDAY', 8.50, '2025-04-10', '2025-05-10', 40),
('NEWUSER25', 25.00, '2025-05-01', '2025-07-01', 60),
('FLASH50', 50.00, '2025-04-15', '2025-04-20', 20),
('FAN20', 20.00, '2025-06-01', '2025-08-31', 30),
('GOAL30', 30.00, '2025-07-01', '2025-10-01', 100),
('SUPER10', 10.00, '2025-08-01', '2025-11-01', 80),
('HOT25', 25.00, '2025-09-01', '2025-12-01', 45),
('CLUB15', 15.00, '2025-10-01', '2026-01-01', 90),
('MEMBER5', 5.00, '2025-11-01', '2026-02-01', 120),
('BLACKFRIDAY', 40.00, '2025-11-25', '2025-11-30', 200),
('CYBERMONDAY', 35.00, '2025-12-01', '2025-12-02', 150),
('HOLIDAY20', 20.00, '2025-12-15', '2026-01-05', 300),
('YEAR-END30', 30.00, '2025-12-20', '2026-01-01', 100),
('BIRTHDAY50', 50.00, '2025-01-01', '2025-12-31', NULL);
INSERT INTO Seasons (Name, StartDate, EndDate, Type) VALUES
('2023-2024 League', '2023-08-01', '2024-05-20', 'League'),
('2023-2024 Cup', '2023-09-15', '2024-04-25', 'Cup'),
('2024-2025 League', '2024-08-01', '2025-05-20', 'League'),
('2024-2025 Cup', '2024-09-10', '2025-04-15', 'Cup'),
('2024 Summer Friendlies', '2024-06-01', '2024-07-31', 'Friendly'),
('2025-2026 League', '2025-08-01', '2026-05-20', 'League'),
('2025-2026 Cup', '2025-09-10', '2026-04-15', 'Cup'),
('2025 Winter Friendlies', '2025-12-01', '2025-12-31', 'Friendly'),
('2026-2027 League', '2026-08-01', '2027-05-20', 'League'),
('2026-2027 Cup', '2026-09-10', '2027-04-15', 'Cup'),
('2026 Summer Friendlies', '2026-06-01', '2026-07-31', 'Friendly'),
('2027-2028 League', '2027-08-01', '2028-05-20', 'League'),
('2027-2028 Cup', '2027-09-10', '2028-04-15', 'Cup'),
('2027 Winter Friendlies', '2027-12-01', '2027-12-31', 'Friendly'),
('2028-2029 League', '2028-08-01', '2029-05-20', 'League'),
('2028-2029 Cup', '2028-09-10', '2029-04-15', 'Cup'),
('2028 Summer Friendlies', '2028-06-01', '2028-07-31', 'Friendly'),
('2029-2030 League', '2029-08-01', '2030-05-20', 'League'),
('2029-2030 Cup', '2029-09-10', '2030-04-15', 'Cup'),
('2029 Winter Friendlies', '2029-12-01', '2029-12-31', 'Friendly');
INSERT INTO refees (first_name, last_name, Email, refee_salary) VALUES
('Michael', 'Oliver', 'moliver@ref.com', 8000.00),
('Anthony', 'Taylor', 'ataylor@ref.com', 7900.00),
('Mark', 'Clattenburg', 'mclattenburg@ref.com', 8500.00),
('Howard', 'Webb', 'hwebb@ref.com', 8700.00),
('Martin', 'Atkinson', 'matkinson@ref.com', 7800.00),
('Craig', 'Pawson', 'cpawson@ref.com', 7650.00),
('Mike', 'Dean', 'mdean@ref.com', 9000.00),
('Andre', 'Marriner', 'amarriner@ref.com', 7700.00),
('Stuart', 'Attwell', 'sattwell@ref.com', 7600.00),
('Chris', 'Kavanagh', 'ckavanagh@ref.com', 7550.00),
('Paul', 'Tierney', 'ptierney@ref.com', 8000.00),
('Lee', 'Mason', 'lmason@ref.com', 7850.00),
('John', 'Brooks', 'jbrooks@ref.com', 7800.00),
('Robert', 'Jones', 'rjones@ref.com', 7900.00),
('Simon', 'Hooper', 'shooper@ref.com', 7700.00),
('David', 'Coote', 'dcoote@ref.com', 7650.00),
('Peter', 'Bankes', 'pbankes@ref.com', 7500.00),
('Graham', 'Scott', 'gscott@ref.com', 7850.00),
('Kevin', 'Friend', 'kfriend@ref.com', 8000.00),
('Darren', 'England', 'dengland@ref.com', 7950.00);
INSERT INTO Teams (Name, Coach, Logo, StadiumID, FoundedYear) VALUES
('Manchester United', 'Erik ten Hag', 'manutd_logo.png', 1, 1878),
('Manchester City', 'Pep Guardiola', 'mancity_logo.png', 2, 1880),
('Liverpool FC', 'Jürgen Klopp', 'liverpool_logo.png', 3, 1892),
('Chelsea FC', 'Mauricio Pochettino', 'chelsea_logo.png', 4, 1905),
('Arsenal FC', 'Mikel Arteta', 'arsenal_logo.png', 5, 1886),
('Tottenham Hotspur', 'Ange Postecoglou', 'tottenham_logo.png', 6, 1882),
('Newcastle United', 'Eddie Howe', 'newcastle_logo.png', 7, 1892),
('Aston Villa', 'Unai Emery', 'astonvilla_logo.png', 8, 1874),
('Everton FC', 'Sean Dyche', 'everton_logo.png', 9, 1878),
('West Ham United', 'David Moyes', 'westham_logo.png', 10, 1895),
('Leicester City', 'Enzo Maresca', 'leicester_logo.png', 11, 1884),
('Leeds United', 'Daniel Farke', 'leeds_logo.png', 12, 1919),
('Nottingham Forest', 'Steve Cooper', 'nottingham_logo.png', 13, 1865),
('Southampton FC', 'Russell Martin', 'southampton_logo.png', 14, 1885),
('Brighton & Hove Albion', 'Roberto De Zerbi', 'brighton_logo.png', 15, 1901),
('Crystal Palace', 'Roy Hodgson', 'crystalpalace_logo.png', 16, 1905),
('Burnley FC', 'Vincent Kompany', 'burnley_logo.png', 17, 1882),
('Sheffield United', 'Paul Heckingbottom', 'sheffield_logo.png', 18, 1889),
('Fulham FC', 'Marco Silva', 'fulham_logo.png', 19, 1879),
('Brentford FC', 'Thomas Frank', 'brentford_logo.png', 20, 1889);
INSERT INTO Players (Name, TeamID, Position, JerseyNumber, DateOfBirth, Nationality) VALUES
-- Manchester United (TeamID = 1)
('Bruno Fernandes', 1, 'Midfielder', 8, '1994-09-08', 'Portugal'),
('Marcus Rashford', 1, 'Forward', 10, '1997-10-31', 'England'),
('Raphaël Varane', 1, 'Defender', 19, '1993-04-25', 'France'),

-- Manchester City (2)
('Erling Haaland', 2, 'Forward', 9, '2000-07-21', 'Norway'),
('Kevin De Bruyne', 2, 'Midfielder', 17, '1991-06-28', 'Belgium'),
('Rúben Dias', 2, 'Defender', 3, '1997-05-14', 'Portugal'),

-- Liverpool (3)
('Mohamed Salah', 3, 'Forward', 11, '1992-06-15', 'Egypt'),
('mohamed hassan', 3, 'Defender', 4, '1991-07-08', 'Netherlands'),
('musalam', 3, 'Goalkeeper', 1, '1992-10-02', 'Brazil'),

-- Chelsea (4)
('YOUssef hossam', 4, 'Forward', 7, '1994-12-08', 'England'),
('mohamedreffat', 4, 'Midfielder', 8, '2001-01-17', 'Argentina'),
('omar abdalla', 4, 'Defender', 6, '1984-09-22', 'Brazil'),

-- Arsenal (5)
('Bukayo Saka', 5, 'Forward', 7, '2001-09-05', 'England'),
('Martin Ødegaard', 5, 'Midfielder', 8, '1998-12-17', 'Norway'),
('William Saliba', 5, 'Defender', 2, '2001-03-24', 'France'),

-- Tottenham (6)
('Heung-min Son', 6, 'Forward', 7, '1992-07-08', 'South Korea'),
('James Maddison', 6, 'Midfielder', 10, '1996-11-23', 'England'),
('Cristian Romero', 6, 'Defender', 17, '1998-04-27', 'Argentina'),

-- Newcastle (7)
('Alexander Isak', 7, 'Forward', 14, '1999-09-21', 'Sweden'),
('Bruno Guimarães', 7, 'Midfielder', 39, '1997-11-16', 'Brazil'),
('Kieran Trippier', 7, 'Defender', 2, '1990-09-19', 'England'),

-- Aston Villa (8)
('Ollie Watkins', 8, 'Forward', 11, '1995-12-30', 'England'),
('Douglas Luiz', 8, 'Midfielder', 6, '1998-05-09', 'Brazil'),
('Ezri Konsa', 8, 'Defender', 4, '1997-10-23', 'England'),

-- Everton (9)
('Dominic Calvert-Lewin', 9, 'Forward', 9, '1997-03-16', 'England'),
('Amadou Onana', 9, 'Midfielder', 8, '2001-08-16', 'Belgium'),
('James Tarkowski', 9, 'Defender', 5, '1992-11-19', 'England'),

-- West Ham (10)
('Jarrod Bowen', 10, 'Forward', 20, '1996-12-20', 'England'),
('Declan Rice', 10, 'Midfielder', 41, '1999-01-14', 'England'),
('Kurt Zouma', 10, 'Defender', 4, '1994-10-27', 'France'),

-- Leicester (11)
('Jamie Vardy', 11, 'Forward', 9, '1987-01-11', 'England'),
('Wilfred Ndidi', 11, 'Midfielder', 25, '1996-12-16', 'Nigeria'),
('Çağlar Söyüncü', 11, 'Defender', 4, '1996-05-23', 'Turkey'),

-- Leeds (12)
('Patrick Bamford', 12, 'Forward', 9, '1993-09-05', 'England'),
('Tyler Adams', 12, 'Midfielder', 12, '1999-02-14', 'USA'),
('Liam Cooper', 12, 'Defender', 6, '1991-08-30', 'Scotland'),

-- Nottingham Forest (13)
('Taiwo Awoniyi', 13, 'Forward', 9, '1997-08-12', 'Nigeria'),
('Morgan Gibbs-White', 13, 'Midfielder', 10, '2000-01-27', 'England'),
('Joe Worrall', 13, 'Defender', 4, '1997-01-10', 'England'),

-- Southampton (14)
('Che Adams', 14, 'Forward', 10, '1996-07-13', 'Scotland'),
('James Ward-Prowse', 14, 'Midfielder', 8, '1994-11-01', 'England'),
('Kyle Walker-Peters', 14, 'Defender', 2, '1997-04-13', 'England'),

-- Brighton (15)
('João Pedro', 15, 'Forward', 9, '2001-09-26', 'Brazil'),
('Pascal Groß', 15, 'Midfielder', 13, '1991-06-15', 'Germany'),
('Lewis Dunk', 15, 'Defender', 5, '1991-11-21', 'England'),

-- Crystal Palace (16)
('Odsonne Édouard', 16, 'Forward', 22, '1998-01-16', 'France'),
('Eberechi Eze', 16, 'Midfielder', 10, '1998-06-29', 'England'),
('Joachim Andersen', 16, 'Defender', 16, '1996-05-31', 'Denmark'),

-- Burnley (17)
('Jay Rodriguez', 17, 'Forward', 9, '1989-07-29', 'England'),
('Josh Brownhill', 17, 'Midfielder', 8, '1995-12-19', 'England'),
('Charlie Taylor', 17, 'Defender', 3, '1993-09-18', 'England'),

-- Sheffield United (18)
('Oli McBurnie', 18, 'Forward', 9, '1996-06-04', 'Scotland'),
('Sander Berge', 18, 'Midfielder', 8, '1998-02-14', 'Norway'),
('John Egan', 18, 'Defender', 12, '1992-10-20', 'Ireland'),

-- Fulham (19)
('Aleksandar Mitrović', 19, 'Forward', 9, '1994-09-16', 'Serbia'),
('João Palhinha', 19, 'Midfielder', 26, '1995-07-09', 'Portugal'),
('Tosin Adarabioyo', 19, 'Defender', 4, '1997-09-24', 'England'),

-- Brentford (20)
('Ivan Toney', 20, 'Forward', 17, '1996-03-16', 'England'),
('Mathias Jensen', 20, 'Midfielder', 8, '1996-01-01', 'Denmark'),
('Ben Mee', 20, 'Defender', 16, '1989-09-21', 'England');
INSERT INTO Matches (HomeTeam, AwayTeam, MatchDate, MatchTime, StadiumID, Status) VALUES
(1, 2, '2025-08-10', '18:30:00', 1, 'Scheduled'),
(3, 4, '2025-08-11', '20:00:00', 2, 'Scheduled'),
(5, 6, '2025-08-12', '19:00:00', 3, 'Scheduled'),
(7, 8, '2025-08-13', '18:00:00', 4, 'Scheduled'),
(9, 10, '2025-08-14', '21:00:00', 5, 'Scheduled'),
(11, 12, '2025-08-15', '17:30:00', 6, 'Scheduled'),
(13, 14, '2025-08-16', '18:45:00', 7, 'Scheduled'),
(15, 16, '2025-08-17', '16:00:00', 8, 'Scheduled'),
(17, 18, '2025-08-18', '20:30:00', 9, 'Scheduled'),
(19, 20, '2025-08-19', '19:15:00', 10, 'Scheduled'),
(2, 1, '2025-08-20', '18:30:00', 11, 'Scheduled'),
(4, 3, '2025-08-21', '20:00:00', 12, 'Scheduled'),
(6, 5, '2025-08-22', '19:00:00', 13, 'Scheduled'),
(8, 7, '2025-08-23', '18:00:00', 14, 'Scheduled'),
(10, 9, '2025-08-24', '21:00:00', 15, 'Scheduled'),
(12, 11, '2025-08-25', '17:30:00', 16, 'Scheduled'),
(14, 13, '2025-08-26', '18:45:00', 17, 'Scheduled'),
(16, 15, '2025-08-27', '16:00:00', 18, 'Scheduled'),
(18, 17, '2025-08-28', '20:30:00', 19, 'Scheduled'),
(20, 19, '2025-08-29', '19:15:00', 20, 'Scheduled');

INSERT INTO Tickets (MatchID, CustomerID, SeatNumber, Price, BookingDate, PaymentStatus, TicketType) VALUES
(1, 1, 'A1', 75.00, '2025-07-01', 'Paid', 'VIP'),
(2, 2, 'B2', 50.00, '2025-07-02', 'Paid', 'Regular'),
(3, 3, 'C3', 60.00, '2025-07-03', 'Pending', 'Regular'),
(4, 4, 'D4', 90.00, '2025-07-04', 'Paid', 'VIP'),
(5, 5, 'E5', 45.00, '2025-07-05', 'Paid', 'Regular'),
(6, 6, 'F6', 80.00, '2025-07-06', 'Pending', 'VIP'),
(7, 7, 'G7', 55.00, '2025-07-07', 'Paid', 'Regular'),
(8, 8, 'H8', 70.00, '2025-07-08', 'Paid', 'VIP'),
(9, 9, 'I9', 50.00, '2025-07-09', 'Pending', 'Regular'),
(10, 10, 'J10', 65.00, '2025-07-10', 'Paid', 'VIP'),
(11, 11, 'K11', 40.00, '2025-07-11', 'Paid', 'Regular'),
(12, 12, 'L12', 85.00, '2025-07-12', 'Paid', 'VIP'),
(13, 13, 'M13', 50.00, '2025-07-13', 'Pending', 'Regular'),
(14, 14, 'N14', 75.00, '2025-07-14', 'Paid', 'VIP'),
(15, 15, 'O15', 60.00, '2025-07-15', 'Paid', 'Regular'),
(16, 16, 'P16', 90.00, '2025-07-16', 'Paid', 'VIP'),
(17, 17, 'Q17', 50.00, '2025-07-17', 'Paid', 'Regular'),
(18, 18, 'R18', 65.00, '2025-07-18', 'Pending', 'VIP'),
(19, 19, 'S19', 55.00, '2025-07-19', 'Paid', 'Regular'),
(20, 20, 'T20', 70.00, '2025-07-20', 'Paid', 'VIP');
INSERT INTO Payments (TicketID, CustomerID, Amount, PaymentMethod, PaymentDate, Status) VALUES
(1, 1, 75.00, 'Credit Card', '2025-07-01 14:00:00', 'Success'),
(2, 2, 50.00, 'PayPal', '2025-07-02 15:30:00', 'Success'),
(3, 3, 60.00, 'Debit Card', '2025-07-03 10:00:00', 'Pending'),
(4, 4, 90.00, 'Credit Card', '2025-07-04 12:45:00', 'Success'),
(5, 5, 45.00, 'Cash', '2025-07-05 17:00:00', 'Success'),
(6, 6, 80.00, 'Credit Card', '2025-07-06 16:20:00', 'Pending'),
(7, 7, 55.00, 'PayPal', '2025-07-07 11:40:00', 'Success'),
(8, 8, 70.00, 'Credit Card', '2025-07-08 13:25:00', 'Success'),
(9, 9, 50.00, 'Debit Card', '2025-07-09 09:30:00', 'Pending'),
(10, 10, 65.00, 'Credit Card', '2025-07-10 18:10:00', 'Success'),
(11, 11, 40.00, 'PayPal', '2025-07-11 20:00:00', 'Success'),
(12, 12, 85.00, 'Credit Card', '2025-07-12 14:30:00', 'Success'),
(13, 13, 50.00, 'Cash', '2025-07-13 19:45:00', 'Pending'),
(14, 14, 75.00, 'Credit Card', '2025-07-14 21:15:00', 'Success'),
(15, 15, 60.00, 'PayPal', '2025-07-15 16:10:00', 'Success'),
(16, 16, 90.00, 'Debit Card', '2025-07-16 11:25:00', 'Success'),
(17, 17, 50.00, 'Credit Card', '2025-07-17 10:05:00', 'Success'),
(18, 18, 65.00, 'PayPal', '2025-07-18 12:35:00', 'Pending'),
(19, 19, 55.00, 'Cash', '2025-07-19 13:00:00', 'Success'),
(20, 20, 70.00, 'Credit Card', '2025-07-20 15:45:00', 'Success');
INSERT INTO Reservations (CustomerID, TicketID, ReservationDate, Status) VALUES
(1, 1, '2025-07-01 13:00:00', 'Confirmed'),
(2, 2, '2025-07-02 14:15:00', 'Confirmed'),
(3, 3, '2025-07-03 11:00:00', 'Confirmed'),
(4, 4, '2025-07-04 12:00:00', 'Confirmed'),
(5, 5, '2025-07-05 12:30:00', 'Confirmed'),
(6, 6, '2025-07-06 15:00:00', 'Cancelled'),
(7, 7, '2025-07-07 09:00:00', 'Confirmed'),
(8, 8, '2025-07-08 14:00:00', 'Confirmed'),
(9, 9, '2025-07-09 10:00:00', 'Cancelled'),
(10, 10, '2025-07-10 17:00:00', 'Confirmed'),
(11, 11, '2025-07-11 20:30:00', 'Confirmed'),
(12, 12, '2025-07-12 14:00:00', 'Confirmed'),
(13, 13, '2025-07-13 18:00:00', 'Cancelled'),
(14, 14, '2025-07-14 13:00:00', 'Confirmed'),
(15, 15, '2025-07-15 16:00:00', 'Confirmed'),
(16, 16, '2025-07-16 11:00:00', 'Confirmed'),
(17, 17, '2025-07-17 10:30:00', 'Confirmed'),
(18, 18, '2025-07-18 13:30:00', 'Cancelled'),
(19, 19, '2025-07-19 14:00:00', 'Confirmed'),
(20, 20, '2025-07-20 12:30:00', 'Confirmed');
INSERT INTO Reviews (CustomerID, MatchID, Rating, Comment, Date) VALUES
(1, 1, 5, 'Amazing match!', '2025-08-11 21:00:00'),
(2, 2, 4, 'Great performance by both teams.', '2025-08-12 20:00:00'),
(3, 3, 3, 'Average match.', '2025-08-13 19:30:00'),
(4, 4, 2, 'Not exciting.', '2025-08-14 20:00:00'),
(5, 5, 4, 'Good atmosphere.', '2025-08-15 19:45:00'),
(6, 6, 5, 'Loved the crowd!', '2025-08-16 20:10:00'),
(7, 7, 3, 'Could be better.', '2025-08-17 18:30:00'),
(8, 8, 5, 'What a comeback!', '2025-08-18 21:00:00'),
(9, 9, 4, 'Enjoyed the tactics.', '2025-08-19 20:00:00'),
(10, 10, 2, 'Disappointing referee decisions.', '2025-08-20 20:30:00'),
(11, 11, 4, 'Good defense.', '2025-08-21 18:30:00'),
(12, 12, 5, 'Top-level football!', '2025-08-22 19:30:00'),
(13, 13, 3, 'Balanced game.', '2025-08-23 18:45:00'),
(14, 14, 5, 'Great skills on display.', '2025-08-24 20:15:00'),
(15, 15, 4, 'Nice stadium experience.', '2025-08-25 17:00:00'),
(16, 16, 1, 'Boring match.', '2025-08-26 16:30:00'),
(17, 17, 5, 'Phenomenal goals!', '2025-08-27 21:00:00'),
(18, 18, 3, 'Mediocre display.', '2025-08-28 20:30:00'),
(19, 19, 4, 'Solid performance.', '2025-08-29 18:50:00'),
(20, 20, 5, 'Best match this season!', '2025-08-30 19:00:00');
SELECT COUNT(*) AS total_customers FROM Customers;

SELECT COUNT(*) AS total_tickets FROM Tickets;

SELECT COUNT(*) AS total_matches FROM Matches
WHERE MatchDate BETWEEN '2025-01-01' AND '2025-12-31';
SELECT COUNT(*) AS total_customers_london FROM Customers
WHERE address LIKE '%London%';

SELECT COUNT(*) AS total_vip_tickets FROM Tickets
WHERE TicketType = 'VIP';
SELECT MIN(MatchDate) AS EarliestMatch, MAX(MatchDate) AS LatestMatch FROM Matches;

SELECT MIN(JerseyNumber) AS MinJersey, MAX(JerseyNumber) AS MaxJersey FROM Players;

SELECT MIN(Price) AS MinTicketPrice, MAX(Price) AS MaxTicketPrice FROM Tickets;

SELECT AVG(Price) AS AvgTicketPrice FROM Tickets;

SELECT AVG(JerseyNumber) AS AvgJerseyNumber FROM Players;

SELECT AVG(Amount) AS AvgPayment FROM Payments;

SELECT SUM(Price) AS TotalRevenue FROM Tickets;

-- Find the total amount of payments made
SELECT SUM(Amount) AS TotalPayments FROM Payments;

-- Find the total number of goals scored by all teams in a season
SELECT SUM(Goals) AS TotalGoals FROM MatchStatistics
WHERE MatchID IN (SELECT MatchID FROM Matches WHERE MatchDate BETWEEN '2025-01-01' AND '2025-12-31');
-- avg of ticket price of stadume
SELECT s.Name AS StadiumName, AVG(t.Price) AS AvgTicketPrice
FROM Tickets t
JOIN Matches m ON t.MatchID = m.MatchID
JOIN Stadiums s ON m.StadiumID = s.StadiumID
GROUP BY s.Name;
-- show player details
SELECT p.PlayerID, p.Name AS PlayerName, t.Name AS TeamName, p.Position, p.JerseyNumber
FROM Players p
JOIN Teams t ON p.TeamID = t.TeamID;



