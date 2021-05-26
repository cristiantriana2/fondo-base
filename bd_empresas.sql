-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-05-2021 a las 14:30:18
-- Versión del servidor: 10.4.16-MariaDB
-- Versión de PHP: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_empresas`
--

DELIMITER $$
--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `actualizar_datos_empresas` (`a` INT(5), `b` VARCHAR(50), `c` VARCHAR(1000), `d` VARCHAR(14), `e` VARCHAR(50), `f` VARCHAR(50), `g` INT(1), `fila` INT(3)) RETURNS TEXT CHARSET utf8mb4 BEGIN 

	UPDATE empresas SET nit_empresa = a, nombre_empresa = b, descripcion_empresa = c, numero_contacto = d, direccion = e, tipo_empresa = f, estado_produccion = g WHERE nit_empresa = fila;

	RETURN 'datos han sido actualizados con exito';

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `eliminar_datos_empresas` (`a` INT(5)) RETURNS TEXT CHARSET utf8mb4 BEGIN

	DELETE FROM empresas WHERE nit_empresa = a;
	RETURN 'empresa eliminada con exito';

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `insertar_datos` (`a` INT(5), `b` VARCHAR(50), `c` VARCHAR(1000), `d` VARCHAR(14), `e` VARCHAR(50), `f` VARCHAR(50), `g` INT(1)) RETURNS TEXT CHARSET utf8mb4 BEGIN 

	INSERT INTO empresas(nit_empresa, nombre_empresa, descripcion_empresa, numero_contacto, direccion, tipo_empresa, estado_produccion) VALUES ( a, b, c, d, e, f, g);

	RETURN 'datos insertados con exito';

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `nit_empresa` int(5) NOT NULL,
  `nombre_empresa` varchar(50) NOT NULL,
  `descripcion_empresa` varchar(1000) NOT NULL,
  `numero_contacto` varchar(14) NOT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `tipo_empresa` varchar(50) DEFAULT NULL,
  `estado_produccion` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Disparadores `empresas`
--
DELIMITER $$
CREATE TRIGGER `historial_acciones` BEFORE DELETE ON `empresas` FOR EACH ROW BEGIN 
	INSERT INTO log_empresas(descripcion, fecha) VALUES ('se elimino un registro', NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estrellas`
--

CREATE TABLE `estrellas` (
  `valorizacion_numerica` int(1) DEFAULT NULL,
  `nit_empresa` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galeria`
--

CREATE TABLE `galeria` (
  `id_imagen` int(8) NOT NULL,
  `imagen` longblob DEFAULT NULL,
  `nit_empresa` int(5) NOT NULL,
  `id_producto` int(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `hola_mundo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `hola_mundo` (
`nit_empresa` int(5)
,`nombre_empresa` varchar(50)
,`descripcion_empresa` varchar(1000)
,`numero_contacto` varchar(14)
,`direccion` varchar(50)
,`tipo_empresa` varchar(50)
,`estado_produccion` int(1)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_empresas`
--

CREATE TABLE `log_empresas` (
  `id` int(3) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `log_empresas`
--

INSERT INTO `log_empresas` (`id`, `descripcion`, `fecha`) VALUES
(1, 'se elimino un registro', '2021-05-14 07:21:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(8) NOT NULL,
  `nombre_producto` varchar(50) NOT NULL,
  `tipo_producto` varchar(30) NOT NULL,
  `nit_empresa` int(5) NOT NULL,
  `id_imagen` int(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura para la vista `hola_mundo`
--
DROP TABLE IF EXISTS `hola_mundo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hola_mundo`  AS SELECT `empresas`.`nit_empresa` AS `nit_empresa`, `empresas`.`nombre_empresa` AS `nombre_empresa`, `empresas`.`descripcion_empresa` AS `descripcion_empresa`, `empresas`.`numero_contacto` AS `numero_contacto`, `empresas`.`direccion` AS `direccion`, `empresas`.`tipo_empresa` AS `tipo_empresa`, `empresas`.`estado_produccion` AS `estado_produccion` FROM `empresas` WHERE `empresas`.`nit_empresa` = 123 ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`nit_empresa`);

--
-- Indices de la tabla `estrellas`
--
ALTER TABLE `estrellas`
  ADD KEY `nit_empresa` (`nit_empresa`);

--
-- Indices de la tabla `galeria`
--
ALTER TABLE `galeria`
  ADD PRIMARY KEY (`id_imagen`),
  ADD KEY `nit_empresa` (`nit_empresa`);

--
-- Indices de la tabla `log_empresas`
--
ALTER TABLE `log_empresas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `nit_empresa` (`nit_empresa`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `log_empresas`
--
ALTER TABLE `log_empresas`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `estrellas`
--
ALTER TABLE `estrellas`
  ADD CONSTRAINT `estrellas_ibfk_1` FOREIGN KEY (`nit_empresa`) REFERENCES `empresas` (`nit_empresa`);

--
-- Filtros para la tabla `galeria`
--
ALTER TABLE `galeria`
  ADD CONSTRAINT `galeria_ibfk_1` FOREIGN KEY (`nit_empresa`) REFERENCES `empresas` (`nit_empresa`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`nit_empresa`) REFERENCES `empresas` (`nit_empresa`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
