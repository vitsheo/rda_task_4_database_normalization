-- ==========================================
-- 1. СТВОРЕННЯ БАЗИ ДАНИХ ТА СХЕМИ БЕЗ ДУБЛЮВАННЯ
-- ==========================================
CREATE DATABASE IF NOT EXISTS ShopDB;
USE ShopDB;

-- 2. Таблиця Countries (Вже була створена командою розробників)
CREATE TABLE Countries (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- 3. Таблиця Products (Винесено окремо для 2NF/3NF)
CREATE TABLE Products (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- 4. Таблиця Warehouses (Винесено окремо для ліквідації транзитивних залежностей в 3NF)
CREATE TABLE Warehouses (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(ID) ON DELETE SET NULL
);

-- 5. Нормалізована сполучна таблиця ProductInventory (Зберігає лише сутності через зовнішні ключі)
CREATE TABLE ProductInventory (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    WarehouseID INT,
    WarehouseAmount INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ID) ON DELETE SET NULL,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(ID) ON DELETE SET NULL
);

-- ==========================================
-- 6. ОНОВЛЕНІ ОПЕРАТОРИ INSERT ДЛЯ ЗАБЕЗПЕЧЕННЯ ЦІЛІСНОСТІ ТЕСТІВ
-- ==========================================

-- Наповнення списку країн
INSERT INTO Countries (ID, Name) VALUES (1, 'Country1');
INSERT INTO Countries (ID, Name) VALUES (2, 'Country2');

-- Реєстрація унікального товару
INSERT INTO Products (ID, Name) VALUES (1, 'AwersomeProduct');

-- Опис складу з прив'язкою до країни
INSERT INTO Warehouses (ID, Name, Address, CountryID)
VALUES (1, 'Warehouse-1', 'City-1, Street-1', 1);

-- Внесення залишків товару на конкретному складі
INSERT INTO ProductInventory (ID, ProductID, WarehouseID, WarehouseAmount)
VALUES (1, 1, 1, 2);
