-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema skechers_ecommerce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema skechers_ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `skechers_ecommerce` DEFAULT CHARACTER SET utf8 ;
USE `skechers_ecommerce` ;

-- -----------------------------------------------------
-- Table `skechers_ecommerce`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skechers_ecommerce`.`rol` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `estado` TINYINT NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skechers_ecommerce`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skechers_ecommerce`.`usuario` (
  `id_usuario` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `contraseña` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `direccion` VARCHAR(255) NOT NULL,
  `fecha_registro` DATETIME NOT NULL,
  `estado` TINYINT NOT NULL,
  `rol_id_rol` INT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_usuario_rol_idx` (`rol_id_rol` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_rol`
    FOREIGN KEY (`rol_id_rol`)
    REFERENCES `skechers_ecommerce`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skechers_ecommerce`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skechers_ecommerce`.`categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  `estado` TINYINT NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skechers_ecommerce`.`carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skechers_ecommerce`.`carrito` (
  `id_carrito` INT NOT NULL AUTO_INCREMENT,
  `fecha_creacion` DATETIME NOT NULL,
  `estado` TINYINT NOT NULL,
  `id_usuario` INT NOT NULL,
  `usuario_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_carrito`),
  INDEX `fk_carrito_usuario1_idx` (`usuario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_carrito_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `skechers_ecommerce`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skechers_ecommerce`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skechers_ecommerce`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(150) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `imagen` VARCHAR(255) NOT NULL,
  `estado` TINYINT NOT NULL,
  `id_categoria` INT NOT NULL,
  `categoria_id_categoria` INT NOT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `fk_producto_categoria1_idx` (`categoria_id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_producto_categoria1`
    FOREIGN KEY (`categoria_id_categoria`)
    REFERENCES `skechers_ecommerce`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skechers_ecommerce`.`producto_variante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skechers_ecommerce`.`producto_variante` (
  `id_variante` INT NOT NULL AUTO_INCREMENT,
  `talla` VARCHAR(10) NULL,
  `color` VARCHAR(50) NULL,
  `stock` INT NULL,
  `codigo_producto` VARCHAR(30) NULL,
  `estado` TINYINT NULL,
  `producto_id_producto` INT NOT NULL,
  PRIMARY KEY (`id_variante`),
  INDEX `fk_producto_variante_producto1_idx` (`producto_id_producto` ASC) VISIBLE,
  CONSTRAINT `fk_producto_variante_producto1`
    FOREIGN KEY (`producto_id_producto`)
    REFERENCES `skechers_ecommerce`.`producto` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skechers_ecommerce`.`detallecarrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skechers_ecommerce`.`detallecarrito` (
  `id_detallecarrito` INT NOT NULL AUTO_INCREMENT,
  `cantidad` DECIMAL(10,2) NULL,
  `subtotal` INT NULL,
  `id_carrito` INT NULL,
  `carrito_id_carrito` INT NOT NULL,
  `producto_variante_id_variante` INT NOT NULL,
  PRIMARY KEY (`id_detallecarrito`),
  INDEX `fk_detallecarrito_carrito1_idx` (`carrito_id_carrito` ASC) VISIBLE,
  INDEX `fk_detallecarrito_producto_variante1_idx` (`producto_variante_id_variante` ASC) VISIBLE,
  CONSTRAINT `fk_detallecarrito_carrito1`
    FOREIGN KEY (`carrito_id_carrito`)
    REFERENCES `skechers_ecommerce`.`carrito` (`id_carrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detallecarrito_producto_variante1`
    FOREIGN KEY (`producto_variante_id_variante`)
    REFERENCES `skechers_ecommerce`.`producto_variante` (`id_variante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skechers_ecommerce`.`pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skechers_ecommerce`.`pago` (
  `id_pago` INT NOT NULL AUTO_INCREMENT,
  `metodo_pago` VARCHAR(50) NULL,
  `fecha_pago` DATETIME NULL,
  `monto` DECIMAL(10,2) NULL,
  `estado` VARCHAR(30) NULL,
  PRIMARY KEY (`id_pago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skechers_ecommerce`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skechers_ecommerce`.`pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `fecha_pedido` DATETIME NOT NULL,
  `estado` VARCHAR(30) NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_pago` INT NOT NULL,
  `usuario_id_usuario` INT NOT NULL,
  `pago_id_pago` INT NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_pedido_usuario1_idx` (`usuario_id_usuario` ASC) VISIBLE,
  INDEX `fk_pedido_pago1_idx` (`pago_id_pago` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `skechers_ecommerce`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_pago1`
    FOREIGN KEY (`pago_id_pago`)
    REFERENCES `skechers_ecommerce`.`pago` (`id_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skechers_ecommerce`.`detallepedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skechers_ecommerce`.`detallepedido` (
  `id_detallepedido` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `precio_unitario` DECIMAL(10,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  `id_pedido` INT NOT NULL,
  `pedido_id_pedido` INT NOT NULL,
  `producto_variante_id_variante` INT NOT NULL,
  PRIMARY KEY (`id_detallepedido`),
  INDEX `fk_detallepedido_pedido1_idx` (`pedido_id_pedido` ASC) VISIBLE,
  INDEX `fk_detallepedido_producto_variante1_idx` (`producto_variante_id_variante` ASC) VISIBLE,
  CONSTRAINT `fk_detallepedido_pedido1`
    FOREIGN KEY (`pedido_id_pedido`)
    REFERENCES `skechers_ecommerce`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detallepedido_producto_variante1`
    FOREIGN KEY (`producto_variante_id_variante`)
    REFERENCES `skechers_ecommerce`.`producto_variante` (`id_variante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
