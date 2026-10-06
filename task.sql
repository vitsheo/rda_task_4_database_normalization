-- 1. Пересоздание базы данных
CREATE DATABASE IF NOT EXISTS ShopDB;
USE ShopDB;

-- 2. Таблица Countries (Была создана изначально)
CREATE TABLE Countries (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- 3. Таблица Warehouses (Для нормализации данных склада в 3NF)
-- Сюда переносим CountryID, убирая его из ProductInventory
CREATE TABLE Warehouses (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(ID) ON DELETE SET NULL
);

-- 4. Нормализованная таблица ProductInventory (Только внешние ключи и количество)
-- Здесь БОЛЬШЕ НЕТ текстовых полей и нет CountryID
CREATE TABLE ProductInventory (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    WarehouseID INT,
    WarehouseAmount INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Warehouses(ID) ON DELETE SET NULL
);

-- ==========================================
-- ОБНОВЛЕННЫЕ ОПЕРАТОРЫ INSERT ПОД ТЕСТЫ
-- ==========================================

-- Заполняем страны
INSERT INTO Countries (ID, Name) VALUES (1, 'Country1');
INSERT INTO Countries (ID, Name) VALUES (2, 'Country2');

-- Заполняем справочник складов (2 записи для тестов)
INSERT INTO Warehouses (ID, Name, Address, CountryID) VALUES (1, 'Warehouse-1', 'City-1, Street-1', 1);
INSERT INTO Warehouses (ID, Name, Address, CountryID) VALUES (2, 'Warehouse-2', 'City-2, Street-2', 2);

-- Заполняем ДВЕ записи в ProductInventory (через связи, как просил ментор)
INSERT INTO ProductInventory (ID, ProductID, WarehouseID, WarehouseAmount)
VALUES (1, 1, 1, 2);

INSERT INTO ProductInventory (ID, ProductID, WarehouseID, WarehouseAmount)
VALUES (2, 1, 2, 5);
