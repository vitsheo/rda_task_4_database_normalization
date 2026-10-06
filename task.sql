-- 1. Пересоздание базы данных
CREATE DATABASE IF NOT EXISTS ShopDB;
USE ShopDB;

-- 2. Таблица Countries (Страны)
CREATE TABLE Countries (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- 3. Таблица Products (Товары) — Необходима для ухода от избыточности в 3NF
CREATE TABLE Products (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL
);

-- 4. Таблица Warehouses (Склады)
CREATE TABLE Warehouses (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(ID) ON DELETE SET NULL
);

-- 5. Полностью нормализованная таблица ProductInventory (Запасы на складах)
CREATE TABLE ProductInventory (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    WarehouseID INT,
    WarehouseAmount INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ID) ON DELETE SET NULL,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(ID) ON DELETE SET NULL
);

-- ==========================================
-- ОБНОВЛЕННЫЕ ОПЕРАТОРЫ INSERT ПОД ТЕСТЫ
-- ==========================================

-- Заполняем страны
INSERT INTO Countries (ID, Name) VALUES (1, 'Country1');
INSERT INTO Countries (ID, Name) VALUES (2, 'Country2');

-- Заполняем справочник товаров (Добавляем товар с ID=1 для тестов)
INSERT INTO Products (ID, ProductName) VALUES (1, 'AwersomeProduct');

-- Заполняем справочник складов
INSERT INTO Warehouses (ID, Name, Address, CountryID) VALUES (1, 'Warehouse-1', 'City-1, Street-1', 1);
INSERT INTO Warehouses (ID, Name, Address, CountryID) VALUES (2, 'Warehouse-2', 'City-2, Street-2', 2);

-- Заполняем ДВЕ записи в ProductInventory с правильными ссылками на существующие ID
INSERT INTO ProductInventory (ID, ProductID, WarehouseID, WarehouseAmount)
VALUES (1, 1, 1, 2);

INSERT INTO ProductInventory (ID, ProductID, WarehouseID, WarehouseAmount)
VALUES (2, 1, 2, 5);
