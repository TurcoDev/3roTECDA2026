-- ============================================================
-- 01_setup.sql - Creación de la base de datos y tablas
-- ============================================================

CREATE DATABASE IF NOT EXISTS tecda;
USE tecda;

-- Tabla principal de usuarios
CREATE TABLE user (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age  INT          NOT NULL
);

-- Tabla de profesiones
CREATE TABLE profession (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Tabla de ciudades
CREATE TABLE city (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Tabla de auditoría (se usará con triggers)
CREATE TABLE audit_user (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    action      VARCHAR(50),
    user_id     INT,
    action_date DATETIME
);
