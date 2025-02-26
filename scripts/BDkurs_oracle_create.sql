CREATE TABLE Users
(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	email VARCHAR2(255) UNIQUE NOT NULL,
	Password Varchar2(255) Not Null,
	Money Int Default 0);


/
CREATE TABLE Item (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Title VARCHAR2(255) NOT NULL,
	Description VARCHAR2(255) NOT NULL,
	userId INT NOT NULL,
	endTime DATE,
	startPrice INT NOT NULL,
	currentPrice INT DEFAULT 0,
	typeId INT NOT NULL);

Alter Table Item
add buyerId int default NULL;

Alter Table Users
Modify Id Generated By Default As Identity;

ALTER TABLE Item ADD CONSTRAINT Item_fk2 FOREIGN KEY (buyerId) REFERENCES Users(id);
/
CREATE TABLE Category (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	title VARCHAR2(255) NOT NULL);

/
CREATE TABLE ItemAndCategory (
	itemId INT NOT NULL,
	categoryId INT NOT NULL);

alter table ItemAndCategory add constraint constr unique(itemId, categoryId);

/
Create Table Auction (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	categoryId INT,
	startDate DATE NOT NULL);
/

CREATE TABLE AuctionType (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Title VARCHAR2(255) NOT NULL);


/
CREATE TABLE ItemsAndAuction (
	itemId INT NOT NULL,
	Auctionid Int Not Null,
	count INT NOT NULL);


/

ALTER TABLE Item ADD CONSTRAINT Item_fk0 FOREIGN KEY (userId) REFERENCES Users(id);
ALTER TABLE Item ADD CONSTRAINT Item_fk1 FOREIGN KEY (typeId) REFERENCES AuctionType(id);


ALTER TABLE ItemAndCategory ADD CONSTRAINT ItemAndCategory_fk0 FOREIGN KEY (itemId) REFERENCES Item(id);
ALTER TABLE ItemAndCategory ADD CONSTRAINT ItemAndCategory_fk1 FOREIGN KEY (categoryId) REFERENCES Category(id);

ALTER TABLE Auction ADD CONSTRAINT Auction_fk0 FOREIGN KEY (categoryId) REFERENCES Category(id);


ALTER TABLE ItemsAndAuction ADD CONSTRAINT ItemsAndAuction_fk0 FOREIGN KEY (itemId) REFERENCES Item(id);
ALTER TABLE ItemsAndAuction ADD CONSTRAINT ItemsAndAuction_fk1 FOREIGN KEY (AuctionId) REFERENCES Auction(id);

