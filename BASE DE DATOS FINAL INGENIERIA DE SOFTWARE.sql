/*
 Navicat Premium Data Transfer

 Source Server         : 8
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3309
 Source Schema         : aaa

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 20/06/2023 02:33:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for horario
-- ----------------------------
DROP TABLE IF EXISTS `horario`;
CREATE TABLE `horario`  (
  `id_horario` int NOT NULL AUTO_INCREMENT,
  `hora_salida` time(0) NOT NULL,
  `hora_llegada` time(0) NOT NULL,
  `estatus` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  `ruta` int NOT NULL,
  PRIMARY KEY (`id_horario`) USING BTREE,
  INDEX `FK_rutaH`(`ruta`) USING BTREE,
  CONSTRAINT `FK_rutaH` FOREIGN KEY (`ruta`) REFERENCES `ruta` (`id_ruta`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for lugar
-- ----------------------------
DROP TABLE IF EXISTS `lugar`;
CREATE TABLE `lugar`  (
  `id_lugares` int NOT NULL AUTO_INCREMENT,
  `nombre_lugar` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `estatus` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_lugares`) USING BTREE,
  UNIQUE INDEX `unique_lugar`(`nombre_lugar`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for parada
-- ----------------------------
DROP TABLE IF EXISTS `parada`;
CREATE TABLE `parada`  (
  `id_parada` int NOT NULL AUTO_INCREMENT,
  `nombre_parada` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `estatus` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  `ruta` int NOT NULL,
  PRIMARY KEY (`id_parada`) USING BTREE,
  INDEX `Fk_ruta`(`ruta`) USING BTREE,
  CONSTRAINT `FK_rutaP` FOREIGN KEY (`ruta`) REFERENCES `ruta` (`id_ruta`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol`  (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `rol` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estatus` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_rol`) USING BTREE,
  UNIQUE INDEX `unique_rol`(`rol`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for ruta
-- ----------------------------
DROP TABLE IF EXISTS `ruta`;
CREATE TABLE `ruta`  (
  `id_ruta` int NOT NULL AUTO_INCREMENT,
  `origen` int NOT NULL,
  `destino` int NOT NULL,
  `estatus` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_ruta`) USING BTREE,
  INDEX `Fk_origenL`(`origen`) USING BTREE,
  INDEX `Fk_destinoL`(`destino`) USING BTREE,
  CONSTRAINT `FK_destinoL` FOREIGN KEY (`destino`) REFERENCES `lugar` (`id_lugares`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_origenL` FOREIGN KEY (`origen`) REFERENCES `lugar` (`id_lugares`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tarifa
-- ----------------------------
DROP TABLE IF EXISTS `tarifa`;
CREATE TABLE `tarifa`  (
  `id_tarifa` int NOT NULL AUTO_INCREMENT,
  `precio_boleto` double NOT NULL,
  `estatus` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  `ruta` int NOT NULL,
  `parada` int NOT NULL,
  PRIMARY KEY (`id_tarifa`) USING BTREE,
  INDEX `Fk_ruta`(`ruta`) USING BTREE,
  INDEX `Fk_parada`(`parada`) USING BTREE,
  CONSTRAINT `FK_paradaT` FOREIGN KEY (`parada`) REFERENCES `parada` (`id_parada`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario`  (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apellidoPaterno` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apellidoMaterno` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `correo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `contrasenia` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  `rol` int NOT NULL,
  `estatus` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_usuario`) USING BTREE,
  UNIQUE INDEX `unique_correo`(`correo`) USING BTREE,
  INDEX `Fk_rolUsu`(`rol`) USING BTREE,
  CONSTRAINT `Fk_rolUsu` FOREIGN KEY (`rol`) REFERENCES `rol` (`id_rol`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Procedure structure for SP_actualizarHorario
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizarHorario`;
delimiter ;;
CREATE PROCEDURE `SP_actualizarHorario`(p_idHorario INT,
p_hora_salida TIME,
p_hora_llegada TIME,
p_ruta INT)
BEGIN
IF (p_hora_salida = p_hora_llegada)
THEN
SELECT 'Las horas no pueden ser las mismas' AS mensaje, 'danger' AS color;
ELSEIF EXISTS(SELECT * FROM horario WHERE horario.estatus = 1 AND horario.hora_salida = p_hora_salida AND horario.hora_llegada = p_hora_llegada AND horario.ruta = p_ruta AND horario.id_horario <> p_idHorario)
THEN 
SELECT 'Ya existe ese registro, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
ELSEIF EXISTS(SELECT * FROM horario WHERE horario.estatus = 0 AND horario.hora_salida = p_hora_salida AND horario.hora_llegada = p_hora_llegada AND horario.ruta = p_ruta)
THEN 
UPDATE horario
SET horario.estatus = 1 
WHERE horario.hora_salida = p_hora_salida AND  horario.hora_llegada = p_hora_llegada AND horario.ruta = p_ruta;
SELECT 'Un registro deshabilitado con los datos ingresados se habilito' AS mensaje, 'success' AS color;
ELSE
UPDATE horario SET
horario.hora_salida = p_hora_salida,
horario.hora_llegada =p_hora_llegada,
horario.ruta = p_ruta
WHERE  horario.id_horario = p_idHorario;
SELECT 'Se actualizo correctamente' AS mensaje, 'success' AS color;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizarRuta
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizarRuta`;
delimiter ;;
CREATE PROCEDURE `SP_actualizarRuta`(p_id_ruta INT,
p_lugar_origen VARCHAR(255),
p_lugar_destino VARCHAR(255))
BEGIN
IF( TRIM(p_lugar_origen) = TRIM(p_lugar_destino))
THEN
SELECT 'Dos campos no pueden tener el mismo valor, INTENTE DE NUEVO'  AS Alerta, 'danger' AS color;
ELSEIF(TRIM(p_lugar_origen) IS NULL OR TRIM(p_lugar_origen) = '')
THEN
SELECT 'No puede estar vacio el campo'  AS Alerta, 'danger' AS color;
ELSEIF(TRIM(p_lugar_destino) IS NULL OR TRIM(p_lugar_destino) = '')
THEN
SELECT 'No puede estar vacio el campo'  AS Alerta, 'danger' AS color;
ELSEIF EXISTS(SELECT * FROM ruta WHERE ruta.estatus = 1 AND ruta.origen = (SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar = TRIM(p_lugar_origen)) AND ruta.destino = (SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar =TRIM(p_lugar_destino)))
THEN 
SELECT 'Ya existe ese registro, INTENTE DE NUEVO' AS Alerta, 'danger' AS color;
ELSEIF EXISTS(SELECT ruta.id_ruta FROM ruta WHERE ruta.estatus = 0 AND ruta.origen = (SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar = TRIM(p_lugar_origen)) AND ruta.destino = (SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar = TRIM(p_lugar_destino)))
THEN 
SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar= TRIM(p_lugar_origen) INTO p_lugar_origen;
SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar= TRIM(p_lugar_destino) INTO p_lugar_destino;
UPDATE ruta
SET ruta.estatus = 1
WHERE ruta.origen = TRIM(p_lugar_origen) AND ruta.destino = TRIM(p_lugar_destino);
SELECT 'Un registro deshabilitado con los datos ingresados se habilito' AS Alerta, 'success' AS color;
ELSE
SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar= TRIM(p_lugar_origen) INTO p_lugar_origen;
SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar= TRIM(p_lugar_destino) INTO p_lugar_destino;
UPDATE ruta  
SET 
ruta.origen = TRIM(p_lugar_origen),
ruta.destino = TRIM(p_lugar_destino) 
WHERE ruta.id_ruta = p_id_ruta;
SELECT 'Se actualizo correctamente' AS Alerta, 'success' AS color;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizarUsuarioAdmin
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizarUsuarioAdmin`;
delimiter ;;
CREATE PROCEDURE `SP_actualizarUsuarioAdmin`(p_id_usuario INT,
    p_nombre_usuario VARCHAR(255),
    p_apellido_paterno VARCHAR(255),
    p_apellido_materno VARCHAR(255),
    p_user VARCHAR(255),
    p_correo VARCHAR(255),
    p_contrasenia VARCHAR(255),

    p_id_rol VARCHAR(255),
    p_estatus CHAR(1))
BEGIN
    IF (p_id_usuario = 1) THEN
        SELECT 'NO SE PUEDEN CAMBIAR LOS VALORES DEL ADMINISTRADOR PRINCIPAL' AS mensaje, 'danger' AS color;
    ELSE
        IF (
            TRIM(p_nombre_usuario) IS NULL OR TRIM(p_nombre_usuario) = '' OR
            TRIM(p_apellido_paterno) IS NULL OR TRIM(p_apellido_paterno) = '' OR
            TRIM(p_apellido_materno) IS NULL OR TRIM(p_apellido_materno) = '' OR
            TRIM(p_user) IS NULL OR TRIM(p_user) = '' OR
            TRIM(p_correo) IS NULL OR TRIM(p_correo) = '' OR
            TRIM(p_contrasenia) IS NULL OR TRIM(p_contrasenia) = '' OR
            TRIM(p_id_rol) IS NULL OR TRIM(p_id_rol) = '' OR
            TRIM(p_estatus) IS NULL OR TRIM(p_estatus) = ''
        ) THEN
            SELECT 'Este registro no puede tener campos vacíos, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
        ELSEIF EXISTS(
            SELECT *
            FROM usuario
            WHERE
                usuario.nombre_usuario = TRIM(p_nombre_usuario) AND
                usuario.apellidoPaterno = TRIM(p_apellido_paterno) AND
                usuario.apellidoMaterno = TRIM(p_apellido_materno) AND
                usuario.user = TRIM(p_user) AND
                usuario.correo = TRIM(p_correo) AND
                usuario.id_usuario <> p_id_usuario
        ) THEN
            SELECT 'Los datos ingresados ya han sido registrados, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
        ELSEIF EXISTS(
            SELECT *
            FROM usuario
            WHERE usuario.user = TRIM(p_user) AND usuario.id_usuario <> p_id_usuario
        ) THEN
            SELECT 'El usuario ingresado ya fue registrado, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
        ELSEIF EXISTS(
            SELECT *
            FROM usuario
            WHERE usuario.correo = TRIM(p_correo) AND usuario.id_usuario <> p_id_usuario
        ) THEN
            SELECT 'El correo ingresado ya fue registrado, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
        ELSE
            SELECT rol.id_rol INTO p_id_rol
            FROM rol
            WHERE rol.rol = TRIM(p_id_rol);
            
            UPDATE usuario
            SET
                nombre_usuario = TRIM(p_nombre_usuario),
                apellidoPaterno = TRIM(p_apellido_paterno),
                apellidoMaterno = TRIM(p_apellido_materno),
                user = TRIM(p_user),
                correo = TRIM(p_correo),
                contrasenia = TRIM(p_contrasenia),

                rol = TRIM(p_id_rol),
                estatus = TRIM(p_estatus)
            WHERE id_usuario = p_id_usuario;
            
            SELECT 'Se actualizó correctamente' AS mensaje, 'success' AS color;
        END IF;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_lugar
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_lugar`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_lugar`(p_idL INT,
  nuevoNombre VARCHAR(255))
BEGIN
  IF EXISTS(SELECT * FROM lugar WHERE lugar.estatus = 1 AND TRIM(lugar.nombre_lugar) = TRIM(nuevoNombre))
  THEN 
    SELECT 'Ya existe ese registro, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
  ELSEIF EXISTS(SELECT lugar.id_lugares FROM lugar WHERE lugar.estatus = 0 AND TRIM(lugar.nombre_lugar) = TRIM(nuevoNombre))
  THEN 
    UPDATE lugar 
    SET lugar.estatus = 1
    WHERE TRIM(lugar.nombre_lugar) = TRIM(nuevoNombre);
    SELECT 'Un registro deshabilitado con los datos ingresados se habilitó' AS mensaje, 'success' AS color;
  ELSEIF (TRIM(nuevoNombre) IS NULL OR TRIM(nuevoNombre) = '')
  THEN
    SELECT 'No puede estar vacío el campo, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
  ELSE
    UPDATE lugar
    SET lugar.nombre_lugar = TRIM(nuevoNombre)
    WHERE lugar.id_lugares = p_idL;
    SELECT 'Se actualizó correctamente' AS mensaje, 'success' AS color;
  END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_parada
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_parada`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_parada`(p_id_parada INT,
    p_nombre_parada VARCHAR(255),
    p_ruta INT)
BEGIN
    IF TRIM(p_nombre_parada) = '' THEN
        SELECT 'Este registro no puede estar vacio, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
    ELSEIF EXISTS(SELECT * FROM parada WHERE parada.estatus = 1 AND parada.nombre_parada = TRIM(p_nombre_parada) AND parada.ruta = p_ruta) THEN 
        SELECT 'Ya existe ese registro, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
    ELSEIF EXISTS(SELECT parada.id_parada FROM parada WHERE parada.estatus = 0 AND parada.nombre_parada = TRIM(p_nombre_parada) AND parada.ruta = p_ruta) THEN 
        UPDATE parada 
        SET parada.estatus = 1
        WHERE parada.nombre_parada = TRIM(p_nombre_parada);
        SELECT 'Un registro deshabilitado con los datos ingresados se habilito' AS mensaje, 'success' AS color;
    ELSE 
        UPDATE parada 
        SET 
            parada.nombre_parada = p_nombre_parada,
            parada.ruta = p_ruta
        WHERE parada.id_parada = p_id_parada;
        SELECT 'Se actualizo correctamente exitosamente.' AS mensaje, 'success' AS color;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_tarifa
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_tarifa`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_tarifa`(p_id_tarifa INT, p_precio_tarifa DOUBLE, p_ruta_tarifa INT, p_parada_tarifa INT)
BEGIN
    IF EXISTS (SELECT * FROM tarifa WHERE parada = p_parada_tarifa AND ruta = p_ruta_tarifa AND precio_boleto = p_precio_tarifa AND estatus = 1) THEN 
        SELECT 'Ya hay un registro similar, intentalo nuevamente' AS mensaje, 'danger' AS color;
    ELSEIF EXISTS (SELECT * FROM tarifa WHERE parada = p_parada_tarifa AND ruta = p_ruta_tarifa AND precio_boleto = p_precio_tarifa AND estatus = 0) THEN 
        SELECT 'Registro habilitado nuevamente' AS mensaje, 'warning' AS color;
    UPDATE tarifa SET estatus = 1 WHERE parada = p_parada_tarifa AND ruta = p_ruta_tarifa AND precio_boleto = p_precio_tarifa AND estatus = 0;
    ELSE 
        UPDATE tarifa SET precio_boleto = p_precio_tarifa, ruta = p_ruta_tarifa, parada = p_parada_tarifa, estatus = 1 WHERE id_tarifa = p_id_tarifa;
        SELECT 'Registro creado exitosamente' AS mensaje, 'success' AS color;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_eliminarHorario
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_eliminarHorario`;
delimiter ;;
CREATE PROCEDURE `SP_eliminarHorario`(p_idHorario INT)
BEGIN 
UPDATE horario SET horario.estatus = 0
WHERE horario.id_horario = p_idHorario;
SELECT 'Se elimino correctamente' AS mensaje, 'danger' AS color;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_eliminarRuta
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_eliminarRuta`;
delimiter ;;
CREATE PROCEDURE `SP_eliminarRuta`(p_idRuta INT)
BEGIN 
UPDATE ruta SET ruta.estatus = 0
WHERE ruta.id_ruta = p_idRuta;
SELECT 'Se elimino correctamente' AS Alerta, 'danger' AS color;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_eliminarUsuarioAdmin
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_eliminarUsuarioAdmin`;
delimiter ;;
CREATE PROCEDURE `SP_eliminarUsuarioAdmin`(p_id_usuario INT)
BEGIN 
    IF (p_id_usuario = 1) THEN
        SELECT 'NO PUEDES ELIMINAR AL ADMINISTRADOR PRINCIPAL' AS mensaje, 'danger' AS color;
    ELSE
        UPDATE usuario SET estatus = 0 WHERE id_usuario = p_id_usuario;
        SELECT 'Se eliminó correctamente' AS mensaje, 'success' AS color;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_eliminar_lugar
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_eliminar_lugar`;
delimiter ;;
CREATE PROCEDURE `SP_eliminar_lugar`(p_id_lugar INT)
BEGIN 
UPDATE lugar SET lugar.estatus = 0
WHERE lugar.id_lugares = p_id_lugar;
SELECT 'Se elimino correctamente' AS mensaje, 'danger' AS color;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_eliminar_parada
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_eliminar_parada`;
delimiter ;;
CREATE PROCEDURE `SP_eliminar_parada`(p_idParada INT)
BEGIN 
UPDATE parada SET parada.estatus = 0 WHERE parada.id_parada = p_idParada;
SELECT 'Registro eliminado correctamente' AS mensaje, 'success' AS color;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_eliminar_tarifa
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_eliminar_tarifa`;
delimiter ;;
CREATE PROCEDURE `SP_eliminar_tarifa`(p_id_tarifa INT)
BEGIN 
UPDATE tarifa SET tarifa.estatus = 0 WHERE tarifa.id_tarifa = p_id_tarifa;
SELECT 'Registro eliminado correctamente' AS mensaje, 'success' AS color;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_insertarHorario
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_insertarHorario`;
delimiter ;;
CREATE PROCEDURE `SP_insertarHorario`(p_hora_salida TIME,
p_hora_llegada TIME,
p_ruta INT)
BEGIN
IF (p_hora_salida = p_hora_llegada)
THEN
SELECT 'Las horas no pueden ser las mismas' AS mensaje, 'danger' AS color;
ELSEIF EXISTS(SELECT * FROM horario WHERE horario.estatus = 1 AND horario.hora_salida = p_hora_salida AND horario.hora_llegada = p_hora_llegada AND horario.ruta = p_ruta)
THEN 
SELECT 'Ya existe ese registro, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
ELSEIF EXISTS(SELECT * FROM horario WHERE horario.estatus = 0 AND horario.hora_salida = p_hora_salida AND horario.hora_llegada = p_hora_llegada AND horario.ruta = p_ruta)
THEN 
UPDATE horario
SET horario.estatus = 1 
WHERE horario.hora_salida = p_hora_salida AND  horario.hora_llegada = p_hora_llegada AND horario.ruta = p_ruta;
SELECT 'Un registro deshabilitado con los datos ingresados se habilito' AS mensaje, 'success' AS color;
ELSE
INSERT horario VALUES(
DEFAULT,
p_hora_salida,
p_hora_llegada,
DEFAULT,
p_ruta);
SELECT 'Se registro correctamente' AS mensaje, 'success' AS color;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_insertarRuta
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_insertarRuta`;
delimiter ;;
CREATE PROCEDURE `SP_insertarRuta`(p_lugar_origen VARCHAR(255),
p_lugar_destino VARCHAR(255))
BEGIN
IF( TRIM(p_lugar_origen) = TRIM(p_lugar_destino))
THEN
SELECT 'Dos campos no pueden tener el mismo valor, INTENTE DE NUEVO'  AS Alerta, 'danger' AS color;
ELSEIF(TRIM(p_lugar_origen) IS NULL OR TRIM(p_lugar_origen) = '')
THEN
SELECT 'No puede estar vacio el campo'  AS Alerta, 'danger' AS color;
ELSEIF(TRIM(p_lugar_destino) IS NULL OR TRIM(p_lugar_destino) = '')
THEN
SELECT 'No puede estar vacio el campo'  AS Alerta, 'danger' AS color;
ELSEIF EXISTS(SELECT * FROM ruta WHERE ruta.estatus = 1 AND ruta.origen = (SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar = TRIM(p_lugar_origen)) AND ruta.destino = (SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar
= TRIM(p_lugar_destino)))
THEN 
SELECT 'Ya existe ese registro, INTENTE DE NUEVO' AS Alerta, 'danger' AS color;
ELSEIF EXISTS(SELECT ruta.id_ruta FROM ruta WHERE ruta.estatus = 0 AND ruta.origen = (SELECT lugar.id_lugares FROM lugar WHERE 
lugar.nombre_lugar = TRIM(p_lugar_origen)) AND ruta.destino = (SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar = TRIM(p_lugar_destino)))
THEN 
SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar = TRIM(p_lugar_origen) INTO p_lugar_origen;
SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar = TRIM(p_lugar_destino) INTO p_lugar_destino;
UPDATE ruta
SET ruta.estatus = 1
WHERE ruta.origen = TRIM(p_lugar_origen) AND ruta.destino = TRIM(p_lugar_destino);
SELECT 'Un registro deshabilitado con los datos ingresados se habilito' AS Alerta, 'success' AS color;
ELSE 
INSERT ruta VALUES(
DEFAULT,
(SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar = TRIM(p_lugar_origen)),
(SELECT lugar.id_lugares FROM lugar WHERE lugar.nombre_lugar = TRIM(p_lugar_destino)),
DEFAULT);
SELECT 'Se registro correctamente' AS Alerta, 'success' AS color;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_insertarUsuarioAdmin
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_insertarUsuarioAdmin`;
delimiter ;;
CREATE PROCEDURE `SP_insertarUsuarioAdmin`(p_nombre_usuario VARCHAR(255), 
p_apellido_paterno VARCHAR(255), 
p_apellido_materno VARCHAR(255),
p_user VARCHAR(255), 
p_correo VARCHAR(255), 
p_contrasenia VARCHAR(255), 
p_id_rol INT,
p_estatus CHAR(1))
BEGIN
IF(TRIM(p_nombre_usuario) IS NULL OR TRIM(p_nombre_usuario) = '' 
OR TRIM(p_apellido_paterno) IS NULL OR TRIM(p_apellido_paterno) = ''
OR TRIM(p_apellido_materno) IS NULL OR TRIM(p_apellido_materno) = ''
OR TRIM(p_user) IS NULL OR TRIM(p_user) = ''
OR TRIM(p_correo) IS NULL OR TRIM(p_correo) = ''
OR TRIM(p_contrasenia) IS NULL OR TRIM(p_contrasenia) = ''
OR TRIM(p_id_rol) IS NULL OR TRIM(p_id_rol) = ''
OR TRIM(p_estatus) IS NULL OR TRIM(p_estatus) = '')
THEN 
SELECT 'Este registro no puede tener campos vacios, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
ELSEIF EXISTS(SELECT * FROM usuario WHERE 
usuario.nombre_usuario = TRIM(p_nombre_usuario) AND
usuario.apellidoPaterno = TRIM(p_apellido_paterno) AND
usuario.apellidoMaterno = TRIM(p_apellido_materno) AND
usuario.user = TRIM(p_user) AND
usuario.correo = TRIM(p_correo) AND
usuario.rol = TRIM(p_id_rol) AND
usuario.estatus = TRIM(p_estatus))
THEN 
SELECT 'Los datos ingresados ya han sido registrados, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
ELSEIF EXISTS(SELECT * FROM usuario WHERE usuario.user = TRIM(p_user))
THEN
SELECT 'El usuario ingresado ya fue registrado, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
ELSEIF EXISTS(SELECT * FROM usuario WHERE usuario.correo = TRIM(p_correo))
THEN 
SELECT 'El correo ingresado ya fue registrado, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
ELSE
INSERT usuario VALUES (
DEFAULT,
TRIM(p_nombre_usuario),
TRIM(p_apellido_paterno), 
TRIM(p_apellido_materno),
TRIM(p_user),  
TRIM(p_correo), 
TRIM(p_contrasenia),
p_id_rol,
p_estatus);
SELECT 'Se registro correctamente' AS mensaje, 'success' AS color;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_insertar_lugar
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_insertar_lugar`;
delimiter ;;
CREATE PROCEDURE `SP_insertar_lugar`(p_nombre_lugar VARCHAR(255))
BEGIN 
  IF(TRIM(p_nombre_lugar) = '')
  THEN
    SELECT 'Este registro no puede estar vacío, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
  ELSEIF EXISTS(SELECT * FROM lugar WHERE lugar.estatus = 1 AND TRIM(lugar.nombre_lugar) = TRIM(p_nombre_lugar))
  THEN 
    SELECT 'Ya existe ese registro, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
  ELSEIF EXISTS(SELECT lugar.id_lugares FROM lugar WHERE lugar.estatus = 0 AND TRIM(lugar.nombre_lugar) = TRIM(p_nombre_lugar))
  THEN 
    UPDATE lugar 
    SET lugar.estatus = 1
    WHERE TRIM(lugar.nombre_lugar) = TRIM(p_nombre_lugar);
    SELECT 'Un registro deshabilitado con los datos ingresados se habilitó' AS mensaje, 'success' AS color;
  ELSE
    INSERT INTO lugar
    VALUES(
      DEFAULT,
      TRIM(p_nombre_lugar),
      DEFAULT
    );
    SELECT 'Se registró correctamente' AS mensaje, 'success' AS color;
  END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_insertar_parada
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_insertar_parada`;
delimiter ;;
CREATE PROCEDURE `SP_insertar_parada`(p_nombre_parada VARCHAR(255),
p_ruta INT)
BEGIN
IF(TRIM(p_nombre_parada) = '')
THEN
SELECT 'Este registro no puede estar vacio, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
ELSEIF EXISTS(SELECT * FROM parada WHERE parada.estatus = 1 AND parada.nombre_parada = TRIM(p_nombre_parada) AND parada.ruta = p_ruta)
THEN 
SELECT 'Ya existe ese registro, INTENTE DE NUEVO' AS mensaje, 'danger' AS color;
ELSEIF EXISTS(SELECT parada.id_parada FROM parada WHERE parada.estatus = 0 AND parada.nombre_parada = TRIM(p_nombre_parada) AND parada.ruta = p_ruta)
THEN 
UPDATE parada 
SET parada.estatus = 1
WHERE parada.nombre_parada = TRIM(p_nombre_parada);
SELECT 'Un registro deshabilitado con los datos ingresados se habilito' AS mensaje, 'success' AS color;
ELSE 
INSERT parada VALUES(
DEFAULT, 
p_nombre_parada,
DEFAULT, 
p_ruta);
SELECT 'Registro creado exitosamente.' AS mensaje, 'success' AS color;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_insertar_tarifa
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_insertar_tarifa`;
delimiter ;;
CREATE PROCEDURE `SP_insertar_tarifa`(p_precio_tarifa INT, p_ruta_tarifa INT, p_parada_tarifa INT)
BEGIN
    IF EXISTS (SELECT * FROM tarifa WHERE parada = p_parada_tarifa AND ruta = p_ruta_tarifa AND precio_boleto = p_precio_tarifa AND estatus = 1)
    THEN 
        SELECT 'Ya hay un registro similar, intentalo nuevamente' AS mensaje, 'danger' AS color;
    ELSEIF EXISTS (SELECT * FROM tarifa WHERE parada = p_parada_tarifa AND ruta = p_ruta_tarifa AND precio_boleto = p_precio_tarifa AND estatus = 0)
        THEN 
        SELECT 'Registro habilitado nuevamente' AS mensaje, 'warning' AS color;
        UPDATE tarifa SET estatus = 1 WHERE parada = p_parada_tarifa AND ruta = p_ruta_tarifa AND precio_boleto = p_precio_tarifa AND estatus = 0;
		ELSE 
		  INSERT INTO tarifa (precio_boleto, ruta, parada, estatus) VALUES (p_precio_tarifa, p_ruta_tarifa, p_parada_tarifa, 1);
       SELECT 'Registro actualizado exitosamente' AS mensaje, 'success' AS color;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_verificar
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_verificar`;
delimiter ;;
CREATE PROCEDURE `SP_verificar`(email VARCHAR(255),contra VARCHAR(255))
BEGIN
    DECLARE cor VARCHAR(255);
    DECLARE con VARCHAR(255);
    DECLARE ver VARCHAR(8);
    DECLARE usu VARCHAR(255);
    DECLARE ro INT;
    
    SELECT correo INTO cor FROM usuario WHERE correo = email AND estatus = 1;
    -- SELECT cor AS vercorreo;
    
    SELECT contrasenia INTO con FROM usuario WHERE contrasenia = contra AND correo = email;
    -- SELECT con AS vercon;
    
    SELECT nombre_usuario INTO usu FROM usuario WHERE correo = email;
    -- SELECT con AS vercon;
    
    SELECT rol INTO ro FROM usuario WHERE correo = email;
    -- SELECT con AS vercon;
    
    IF cor = email AND con = contra AND LENGTH(email) < 255 THEN
        SET ver = 'acceso';
        SELECT ver AS 'verificacion', usu AS 'usuario', ro AS 'rol';
    ELSE
        SET ver = 'denegado';
        SELECT ver AS 'verificacion', usu AS 'usuario', ro AS 'rol';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_verificar_user
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_verificar_user`;
delimiter ;;
CREATE PROCEDURE `SP_verificar_user`(email VARCHAR(255),contra VARCHAR(255))
BEGIN
    DECLARE cor VARCHAR(255);
    DECLARE con VARCHAR(255);
    DECLARE ver VARCHAR(8);
    DECLARE usu VARCHAR(255);
    DECLARE ro INT;
    
    SELECT correo INTO cor FROM usuario WHERE correo = email AND estatus = 1;
    -- SELECT cor AS vercorreo;
    
    SELECT `user` INTO con FROM usuario WHERE `user` = contra AND correo = email;
    -- SELECT con AS vercon;
    
    SELECT nombre_usuario INTO usu FROM usuario WHERE correo = email;
    -- SELECT con AS vercon;
    
    SELECT rol INTO ro FROM usuario WHERE correo = email;
    -- SELECT con AS vercon;
    
    IF cor = email AND con = contra AND LENGTH(email) < 255 THEN
        SET ver = 'acceso';
        SELECT ver AS 'verificacion', usu AS 'usuario', ro AS 'rol';
    ELSE
        SET ver = 'denegado';
        SELECT ver AS 'verificacion', usu AS 'usuario', ro AS 'rol';
    END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
