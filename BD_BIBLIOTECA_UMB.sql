/*
 Navicat Premium Data Transfer

 Source Server         : conexion_poderosa
 Source Server Type    : MySQL
 Source Server Version : 100428 (10.4.28-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : finaaaal

 Target Server Type    : MySQL
 Target Server Version : 100428 (10.4.28-MariaDB)
 File Encoding         : 65001

 Date: 02/03/2024 21:56:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for carrera
-- ----------------------------
DROP TABLE IF EXISTS `carrera`;
CREATE TABLE `carrera`  (
  `id_carrera` int NOT NULL AUTO_INCREMENT,
  `nombre_carrera` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_carrera`) USING BTREE,
  INDEX `nombre_carrera`(`nombre_carrera` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for estatus_estudiante
-- ----------------------------
DROP TABLE IF EXISTS `estatus_estudiante`;
CREATE TABLE `estatus_estudiante`  (
  `id_estatus_estudiante` int NOT NULL AUTO_INCREMENT,
  `nombre_estatus_estudiante` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_estatus_estudiante`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for estatus_libro
-- ----------------------------
DROP TABLE IF EXISTS `estatus_libro`;
CREATE TABLE `estatus_libro`  (
  `id_estatus` int NOT NULL AUTO_INCREMENT,
  `nombre_estatus` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_estatus`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for estudiante
-- ----------------------------
DROP TABLE IF EXISTS `estudiante`;
CREATE TABLE `estudiante`  (
  `id_estudiante` int NOT NULL AUTO_INCREMENT,
  `matricula` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nombre_estudiante` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ape_Paterno` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ape_Materno` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_carrera` int NOT NULL,
  `id_semestre` int NOT NULL,
  `id_estatus` int NOT NULL,
  PRIMARY KEY (`id_estudiante`) USING BTREE,
  UNIQUE INDEX `unique_matricula`(`matricula` ASC) USING BTREE,
  INDEX `Fk_carrera`(`id_carrera` ASC) USING BTREE,
  INDEX `Fk_semestre`(`id_semestre` ASC) USING BTREE,
  INDEX `Fk_estatus`(`id_estatus` ASC) USING BTREE,
  CONSTRAINT `Fk_carrera` FOREIGN KEY (`id_carrera`) REFERENCES `carrera` (`id_carrera`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_estatus` FOREIGN KEY (`id_estatus`) REFERENCES `estatus_estudiante` (`id_estatus_estudiante`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_semestre` FOREIGN KEY (`id_semestre`) REFERENCES `semestre` (`id_semestre`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for libros
-- ----------------------------
DROP TABLE IF EXISTS `libros`;
CREATE TABLE `libros`  (
  `id_libro` int NOT NULL AUTO_INCREMENT,
  `no_inventario` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_carrera` int NOT NULL,
  `codigo_barras` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `titulo_libro` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `autor_libro` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `editorial_libro` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `anio_libro` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `edicion_libro` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fecha_libro` date NOT NULL,
  `id_estatus` int NOT NULL,
  PRIMARY KEY (`id_libro`) USING BTREE,
  UNIQUE INDEX `unique_noInventario`(`no_inventario` ASC) USING BTREE,
  INDEX `Fk_carreraLibro`(`id_carrera` ASC) USING BTREE,
  INDEX `Fk_estatusLibro`(`id_estatus` ASC) USING BTREE,
  CONSTRAINT `Fk_carreraLibro` FOREIGN KEY (`id_carrera`) REFERENCES `carrera` (`id_carrera`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_estatusLibro` FOREIGN KEY (`id_estatus`) REFERENCES `estatus_libro` (`id_estatus`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9903 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for prestamo
-- ----------------------------
DROP TABLE IF EXISTS `prestamo`;
CREATE TABLE `prestamo`  (
  `id_prestamo` int NOT NULL AUTO_INCREMENT,
  `no_inventario` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `matricula` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fecha` date NOT NULL,
  `fecha_entrega` date NOT NULL,
  `estatus` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_prestamo`) USING BTREE,
  INDEX `Fk_matricula`(`matricula` ASC) USING BTREE,
  INDEX `Fk_noInventario`(`no_inventario` ASC) USING BTREE,
  CONSTRAINT `Fk_matricula` FOREIGN KEY (`matricula`) REFERENCES `estudiante` (`matricula`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_noInventario` FOREIGN KEY (`no_inventario`) REFERENCES `libros` (`no_inventario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1928 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol`  (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `rol` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `estatus` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_rol`) USING BTREE,
  UNIQUE INDEX `unique_rol`(`rol` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for semestre
-- ----------------------------
DROP TABLE IF EXISTS `semestre`;
CREATE TABLE `semestre`  (
  `id_semestre` int NOT NULL AUTO_INCREMENT,
  `nombre_semestre` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_semestre`) USING BTREE,
  INDEX `nombre_semestre`(`nombre_semestre` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario`  (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apellidoPaterno` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apellidoMaterno` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `correo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `contrasenia` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rol` int NOT NULL,
  `estatus` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_usuario`) USING BTREE,
  UNIQUE INDEX `unique_correo`(`correo` ASC) USING BTREE,
  INDEX `Fk_rol`(`rol` ASC) USING BTREE,
  CONSTRAINT `Fk_rol` FOREIGN KEY (`rol`) REFERENCES `rol` (`id_rol`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Procedure structure for SP_actualizarEstudiante
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizarEstudiante`;
delimiter ;;
CREATE PROCEDURE `SP_actualizarEstudiante`(p_id_estudiante INT,
p_matricula VARCHAR(255),
p_nombre_estudiante VARCHAR(255), 
p_ape1 VARCHAR(255),
p_ape2 VARCHAR(255),
p_carrera INT,
p_semestre INT)
BEGIN
DECLARE id_estudianteConsulta INT;
DECLARE matricula_estudianteConsulta VARCHAR(255);

    -- Recuperar 'id_estudiante' a partir de la matricula recuperada
    SELECT estudiante.id_estudiante INTO id_estudianteConsulta FROM estudiante WHERE 
           TRIM(estudiante.matricula) = TRIM(p_matricula) AND estudiante.id_estatus != 3;
					 
		-- Recuperar 'matricula' a partir del id recuperado
		SELECT TRIM(estudiante.matricula) INTO matricula_estudianteConsulta FROM estudiante WHERE 
           estudiante.id_estudiante = id_estudianteConsulta AND estudiante.id_estatus != 3;
					 
IF(TRIM(p_matricula) IS NULL OR TRIM(p_matricula) = '')
THEN
SELECT 'No puede estar vacio el campo MATRICULA' as mensaje, 'danger' as color;
ELSEIF(TRIM(p_nombre_estudiante) IS NULL OR TRIM(p_nombre_estudiante) = '')
THEN
SELECT 'No puede estar vacio el campo NOMBRE' as mensaje, 'danger' as color;
ELSEIF(TRIM(p_ape1) IS NULL OR TRIM(p_ape1) = '')
THEN
SELECT 'No puede estar vacio el campo APELLIDO PATERNO' as mensaje, 'danger' as color;
ELSEIF(TRIM(p_ape2) IS NULL OR TRIM(p_ape2) = '')
THEN
SELECT 'No puede estar vacio el campo APELLIDO MATERNO' as mensaje, 'danger' as color;
ELSEIF EXISTS(SELECT TRIM(estudiante.matricula) FROM estudiante WHERE 
TRIM(estudiante.matricula) = TRIM(p_matricula) AND estudiante.id_estatus = 3)
THEN 
UPDATE estudiante SET estudiante.id_estatus = 1
WHERE TRIM(estudiante.matricula) = TRIM(p_matricula);
SELECT 'Un registro deshabilitado con los datos ingresados se habilito' as mensaje, 'warning' as color;
ELSEIF(id_estudianteConsulta != p_id_estudiante AND TRIM(matricula_estudianteConsulta) = TRIM(p_matricula))
THEN 
SELECT 'Esa MATRICULA le pertenece a otro registro' as mensaje, 'warning' as color;
ELSE 
UPDATE estudiante 
SET 
estudiante.matricula = UPPER(TRIM(p_matricula)),
estudiante.nombre_estudiante = UPPER(TRIM(p_nombre_estudiante)),
estudiante.ape_Paterno = UPPER(TRIM(p_ape1)),
estudiante.ape_Materno = UPPER(TRIM(p_ape2)),
estudiante.id_carrera = (SELECT carrera.id_carrera FROM carrera WHERE carrera.id_carrera = TRIM(p_carrera)), 
estudiante.id_semestre = (SELECT semestre.id_semestre FROM semestre WHERE semestre.id_semestre = p_semestre)
WHERE estudiante.id_estudiante = p_id_estudiante;
SELECT 'Se actualizo correctamente' as mensaje, 'success' as color;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizarLibro
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizarLibro`;
delimiter ;;
CREATE PROCEDURE `SP_actualizarLibro`(p_id_libro INT,
    p_no_inventario VARCHAR(255),
    p_id_carrera VARCHAR(255),
    p_codigo_barras VARCHAR(255),
    p_titulo_libro VARCHAR(255),
    p_autor_libro VARCHAR(255),
    p_editorial_libro VARCHAR(255),
    p_anio_libro VARCHAR(100),
    p_edicion_libro VARCHAR(100),
    p_fecha_libro DATE)
BEGIN
    DECLARE carrera_id INT;
    SELECT id_carrera INTO carrera_id FROM carrera WHERE carrera.id_carrera = p_id_carrera;

    IF (TRIM(p_no_inventario) IS NULL OR TRIM(p_no_inventario) = '')
    THEN
        SELECT 'No puede estar vacío el campo de N° DE INVENTARIO' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_codigo_barras) IS NULL OR TRIM(p_codigo_barras) = '')
    THEN
        SELECT 'No puede estar vacío el campo de CODIGO DE BARRAS' AS mensaje, 'danger' AS color;
  ELSEIF (TRIM(p_titulo_libro) IS NULL OR TRIM(p_titulo_libro) = '')
    THEN
        SELECT 'No puede estar vacío el campo TITULO DE LIBRO' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_autor_libro) IS NULL OR TRIM(p_autor_libro) = '')
    THEN
        SELECT 'No puede estar vacío el campo AUTOR' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_editorial_libro) IS NULL OR TRIM(p_editorial_libro) = '')
    THEN
        SELECT 'No puede estar vacío el campo EDITORIAL' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_anio_libro) IS NULL OR TRIM(p_anio_libro) = '')
    THEN
        SELECT 'No puede estar vacío el campo AÑO' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_edicion_libro) IS NULL OR TRIM(p_edicion_libro) = '')
    THEN
        SELECT 'No puede estar vacío el campo EDICION' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_fecha_libro) IS NULL OR TRIM(p_fecha_libro) = '')
    THEN
        SELECT 'No puede estar vacío el campo FECHA' AS mensaje, 'danger' AS color;
    ELSEIF EXISTS(SELECT 1 FROM libros WHERE no_inventario = p_no_inventario AND id_libro <> p_id_libro AND id_estatus = 1)
    THEN
        SELECT 'El N° INVENTARIO ya se encuentra registrado en la base de datos' AS mensaje, 'warning' AS color;
    ELSE
        UPDATE libros 
 SET 
            no_inventario = UPPER(TRIM(p_no_inventario)),
            id_carrera = carrera_id,
            codigo_barras = UPPER(TRIM(p_codigo_barras)),
            titulo_libro = UPPER(TRIM(p_titulo_libro)),
            autor_libro = UPPER(TRIM(p_autor_libro)),
            editorial_libro = UPPER(TRIM(p_editorial_libro)), 
            anio_libro = UPPER(TRIM(p_anio_libro)),
            edicion_libro = UPPER(TRIM(p_edicion_libro)),
            fecha_libro = UPPER(TRIM(p_fecha_libro)),
            id_estatus = 1
        WHERE id_libro = p_id_libro;
        
        SELECT 'Se actualizó correctamente' AS mensaje, 'success' AS color;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizarPrestamo
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizarPrestamo`;
delimiter ;;
CREATE PROCEDURE `SP_actualizarPrestamo`(p_id_prestamo INT,
p_fecha_entrega DATE)
BEGIN
    DECLARE fechaActual DATE;
    SELECT CURDATE() INTO fechaActual;
IF EXISTS(SELECT fecha_entrega FROM prestamo WHERE prestamo.id_prestamo = p_id_prestamo AND 
p_fecha_entrega < prestamo.fecha_entrega)
THEN
SELECT 'La actualizacion de la fecha debe ser mayor a la fecha de entrega anterior' AS msg, 'danger' as color;
ELSEIF  p_fecha_entrega <= fechaActual 
THEN
SELECT 'La fecha de entrega debe ser mayor a la fecha de hoy' AS msg, 'danger' as color;
ELSE
UPDATE prestamo SET prestamo.fecha_entrega = p_fecha_entrega WHERE prestamo.id_prestamo = p_id_prestamo;
SELECT 'Se realizo la actualizacion de la fecha de entrega correctamente' AS msg, 'success' as color;
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
-- Procedure structure for SP_buscarAlumno
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_buscarAlumno`;
delimiter ;;
CREATE PROCEDURE `SP_buscarAlumno`(p_matricula VARCHAR(255))
BEGIN
SELECT estudiante.matricula, 
CONCAT(estudiante.nombre_estudiante, ' ', estudiante.ape_Paterno, ' ', estudiante.ape_Materno), 
carrera.nombre_carrera, 
semestre.nombre_semestre 
FROM estudiante
INNER JOIN carrera
ON estudiante.id_carrera = carrera.id_carrera
INNER JOIN semestre
ON estudiante.id_semestre = semestre.id_semestre
WHERE estudiante.matricula = p_matricula
AND estudiante.id_estatus = 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_buscarLibro
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_buscarLibro`;
delimiter ;;
CREATE PROCEDURE `SP_buscarLibro`(p_no_inve VARCHAR(255))
BEGIN
SELECT libros.no_inventario, libros.titulo_libro, libros.autor_libro, libros.editorial_libro, 
carrera.nombre_carrera 
FROM libros
INNER JOIN carrera
ON libros.id_carrera = carrera.id_carrera
WHERE libros.no_inventario = p_no_inve
AND libros.id_estatus = 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_buscarLibros
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_buscarLibros`;
delimiter ;;
CREATE PROCEDURE `SP_buscarLibros`(p_no_inventario VARCHAR(255))
BEGIN 
    DECLARE v_no_inventario VARCHAR(255);
    DECLARE v_titulo_libro VARCHAR(255);
    DECLARE v_nombre_estatus VARCHAR(255);
    DECLARE v_color VARCHAR(255);
		DECLARE v_nombre_carrera VARCHAR(255);
		DECLARE v_autor_libro VARCHAR(255);
		DECLARE v_editorial_libro VARCHAR(255);
		DECLARE v_anio_libro VARCHAR(255);
		

    SELECT no_inventario, titulo_libro, nombre_estatus, nombre_carrera, autor_libro, editorial_libro, anio_libro
    INTO v_no_inventario, v_titulo_libro, v_nombre_estatus, v_nombre_carrera, v_autor_libro, v_editorial_libro, v_anio_libro
    FROM libros 
    INNER JOIN estatus_libro ON libros.id_estatus = estatus_libro.id_estatus
		INNER JOIN carrera ON libros.id_carrera = carrera.id_carrera
    WHERE no_inventario LIKE CONCAT('%', p_no_inventario, '%')
    ORDER BY id_libro ASC LIMIT 1;

    -- Lógica condicional para determinar el color
    CASE v_nombre_estatus
        WHEN 'Disponible' THEN SET v_color = 'success';
        WHEN 'Prestado' THEN SET v_color = 'warning';
        WHEN 'Baja' THEN SET v_color = 'danger';
        ELSE SET v_color = NULL; -- Puedes cambiar esto según tus necesidades
    END CASE;

    -- Seleccionar el color
    SELECT v_no_inventario as no_inventario, v_titulo_libro as titulo_libro, v_nombre_estatus as estatus, v_color AS color,
		v_nombre_carrera as nombre_carrera, v_autor_libro as autor_libro, v_editorial_libro as editorial_libro, v_anio_libro as anio;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_buscarUsuarios
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_buscarUsuarios`;
delimiter ;;
CREATE PROCEDURE `SP_buscarUsuarios`(p_matricula VARCHAR(255))
BEGIN 
    DECLARE v_matricula VARCHAR(255);
    DECLARE v_nombre_estudiante VARCHAR(255);
    DECLARE v_ape_Paterno VARCHAR(255);
    DECLARE v_ape_Materno VARCHAR(255);
    DECLARE v_nombre_carrera VARCHAR(255);
    DECLARE v_nombre_semestre VARCHAR(255);
    DECLARE v_nombre_estatus_estudiante VARCHAR(255);
    DECLARE v_color VARCHAR(255);
		DECLARE v_numero_de_prestamos_vigentes INT;
		DECLARE v_numero_de_prestamos_vencidos INT;
		DECLARE v_mensaje VARCHAR(255);
		
SELECT matricula, nombre_estudiante, ape_Paterno, ape_Materno, nombre_carrera, nombre_semestre, 
   estatus_estudiante.nombre_estatus_estudiante
INTO v_matricula, v_nombre_estudiante, v_ape_Paterno, v_ape_Materno, v_nombre_carrera, v_nombre_semestre, v_nombre_estatus_estudiante
    FROM estudiante 
    INNER JOIN carrera ON estudiante.id_carrera = carrera.id_carrera
    INNER JOIN semestre ON estudiante.id_semestre = semestre.id_semestre
		INNER JOIN estatus_estudiante ON estatus_estudiante.id_estatus_estudiante = estudiante.id_estatus
    WHERE matricula LIKE CONCAT('%', p_matricula, '%')
    ORDER BY id_estudiante ASC LIMIT 1;

-- Lógica condicional para determinar el color
SELECT COUNT(TRIM(v_matricula)) FROM prestamo WHERE prestamo.estatus = 1 AND CURDATE() >= prestamo.fecha_entrega INTO v_numero_de_prestamos_vencidos;

SELECT COUNT(TRIM(v_matricula)) FROM prestamo WHERE prestamo.estatus = 1 AND CURDATE() <= prestamo.fecha_entrega INTO v_numero_de_prestamos_vigentes;
		
IF v_numero_de_prestamos_vencidos  >= 1 
THEN 
SET v_mensaje = 'Tiene un prestamo vencido este alumno, no puede crear otro prestamo';
    CASE v_nombre_estatus_estudiante
      WHEN 'Vigente' THEN SET v_color = 'success';
        WHEN 'En prestamo' THEN SET v_color = 'success';
        WHEN 'Dado De Baja' THEN SET v_color = 'danger';
        ELSE SET v_color = NULL; -- Puedes cambiar esto según tus necesidades
    END CASE;
ELSEIF v_numero_de_prestamos_vigentes >= 1 AND v_numero_de_prestamos_vigentes <= 4
THEN 
SET v_mensaje = 'Aun puede hacer otro prestamo';
 CASE v_nombre_estatus_estudiante
        WHEN 'Vigente' THEN SET v_color = 'success';
        WHEN 'En prestamo' THEN SET v_color = 'success';
        WHEN 'Dado De Baja' THEN SET v_color = 'danger';
        ELSE SET v_color = NULL; -- Puedes cambiar esto según tus necesidades
    END CASE;
ELSEIF v_numero_de_prestamos_vigentes = 5
THEN 
SET v_mensaje ='Ya tiene 5 pretamos';
CASE v_nombre_estatus_estudiante
        WHEN 'Vigente' THEN SET v_color = 'success';
        WHEN 'En prestamo' THEN SET v_color = 'success';
        WHEN 'Dado De Baja' THEN SET v_color = 'danger';
        ELSE SET v_color = NULL; -- Puedes cambiar esto según tus necesidades
    END CASE;
ELSE 
SET v_mensaje ='No tiene ningun prestamo';
CASE v_nombre_estatus_estudiante
        WHEN 'Vigente' THEN SET v_color = 'success';
        WHEN 'En prestamo' THEN SET v_color = 'success';
        WHEN 'Dado De Baja' THEN SET v_color = 'danger';
        ELSE SET v_color = NULL; -- Puedes cambiar esto según tus necesidades
    END CASE;
END IF;


    -- Seleccionar el color
    SELECT v_matricula, v_nombre_estudiante, v_ape_Paterno, v_ape_Materno,
        v_nombre_carrera, v_nombre_semestre, v_nombre_estatus_estudiante, v_color, v_mensaje;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_crearPrestamo
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_crearPrestamo`;
delimiter ;;
CREATE PROCEDURE `SP_crearPrestamo`(p_no_inventario VARCHAR(255),
p_matricula VARCHAR(255),
p_fecha_entrega DATE)
BEGIN
DECLARE fechaActual DATE;
SELECT CURDATE() INTO fechaActual;
IF EXISTS(SELECT id_estatus FROM libros WHERE no_inventario = TRIM(p_no_inventario) AND id_estatus = 2)
THEN
SELECT 'Este libro ya fue prestado' AS mensaje, 'danger' AS color;
ELSEIF EXISTS(SELECT id_estatus FROM libros WHERE no_inventario = TRIM(p_no_inventario) AND id_estatus = 3)
THEN
SELECT 'Este libro ya fue dado de baja' AS mensaje, 'danger' AS color;
ELSEIF NOT EXISTS(SELECT no_inventario FROM libros WHERE no_inventario = TRIM(p_no_inventario))
THEN
SELECT 'No existe ese numero de inventario' AS mensaje, 'danger' AS color;
ELSEIF EXISTS(SELECT id_estatus FROM estudiante WHERE matricula = TRIM(p_matricula) AND id_estatus = 3)
THEN
SELECT 'Este alumno esta dado de baja' AS mensaje, 'danger' AS color;
ELSEIF  NOT EXISTS(SELECT matricula FROM estudiante WHERE matricula = TRIM(p_matricula))
THEN
SELECT 'No existe esa matricula' AS mensaje, 'danger' AS color;
ELSEIF EXISTS(SELECT * FROM prestamo WHERE no_inventario = TRIM(p_no_inventario) AND 
matricula = TRIM(p_matricula) 
AND fecha_entrega = p_fecha_entrega)
THEN
SELECT 'Ya existe este prestamo' AS mensaje, 'danger' AS color;
ELSEIF p_fecha_entrega <= fechaActual 
THEN
SELECT 'La fecha de entrega debe ser mayor a la fecha de hoy' AS mensaje, 'danger' AS color;
ELSEIF EXISTS((SELECT id_prestamo, fecha_entrega FROM prestamo WHERE 
prestamo.matricula = TRIM(p_matricula) AND
CURDATE() >= prestamo.fecha_entrega AND
prestamo.estatus = 1))
THEN
SELECT 'Tiene un prestamo vencido este alumno, no puede crear otro prestamo' AS mensaje, 'danger' AS color;
ELSEIF ((SELECT COUNT(TRIM(p_matricula)) FROM prestamo WHERE prestamo.estatus = 1) >= 5)
THEN
SELECT 'El alumno ya tiene 5 prestamos, es el limite de prestamos' AS mensaje, 'danger' AS color;
ELSE
INSERT INTO prestamo VALUES (
DEFAULT,
UPPER(TRIM(p_no_inventario)),
UPPER(TRIM(p_matricula)),
CURDATE(),
p_fecha_entrega,
1);
UPDATE libros SET id_estatus = 2 WHERE no_inventario = TRIM(p_no_inventario);
UPDATE estudiante SET id_estatus = 2 WHERE matricula = TRIM(p_matricula);
SELECT 'Se realizo prestamo correctamente' AS mensaje, 'success' AS color;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_devolucion
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_devolucion`;
delimiter ;;
CREATE PROCEDURE `SP_devolucion`(p_idPrestamo VARCHAR(10), p_no_inventario VARCHAR(100), p_matricula VARCHAR(100))
BEGIN
    UPDATE prestamo SET estatus = 0 WHERE id_prestamo = p_idPrestamo;
    UPDATE libros SET id_estatus = 1 WHERE no_inventario = p_no_inventario;
    UPDATE estudiante SET id_estatus = 1 WHERE matricula = p_matricula;

    SELECT "El préstamo ha concluido de manera exitosa" AS msg, "success" AS color;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_eliminarEstudiante
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_eliminarEstudiante`;
delimiter ;;
CREATE PROCEDURE `SP_eliminarEstudiante`(p_id_estudiante int)
BEGIN
IF(SELECT estudiante.id_estatus FROM estudiante WHERE estudiante.id_estudiante = p_id_estudiante AND estudiante.id_estatus != 1)
THEN
SELECT 'No se puede eliminar este Estudiante, tiene un PRESTAMO VIGENTE' AS mensaje, 'danger' AS color;
ELSE
UPDATE estudiante SET estudiante.id_estatus = 3
WHERE estudiante.id_estudiante = p_id_estudiante;
SELECT 'Se elimino correctamente' as mensaje, 'success' as color;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_eliminarLibro
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_eliminarLibro`;
delimiter ;;
CREATE PROCEDURE `SP_eliminarLibro`(p_id_libro INT)
BEGIN
    DECLARE estatus_libro INT;

    SELECT id_estatus INTO estatus_libro FROM libros WHERE id_libro = p_id_libro;

    IF (estatus_libro = 2)
    THEN
        SELECT 'No puedes eliminar este libro, se encuentra prestado.' AS mensaje, 'danger' AS color;
    ELSE
        UPDATE libros 
        SET id_estatus = 3 
        WHERE id_libro = p_id_libro AND id_estatus = 1;
				SELECT 'Se ha eliminado correctamente este libro' AS mensaje, 'success' AS color;

    END IF;
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
-- Procedure structure for SP_importarLibros
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_importarLibros`;
delimiter ;;
CREATE PROCEDURE `SP_importarLibros`(p_no_inventario VARCHAR(255),
    p_id_carrera INT,
    p_codigo_barras VARCHAR(255),
    p_titulo_libro VARCHAR(255),
    p_autor_libro VARCHAR(255),
    p_editorial_libro VARCHAR(255),
    p_anio_libro VARCHAR(255),
    p_edicion_libro VARCHAR(255),
    p_fecha_libro DATE,
    p_id_estatus INT)
BEGIN
    INSERT INTO libros (
        no_inventario, 
        id_carrera, 
        codigo_barras, 
        titulo_libro, 
        autor_libro, 
        editorial_libro, 
        anio_libro, 
        edicion_libro, 
        fecha_libro, 
        id_estatus
    )
    SELECT
        p_no_inventario, 
        p_id_carrera, 
        p_codigo_barras, 
        p_titulo_libro, 
        p_autor_libro, 
        p_editorial_libro, 
        p_anio_libro, 
        p_edicion_libro, 
        p_fecha_libro, 
        p_id_estatus
    FROM (SELECT 1) AS dummy
    LEFT JOIN libros ON libros.no_inventario = p_no_inventario
    WHERE libros.no_inventario IS NULL;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_insertarEstudiante
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_insertarEstudiante`;
delimiter ;;
CREATE PROCEDURE `SP_insertarEstudiante`(p_matricula VARCHAR(255),
p_nombre_estudiante VARCHAR(255), 
p_ape1 VARCHAR(255),
p_ape2 VARCHAR(255),
p_carrera INT,
p_semestre INT)
BEGIN
IF(TRIM(p_matricula) IS NULL OR TRIM(p_matricula) = '')
THEN
SELECT 'No puede estar vacio el campo MATRICULA' as mensaje, 'danger' as color;
ELSEIF(TRIM(p_nombre_estudiante) IS NULL OR TRIM(p_nombre_estudiante) = '')
THEN
SELECT 'No puede estar vacio el campo NOMBRE' as mensaje, 'danger' as color;
ELSEIF(TRIM(p_ape1) IS NULL OR TRIM(p_ape1) = '')
THEN
SELECT 'No puede estar vacio el campo APELLIDO PATERNO' as mensaje, 'danger' as color;
ELSEIF(TRIM(p_ape2) IS NULL OR TRIM(p_ape2) = '')
THEN
SELECT 'No puede estar vacio el campo APELLIDO MATERNO' as mensaje, 'danger' as color;
ELSEIF EXISTS(SELECT estudiante.matricula FROM estudiante WHERE 
estudiante.matricula = TRIM(p_matricula) AND estudiante.id_estatus = 3)
THEN 
UPDATE estudiante SET estudiante.id_estatus = 1
WHERE estudiante.matricula = TRIM(p_matricula);
SELECT 'Un registro deshabilitado con los datos ingresados se habilito' as mensaje, 'warning' as color;
ELSEIF EXISTS(SELECT * FROM estudiante WHERE estudiante.matricula = TRIM(p_matricula))
THEN 
SELECT 'Ya existe esa matricula, INTENTE DE NUEVO' as mensaje, 'warning' as color;
ELSE 
INSERT estudiante VALUES(
DEFAULT,
UPPER(TRIM(p_matricula)),
UPPER(TRIM(p_nombre_estudiante)),
UPPER(TRIM(p_ape1)),
UPPER(TRIM(p_ape2)),
(SELECT carrera.id_carrera FROM carrera WHERE carrera.id_carrera = TRIM(p_carrera)), 
(SELECT semestre.id_semestre FROM semestre WHERE semestre.id_semestre = TRIM(p_semestre)),  
1);
SELECT 'Se registro correctamente' as mensaje, 'success' as color;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_insertarLibro
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_insertarLibro`;
delimiter ;;
CREATE PROCEDURE `SP_insertarLibro`(p_no_inventario VARCHAR(255),
    p_nombre_carrera VARCHAR(255),
    p_codigo_barras VARCHAR(255),
    p_titulo_libro VARCHAR(255),
    p_autor_libro VARCHAR(255),
    p_editorial_libro VARCHAR(255),
    p_anio_libro VARCHAR(100),
    p_edicion_libro VARCHAR(100),
    p_fecha_libro DATE,
		p_estatus_libro INT)
BEGIN
    DECLARE carrera_id INT;
    DECLARE estatus_libro_id INT;

    SELECT id_carrera INTO carrera_id FROM carrera WHERE carrera.id_carrera = p_nombre_carrera;
    SELECT id_estatus INTO estatus_libro_id FROM estatus_libro WHERE estatus_libro.nombre_estatus = p_estatus_libro;

    IF (TRIM(p_no_inventario) IS NULL OR TRIM(p_no_inventario) = '')
    THEN
        SELECT 'No puede estar vacío el campo de N° DE INVENTARIO' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_codigo_barras) IS NULL OR TRIM(p_codigo_barras) = '')
    THEN
        SELECT 'No puede estar vacío el campo de CODIGO DE BARRAS' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_titulo_libro) IS NULL OR TRIM(p_titulo_libro) = '')
    THEN
        SELECT 'No puede estar vacío el campo TITULO DE LIBRO' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_autor_libro) IS NULL OR TRIM(p_autor_libro) = '')
    THEN
        SELECT 'No puede estar vacío el campo AUTOR' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_editorial_libro) IS NULL OR TRIM(p_editorial_libro) = '')
    THEN
        SELECT 'No puede estar vacío el campo EDITORIAL' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_anio_libro) IS NULL OR TRIM(p_anio_libro) = '')
    THEN
        SELECT 'No puede estar vacío el campo AÑO' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_edicion_libro) IS NULL OR TRIM(p_edicion_libro) = '')
    THEN
        SELECT 'No puede estar vacío el campo EDICION' AS mensaje, 'danger' AS color;
    ELSEIF (TRIM(p_fecha_libro) IS NULL OR TRIM(p_fecha_libro) = '')
    THEN
        SELECT 'No puede estar vacío el campo FECHA' AS mensaje, 'danger' AS color;
    ELSEIF EXISTS(SELECT 1 FROM libros WHERE no_inventario = p_no_inventario AND id_estatus = 1)
    THEN
        SELECT 'El N° INVENTARIO ya se encuentra registrado en la base de datos' AS mensaje, 'warning' AS color;
    ELSEIF EXISTS(SELECT TRIM(no_inventario) FROM libros WHERE TRIM(no_inventario) = TRIM(p_no_inventario) AND id_estatus = 3)
    THEN
        UPDATE libros SET id_estatus = 1 WHERE TRIM(no_inventario) = TRIM(p_no_inventario);
        SELECT 'Un registro deshabilitado con los datos ingresados se habilitó' AS mensaje, 'warning' AS color;
    ELSE
        INSERT INTO libros VALUES (DEFAULT, p_no_inventario, carrera_id, p_codigo_barras, p_titulo_libro, p_autor_libro, p_editorial_libro, p_anio_libro, p_edicion_libro, p_fecha_libro, 1);
        SELECT 'Se insertó correctamente' AS mensaje, 'success' AS color;
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
-- Procedure structure for SP_insertaYActualizaEstudiantes
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_insertaYActualizaEstudiantes`;
delimiter ;;
CREATE PROCEDURE `SP_insertaYActualizaEstudiantes`(p_matricula VARCHAR(255),
    p_nombre_estudiante VARCHAR(255),
    p_ape_Paterno VARCHAR(255),
    p_ape_Materno VARCHAR(255),
    p_nombre_carrera VARCHAR(255),
    p_nombre_semestre VARCHAR(255),
    p_nombre_estatus VARCHAR(255))
BEGIN
    DECLARE existing_id INT;
    DECLARE carrera_id INT;
    DECLARE semestre_id INT;
    DECLARE estatus_id INT;

    -- Obtener el ID de la carrera a partir del nombre de la carrera
    SELECT id_carrera INTO carrera_id FROM carrera WHERE nombre_carrera = p_nombre_carrera;

    -- Obtener el ID del semestre a partir del nombre del semestre
    SELECT id_semestre INTO semestre_id FROM semestre WHERE nombre_semestre = p_nombre_semestre;

    -- Obtener el ID del estatus a partir del nombre del estatus
    SELECT id_estatus_estudiante INTO estatus_id FROM estatus_estudiante WHERE nombre_estatus_estudiante = p_nombre_estatus;

    -- Verificar si la matrícula ya existe en la tabla
    SELECT id_estudiante INTO existing_id FROM estudiante WHERE matricula = p_matricula;

    IF existing_id IS NOT NULL THEN
        -- La matrícula ya existe, actualiza los datos
        UPDATE estudiante 
        SET nombre_estudiante = p_nombre_estudiante,
            ape_Paterno = p_ape_Paterno,
            ape_Materno = p_ape_Materno,
            id_carrera = carrera_id,
            id_semestre = semestre_id,
            id_estatus = estatus_id
        WHERE matricula = p_matricula;
    ELSE
        -- La matrícula no existe, inserta un nuevo registro
        INSERT INTO estudiante (matricula, nombre_estudiante, ape_Paterno, ape_Materno, id_carrera, id_semestre, id_estatus)
        VALUES (p_matricula, p_nombre_estudiante, p_ape_Paterno, p_ape_Materno, carrera_id, semestre_id, estatus_id);
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_libroNoInventario
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_libroNoInventario`;
delimiter ;;
CREATE PROCEDURE `SP_libroNoInventario`(p_prestamoId int)
BEGIN
SELECT prestamo.no_inventario, prestamo.matricula FROM prestamo
WHERE prestamo.id_prestamo = p_prestamoId;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_mostrarPrestamos
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_mostrarPrestamos`;
delimiter ;;
CREATE PROCEDURE `SP_mostrarPrestamos`(mostrar VARCHAR(10))
BEGIN
SELECT prestamo.fecha, prestamo.fecha_entrega, 
libros.no_inventario, libros.titulo_libro, libros.autor_libro, libros.editorial_libro, 
carrera.nombre_carrera, 
estudiante.matricula, 
CONCAT(estudiante.nombre_estudiante, ' ', estudiante.ape_Paterno, ' ', estudiante.ape_Materno), 
carrera.nombre_carrera, 
semestre.nombre_semestre
FROM
prestamo
INNER JOIN libros
ON prestamo.no_inventario = libros.no_inventario
INNER JOIN estudiante
ON prestamo.matricula = estudiante.matricula
INNER JOIN carrera
ON estudiante.id_carrera = carrera.id_carrera
INNER JOIN semestre
ON estudiante.id_semestre = semestre.id_semestre;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_PDFVencidos
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_PDFVencidos`;
delimiter ;;
CREATE PROCEDURE `SP_PDFVencidos`(vencidos VARCHAR(10))
BEGIN
DECLARE fechaAct VARCHAR(10);
SELECT DATE(NOW()) INTO fechaAct;
SET lc_time_names = 'es_ES';
SELECT
libros.no_inventario, libros.titulo_libro, libros.codigo_barras,
CONCAT(estudiante.nombre_estudiante, ' ', estudiante.ape_Paterno, ' ', estudiante.ape_Materno), 
carrera.nombre_carrera, 
semestre.nombre_semestre, 
prestamo.id_prestamo
FROM
prestamo
INNER JOIN libros
ON prestamo.no_inventario = libros.no_inventario
INNER JOIN estudiante
ON prestamo.matricula = estudiante.matricula
INNER JOIN carrera
ON estudiante.id_carrera = carrera.id_carrera
INNER JOIN semestre
ON estudiante.id_semestre = semestre.id_semestre
WHERE prestamo.fecha_entrega < fechaAct AND prestamo.estatus = 1
ORDER BY prestamo.fecha_entrega;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_PDFVigentes
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_PDFVigentes`;
delimiter ;;
CREATE PROCEDURE `SP_PDFVigentes`(vigentes VARCHAR(10))
BEGIN
DECLARE fechaAct VARCHAR(10);
SELECT DATE(NOW()) INTO fechaAct;
SET lc_time_names = 'es_ES';
SELECT
libros.no_inventario, libros.titulo_libro, libros.codigo_barras,
CONCAT(estudiante.nombre_estudiante, ' ', estudiante.ape_Paterno, ' ', estudiante.ape_Materno), 
carrera.nombre_carrera, 
semestre.nombre_semestre, 
prestamo.id_prestamo
FROM
prestamo
INNER JOIN libros
ON prestamo.no_inventario = libros.no_inventario
INNER JOIN estudiante
ON prestamo.matricula = estudiante.matricula
INNER JOIN carrera
ON estudiante.id_carrera = carrera.id_carrera
INNER JOIN semestre
ON estudiante.id_semestre = semestre.id_semestre
WHERE prestamo.fecha_entrega >= fechaAct AND prestamo.estatus = 1
ORDER BY prestamo.fecha_entrega;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_prestamosDevueltos
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_prestamosDevueltos`;
delimiter ;;
CREATE PROCEDURE `SP_prestamosDevueltos`(p_mostrar VARCHAR(10))
BEGIN
SET lc_time_names = 'es_ES';
SELECT DATE_FORMAT(prestamo.fecha, '%e-%M-%Y'), 
DATE_FORMAT(prestamo.fecha_entrega, '%e-%M-%Y'), 
libros.no_inventario, libros.titulo_libro, libros.autor_libro, libros.editorial_libro, 
carrera.nombre_carrera, 
estudiante.matricula, 
CONCAT(estudiante.nombre_estudiante, ' ', estudiante.ape_Paterno, ' ', estudiante.ape_Materno), 
carrera.nombre_carrera, 
semestre.nombre_semestre, 
prestamo.id_prestamo
FROM
prestamo
INNER JOIN libros
ON prestamo.no_inventario = libros.no_inventario
INNER JOIN estudiante
ON prestamo.matricula = estudiante.matricula
INNER JOIN carrera
ON estudiante.id_carrera = carrera.id_carrera
INNER JOIN semestre
ON estudiante.id_semestre = semestre.id_semestre
WHERE prestamo.estatus = 0
ORDER BY prestamo.fecha;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_prestamosVencidos
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_prestamosVencidos`;
delimiter ;;
CREATE PROCEDURE `SP_prestamosVencidos`(vencidos VARCHAR(10))
BEGIN
DECLARE fechaAct VARCHAR(10);
SELECT DATE(NOW()) INTO fechaAct;
SET lc_time_names = 'es_ES';
SELECT DATE_FORMAT(prestamo.fecha, '%e-%M-%Y'), 
DATE_FORMAT(prestamo.fecha_entrega, '%e-%M-%Y'),
libros.no_inventario, libros.titulo_libro, libros.autor_libro, libros.editorial_libro, 
carrera.nombre_carrera, 
estudiante.matricula, 
CONCAT(estudiante.nombre_estudiante, ' ', estudiante.ape_Paterno, ' ', estudiante.ape_Materno), 
carrera.nombre_carrera, 
semestre.nombre_semestre, 
prestamo.id_prestamo
FROM
prestamo
INNER JOIN libros
ON prestamo.no_inventario = libros.no_inventario
INNER JOIN estudiante
ON prestamo.matricula = estudiante.matricula
INNER JOIN carrera
ON estudiante.id_carrera = carrera.id_carrera
INNER JOIN semestre
ON estudiante.id_semestre = semestre.id_semestre
WHERE prestamo.fecha_entrega < fechaAct AND prestamo.estatus = 1
ORDER BY prestamo.fecha_entrega;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_prestamosVigentes
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_prestamosVigentes`;
delimiter ;;
CREATE PROCEDURE `SP_prestamosVigentes`(vigente VARCHAR(10))
BEGIN
DECLARE fechaActua VARCHAR(10);
SELECT DATE(NOW()) INTO fechaActua;
SET lc_time_names = 'es_ES';
SELECT DATE_FORMAT(prestamo.fecha, '%e-%M-%Y'), 
DATE_FORMAT(prestamo.fecha_entrega, '%e-%M-%Y'), 
libros.no_inventario, libroS.titulo_libro, libros.autor_libro, libros.editorial_libro, 
carrera.nombre_carrera, 
estudiante.matricula, 
CONCAT(estudiante.nombre_estudiante, ' ', estudiante.ape_Paterno, ' ', estudiante.ape_Materno), 
carrera.nombre_carrera, 
semestre.nombre_semestre, 
prestamo.id_prestamo
FROM
prestamo
INNER JOIN libros
ON prestamo.no_inventario = libros.no_inventario
INNER JOIN estudiante
ON prestamo.matricula = estudiante.matricula
INNER JOIN carrera
ON estudiante.id_carrera = carrera.id_carrera
INNER JOIN semestre
ON estudiante.id_semestre = semestre.id_semestre
WHERE prestamo.fecha_entrega >= fechaActua AND prestamo.estatus = 1
ORDER BY prestamo.fecha_entrega;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_pruebaReporte
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_pruebaReporte`;
delimiter ;;
CREATE PROCEDURE `SP_pruebaReporte`(p_verR VARCHAR(10))
BEGIN
SET lc_time_names = 'es_ES';
SELECT 
DATE_FORMAT(prestamo.fecha, '%e-%M-%Y'),
DATE_FORMAT(prestamo.fecha_entrega, '%e-%M-%Y'),
libros.no_inventario, 
libros.titulo_libro, 
libros.autor_libro, 
libros.editorial_libro, 
carrera2.nombre_carrera AS nombre_carrera_libro,  
estudiante.matricula, 
CONCAT(estudiante.nombre_estudiante, ' ', estudiante.ape_Paterno, ' ', estudiante.ape_Materno) AS nombre_estudiante, 
carrera.nombre_carrera AS nombre_carrera_estudiante,
semestre.nombre_semestre
FROM
prestamo
INNER JOIN libros
ON prestamo.no_inventario = libros.no_inventario
INNER JOIN estudiante
ON prestamo.matricula = estudiante.matricula
INNER JOIN carrera
ON estudiante.id_carrera = carrera.id_carrera
INNER JOIN semestre
ON estudiante.id_semestre = semestre.id_semestre
INNER JOIN carrera AS carrera2
ON libros.id_carrera = carrera2.id_carrera
WHERE 
prestamo.estatus = 1 AND 
prestamo.matricula = p_verR
ORDER BY
prestamo.fecha_entrega ASC;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_reporteDevuelto
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_reporteDevuelto`;
delimiter ;;
CREATE PROCEDURE `SP_reporteDevuelto`(prestamoId INT)
BEGIN
SELECT prestamo.fecha, prestamo.fecha_entrega, 
libros.no_inventario, libros.titulo_libro, libros.autor_libro, libros.editorial_libro, 
carrera.nombre_carrera, 
estudiante.matricula, 
CONCAT(estudiante.nombre_estudiante, ' ', estudiante.ape_Paterno, ' ', estudiante.ape_Materno), 
carrera.nombre_carrera, 
semestre.nombre_semestre
FROM
prestamo
INNER JOIN libros
ON prestamo.no_inventario = libros.no_inventario
INNER JOIN estudiante
ON prestamo.matricula = estudiante.matricula
INNER JOIN carrera
ON estudiante.id_carrera = carrera.id_carrera
INNER JOIN semestre
ON estudiante.id_semestre = semestre.id_semestre
WHERE prestamo.id_prestamo = prestamoId;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_validarCamposBusquedaPrestamo
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_validarCamposBusquedaPrestamo`;
delimiter ;;
CREATE PROCEDURE `SP_validarCamposBusquedaPrestamo`(IN p_no_inventario_libro VARCHAR(255),
    IN p_matricula_usuario VARCHAR(255))
BEGIN
    DECLARE estatus_estudiante INT;
    DECLARE estatus_libro INT;

    SELECT id_estatus INTO estatus_estudiante
    FROM estudiante
    WHERE estudiante.matricula LIKE CONCAT('%', p_matricula_usuario, '%')
    ORDER BY id_estudiante ASC
    LIMIT 1;

    SELECT id_estatus INTO estatus_libro
    FROM libros
    WHERE libros.no_inventario LIKE CONCAT('%', p_no_inventario_libro, '%')
    ORDER BY id_libro ASC
    LIMIT 1;

    IF estatus_estudiante IS NULL THEN
        SELECT 'No existe un usuario con esa matrícula' AS mensaje, 'danger' as color, 'falso' as bandera;
    ELSEIF estatus_libro IS NULL THEN
        SELECT 'No existe un libro con ese número de inventario' AS mensaje, 'danger' as color, 'falso' as bandera;
    ELSE
        IF (estatus_estudiante = 3 AND estatus_libro = 3) THEN
            SELECT 'No se puede procesar un préstamo con un libro y un usuario dados de baja' AS mensaje, 'danger' as color, 'falso' as bandera;
        ELSEIF (estatus_estudiante = 3 AND estatus_libro = 1) THEN
            SELECT 'No se puede procesar un préstamo con un usuario dado de baja' AS mensaje, 'danger' as color, 'falso' as bandera;
        ELSEIF (estatus_estudiante = 1 AND estatus_libro = 3) THEN
            SELECT 'No se puede procesar un préstamo con un libro dado de baja' AS mensaje, 'danger' as color, 'falso' as bandera;
        ELSEIF (estatus_estudiante = 1 AND estatus_libro = 2) THEN
            SELECT 'El libro ya cuenta con un préstamo existente' AS mensaje, 'danger' AS color, 'falso' as bandera;
        ELSEIF (estatus_estudiante = 1 AND estatus_libro = 1) THEN
            SELECT 'verdadero' AS bandera, 'entra??' as mensaje;
        END IF;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_verAlumnoReporte
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_verAlumnoReporte`;
delimiter ;;
CREATE PROCEDURE `SP_verAlumnoReporte`(ver_alumn VARCHAR(100))
BEGIN
SELECT DATE_FORMAT(prestamo.fecha, '%e-%m-%Y'), 
DATE_FORMAT(prestamo.fecha_entrega, '%e-%m-%Y'), 
estudiante.matricula, 
CONCAT(estudiante.nombre_estudiante, ' ', estudiante.ape_Paterno, ' ', estudiante.ape_Materno), 
carrera.nombre_carrera, 
semestre.nombre_semestre
FROM
prestamo
INNER JOIN libros
ON prestamo.no_inventario = libros.no_inventario
INNER JOIN estudiante
ON prestamo.matricula = estudiante.matricula
INNER JOIN carrera
ON estudiante.id_carrera = carrera.id_carrera
INNER JOIN semestre
ON estudiante.id_semestre = semestre.id_semestre
WHERE prestamo.no_inventario = ver_alumn
ORDER BY prestamo.id_prestamo DESC
LIMIT 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_verPrestamo
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_verPrestamo`;
delimiter ;;
CREATE PROCEDURE `SP_verPrestamo`(p_id_prestamo INT)
BEGIN
SELECT id_prestamo, fecha FROM prestamo WHERE id_prestamo = p_id_prestamo LIMIT 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_verReporte
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_verReporte`;
delimiter ;;
CREATE PROCEDURE `SP_verReporte`(dato_pre VARCHAR(100))
BEGIN
SELECT prestamo.fecha, prestamo.fecha_entrega, 
libros.no_inventario, libros.titulo_libro, libros.autor_libro, libros.editorial_libro, 
carrera.nombre_carrera, 
estudiante.matricula, 
CONCAT(estudiante.nombre_estudiante, ' ', estudiante.ape_Paterno, ' ', estudiante.ape_Materno), 
carrera.nombre_carrera, 
semestre.nombre_semestre, 
prestamo.id_prestamo
FROM
prestamo
INNER JOIN libros
ON prestamo.no_inventario = libros.no_inventario
INNER JOIN estudiante
ON prestamo.matricula = estudiante.matricula
INNER JOIN carrera
ON estudiante.id_carrera = carrera.id_carrera
INNER JOIN semestre
ON estudiante.id_semestre = semestre.id_semestre
WHERE prestamo.no_inventario = dato_pre
ORDER BY prestamo.id_prestamo DESC
LIMIT 1;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
