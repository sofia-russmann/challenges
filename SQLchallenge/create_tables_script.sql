CREATE TABLE customer (
	customer_id int IDENTITY(1,1) PRIMARY KEY,
    email varchar (255) NOT NULL,
	first_name varchar (255) NOT NULL,
	last_name varchar (255) NOT NULL,
    sex varchar (255),
	address varchar (255) NOT NULL,
	birthdate date NOT NULL,
    phone varchar (25),
);

CREATE TABLE category (
	category_id int IDENTITY(1,1) PRIMARY KEY,
	category_name varchar (255) NOT NULL,
    category_path varchar (255) NOT NULL,
    last_updated date NOT NULL
);

CREATE TABLE item (
	item_id int IDENTITY(1,1) PRIMARY KEY,
	item_name varchar (255) NOT NULL,
	category_id int NOT NULL FOREIGN KEY REFERENCES category(category_id),
	item_price decimal (10, 2) NOT NULL,
    item_status tinyint NOT NULL,
);

CREATE TABLE [order](
	order_id int IDENTITY(1,1) PRIMARY KEY,
	customer_id int NOT NULL FOREIGN KEY REFERENCES customer(customer_id),
    item_id int NOT NULL FOREIGN KEY REFERENCES item(item_id),
    quantity int NOT NULL,
    total_price decimal (10, 2) NOT NULL,
    order_date date NOT NULL,
);