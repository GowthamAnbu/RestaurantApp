CREATE TABLE SEED_SEAT
(
SEAT_NUMBER TINYINT PRIMARY KEY,
ACTIVE BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE SEED_FOOD
(
ID TINYINT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(30) UNIQUE NOT NULL,
PRICE INT NOT NULL
);

CREATE TABLE SEED_SESSION
(
ID TINYINT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(30) UNIQUE NOT NULL,
START_TIME TIME NOT NULL,
END_TIME TIME NOT NULL,
MADE_TIME TIME NOT NULL
);

CREATE TABLE SEED_ORDER_LIMIT
(
ID INT PRIMARY KEY AUTO_INCREMENT,
ORDER_MAX TINYINT NOT NULL
);

CREATE TABLE FOOD_SESSION_MAINTENANCE
(
ID PRIMARY KEY AUTO_INCREMENT,
FOOD_ID TINYINT NOT NULL,
SESSION_ID TINYINT NOT NULL,
QUANTITY INT NOT NULL,
CONSTRAINT FK_FOOD_ID FOREIGN KEY(FOOD_ID) REFERENCES SEED_FOOD(ID),
CONSTRAINT FK_SESSION_ID FOREIGN KEY(SESSION_ID) REFERENCES SEED_SESSION(ID)
);

CREATE TABLE ORDERS
(
ID INT PRIMARY KEY AUTO_INCREMENT,
SEAT_NUMBER TINYINT NOT NULL,
TOTAL_PRICE INT NOT NULL DEFAULT 0,
BILL_STATUS BOOLEAN NOT NULL DEFAULT 0,
CONSTRAINT FK_SEAT_NUMBER FOREIGN KEY (SEAT_NUMBER) REFERENCES SEED_SEAT(SEAT_NUMBER)
);

CREATE TABLE ORDER_FOOD_MAINTENANCE
(
ID INT PRIMARY KEY,
ORDER_ID INT,
FOOD_ID TINYINT,
QUANTITY INT NOT NULL,
STATUS VARCHAR(30) NOT NULL DEFAULT 'Ordered',
CONSTRAINT FK_ORDER_ID FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ID),
CONSTRAINT FK_ORDER_FOOD_ID FOREIGN KEY (FOOD_ID) REFERENCES SEED_FOOD(ID)
);
