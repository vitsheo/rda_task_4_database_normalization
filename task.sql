-- 1. Пересоздание базы данных
CREATE DATABASE IF NOT EXISTS ShopDB;
USE ShopDB;

-- 2. Таблица Справочник Стран
CREATE TABLE Countries (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- 3. Таблица Справочник Складов (Для нормализации данных склада в 3NF)
CREATE TABLE Warehouses (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(ID) ON DELETE SET NULL
);

-- 4. Исходная таблица ProductInventory, приведенная к 3NF
CREATE TABLE ProductInventory (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    WarehouseAmount INT NOT NULL,
    WarehouseName VARCHAR(100),
    WarehouseAddress VARCHAR(100),
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(ID) ON DELETE SET NULL
);

-- ==========================================
-- ОБНОВЛЕННЫЕ ОПЕРАТОРЫ INSERT ПОД ТЕСТЫ
-- ==========================================

-- Заполняем страны
INSERT INTO Countries (ID, Name) VALUES (1, 'Country1');
INSERT INTO Countries (ID, Name) VALUES (2, 'Country2');

-- Заполняем справочник складов для соблюдения 3NF
INSERT INTO Warehouses (ID, Name, Address, CountryID) VALUES (1, 'Warehouse-1', 'City-1, Street-1', 1);
INSERT INTO Warehouses (ID, Name, Address, CountryID) VALUES (2, 'Warehouse-2', 'City-2, Street-2', 2);

-- Заполняем ДВА обязательных товара в ProductInventory, как требует тест
INSERT INTO ProductInventory (ID, ProductName, WarehouseAmount, WarehouseName, WarehouseAddress, CountryID)
VALUES (1, 'AwersomeProduct', 2, 'Warehouse-1', 'City-1, Street-1', 1);

INSERT INTO ProductInventory (ID, ProductName, WarehouseAmount, WarehouseName, WarehouseAddress, CountryID)
VALUES (2, 'AnotherProduct', 5, 'Warehouse-2', 'City-2, Street-2', 2);
