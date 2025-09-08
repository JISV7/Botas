CREATE DATABASE  IF NOT EXISTS `botas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `botas`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: botas
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `cliente_id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_cliente` varchar(150) NOT NULL,
  `rif` varchar(30) NOT NULL,
  `direccion` varchar(400) DEFAULT NULL,
  `telefono` varchar(40) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`cliente_id`),
  UNIQUE KEY `uk_cliente_rif` (`rif`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Cliente A','J-12345678-0','Caracas, Venezuela','0414-1234567','clientea@example.com'),(2,'Cliente B','J-87654321-0','Valencia, Venezuela','0414-7654321','clienteb@example.com');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumo_materiales`
--

DROP TABLE IF EXISTS `consumo_materiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumo_materiales` (
  `consumo_id` int unsigned NOT NULL AUTO_INCREMENT,
  `seguimiento_etapas_id` int unsigned NOT NULL,
  `inventario_materia_prima_id` int unsigned NOT NULL,
  `cantidad_consumida` decimal(14,3) NOT NULL,
  `fecha_consumo` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`consumo_id`),
  KEY `ix_cons_seg` (`seguimiento_etapas_id`),
  KEY `ix_cons_invmp` (`inventario_materia_prima_id`),
  CONSTRAINT `fk_cons__invmp` FOREIGN KEY (`inventario_materia_prima_id`) REFERENCES `inventario_materia_prima` (`inventario_materia_prima_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_cons__seg` FOREIGN KEY (`seguimiento_etapas_id`) REFERENCES `seguimiento_etapas` (`seguimiento_etapas_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumo_materiales`
--

LOCK TABLES `consumo_materiales` WRITE;
/*!40000 ALTER TABLE `consumo_materiales` DISABLE KEYS */;
INSERT INTO `consumo_materiales` VALUES (1,1,1,960.000,'2025-09-01 09:00:00'),(2,1,3,480.000,'2025-09-01 09:15:00'),(3,2,2,480.000,'2025-09-01 12:15:00'),(4,3,1,780.000,'2025-09-02 09:30:00'),(5,4,3,295.000,'2025-09-03 09:00:00'),(6,5,4,345.000,'2025-09-01 09:20:00'),(7,6,1,490.000,'2025-09-04 09:10:00'),(8,7,5,245.000,'2025-09-05 10:20:00'),(9,8,6,290.000,'2025-09-06 08:10:00'),(10,9,2,390.000,'2025-09-07 08:15:00');
/*!40000 ALTER TABLE `consumo_materiales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `control_calidad`
--

DROP TABLE IF EXISTS `control_calidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `control_calidad` (
  `control_calidad_id` int unsigned NOT NULL AUTO_INCREMENT,
  `seguimiento_etapas_id` int unsigned NOT NULL,
  `fecha_revision` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `inspector_id` int unsigned DEFAULT NULL,
  `resultado` enum('aprobado','rechazado','observado') NOT NULL DEFAULT 'aprobado',
  `porcentaje_defectuoso` decimal(5,2) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`control_calidad_id`),
  KEY `fk_cc__seg` (`seguimiento_etapas_id`),
  KEY `fk_cc__insp` (`inspector_id`),
  CONSTRAINT `fk_cc__insp` FOREIGN KEY (`inspector_id`) REFERENCES `empleados` (`empleados_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_cc__seg` FOREIGN KEY (`seguimiento_etapas_id`) REFERENCES `seguimiento_etapas` (`seguimiento_etapas_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `control_calidad`
--

LOCK TABLES `control_calidad` WRITE;
/*!40000 ALTER TABLE `control_calidad` DISABLE KEYS */;
INSERT INTO `control_calidad` VALUES (1,1,'2025-09-01 15:00:00',4,'aprobado',1.50,'Muestra aceptable'),(2,2,'2025-09-01 16:00:00',4,'aprobado',2.00,'Ligeras rebabas'),(3,3,'2025-09-02 12:00:00',4,'aprobado',1.00,'Buen resultado'),(4,4,'2025-09-03 12:30:00',4,'rechazado',5.00,'Alto desperdicio'),(5,5,'2025-09-04 13:00:00',4,'aprobado',1.80,'Correcto'),(6,6,'2025-09-05 14:00:00',4,'aprobado',2.50,'Normal'),(7,7,'2025-09-06 12:30:00',4,'observado',3.00,'Necesita revisión'),(8,8,'2025-09-07 13:00:00',4,'aprobado',1.00,'Excelente'),(9,9,'2025-09-08 12:00:00',4,'aprobado',2.20,'Correcto'),(10,10,'2025-09-09 15:00:00',4,'rechazado',6.00,'Defectos visibles');
/*!40000 ALTER TABLE `control_calidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `empleados_id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `cedula` varchar(30) NOT NULL,
  `cargo` varchar(120) DEFAULT NULL,
  `turno` varchar(40) DEFAULT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `fecha_ingreso` date DEFAULT NULL,
  PRIMARY KEY (`empleados_id`),
  UNIQUE KEY `uk_empleado_cedula` (`cedula`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'Carlos','Pérez','V-12345678','Operador de inyectora','Mañana','activo','2020-01-01'),(2,'María','Gómez','V-23456789','Operador de montacargas','Tarde','activo','2019-05-15'),(3,'José','Rodríguez','V-34567890','Supervisor de planta','Mañana','activo','2021-03-10'),(4,'Ana','Martínez','V-45678901','Inspector de calidad','Mañana','activo','2018-11-20'),(5,'Luis','Hernández','V-56789012','Operador de refiladora','Tarde','activo','2022-02-28'),(6,'Carmen','Fernández','V-67890123','Empacadora','Noche','activo','2020-07-12'),(7,'Pedro','Sánchez','V-78901234','Operador de caldera','Mañana','activo','2019-09-05'),(8,'Rosa','Díaz','V-89012345','Cortadora','Tarde','inactivo','2021-12-01'),(9,'Juan','Ramírez','V-90123456','Supervisor de almacén','Noche','activo','2018-06-18'),(10,'Elena','Torres','V-01234567','Vendedor','Mañana','activo','2022-04-22');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados_seguimiento_etapas`
--

DROP TABLE IF EXISTS `empleados_seguimiento_etapas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados_seguimiento_etapas` (
  `empleados_seguimiento_etapas_id` int unsigned NOT NULL AUTO_INCREMENT,
  `empleados_id` int unsigned NOT NULL,
  `seguimiento_etapas_id` int unsigned NOT NULL,
  PRIMARY KEY (`empleados_seguimiento_etapas_id`),
  UNIQUE KEY `uk_eseg` (`empleados_id`,`seguimiento_etapas_id`),
  KEY `fk_eseg__seg` (`seguimiento_etapas_id`),
  CONSTRAINT `fk_eseg__emp` FOREIGN KEY (`empleados_id`) REFERENCES `empleados` (`empleados_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_eseg__seg` FOREIGN KEY (`seguimiento_etapas_id`) REFERENCES `seguimiento_etapas` (`seguimiento_etapas_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados_seguimiento_etapas`
--

LOCK TABLES `empleados_seguimiento_etapas` WRITE;
/*!40000 ALTER TABLE `empleados_seguimiento_etapas` DISABLE KEYS */;
INSERT INTO `empleados_seguimiento_etapas` VALUES (1,1,1),(8,1,8),(3,2,3),(9,2,9),(2,3,2),(10,3,10),(4,4,4),(5,5,5),(6,6,6),(7,7,7);
/*!40000 ALTER TABLE `empleados_seguimiento_etapas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etapas_proceso`
--

DROP TABLE IF EXISTS `etapas_proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etapas_proceso` (
  `etapa_id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_etapa` varchar(120) NOT NULL,
  `descripcion` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`etapa_id`),
  UNIQUE KEY `uk_etapa_nombre` (`nombre_etapa`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etapas_proceso`
--

LOCK TABLES `etapas_proceso` WRITE;
/*!40000 ALTER TABLE `etapas_proceso` DISABLE KEYS */;
INSERT INTO `etapas_proceso` VALUES (1,'Inyección','Fundición e inyección de PVC en moldes'),(2,'Moldeo','Formación de la bota en moldes'),(3,'Enfriado','Reposo de 20 minutos para enfriamiento'),(4,'Refilado','Eliminación de rebabas y acabado manual'),(5,'Etiquetado','Colocación de etiquetas en botas'),(6,'Empaque','Empaque en cajas de cartón'),(7,'Almacenaje','Traslado al almacén de producto terminado'),(8,'Inspección','Control de calidad visual'),(9,'Prueba de resistencia','Ensayo de resistencia en laboratorio'),(10,'Despacho','Preparación de pedidos para clientes');
/*!40000 ALTER TABLE `etapas_proceso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_materia_prima`
--

DROP TABLE IF EXISTS `inventario_materia_prima`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_materia_prima` (
  `inventario_materia_prima_id` int unsigned NOT NULL AUTO_INCREMENT,
  `materia_prima_id` int unsigned NOT NULL,
  `lote` varchar(60) NOT NULL,
  `cantidad_disponible` decimal(14,3) NOT NULL DEFAULT '0.000',
  `precio_unitario` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `fecha_recepcion` date NOT NULL,
  `ubicacion_almacen` varchar(120) DEFAULT NULL,
  `sector` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventario_materia_prima_id`),
  UNIQUE KEY `uk_inv_mp_lote` (`materia_prima_id`,`lote`),
  CONSTRAINT `fk_inv_mp__mp` FOREIGN KEY (`materia_prima_id`) REFERENCES `materia_prima` (`materia_prima_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_materia_prima`
--

LOCK TABLES `inventario_materia_prima` WRITE;
/*!40000 ALTER TABLE `inventario_materia_prima` DISABLE KEYS */;
INSERT INTO `inventario_materia_prima` VALUES (1,1,'PVC-2025-01',2000.000,1.5000,'2025-08-01','Almacén A','2B'),(2,1,'PVC-2025-02',1500.000,1.5500,'2025-08-10','Almacén A','2B'),(3,2,'MED-2025-01',500.000,0.8000,'2025-08-05','Almacén B','9S'),(4,2,'MED-2025-02',600.000,0.8500,'2025-08-15','Almacén B','9S'),(5,3,'NYL-2025-01',400.000,2.0000,'2025-07-30','Almacén C',NULL),(6,4,'MET-2025-01',300.000,2.5000,'2025-07-28','Almacén C',NULL),(7,5,'MAL-2025-01',200.000,1.2000,'2025-08-12','Almacén D',NULL),(8,6,'PEG-2025-01',100.000,3.0000,'2025-08-02','Almacén D',NULL),(9,7,'ETQ-2025-01',1000.000,0.1000,'2025-08-03','Almacén E',NULL),(10,8,'CART-2025-01',500.000,0.5000,'2025-08-04','Almacén E',NULL);
/*!40000 ALTER TABLE `inventario_materia_prima` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_producto_terminado`
--

DROP TABLE IF EXISTS `inventario_producto_terminado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_producto_terminado` (
  `inventario_pt_id` int unsigned NOT NULL AUTO_INCREMENT,
  `producto_id` int unsigned NOT NULL,
  `lote` varchar(60) NOT NULL,
  `cantidad_disponible` int NOT NULL DEFAULT '0',
  `ubicacion_almacen` varchar(120) DEFAULT 'Almacén B',
  `sector` varchar(50) DEFAULT 'PT-A2',
  `fecha_ingreso` date NOT NULL,
  PRIMARY KEY (`inventario_pt_id`),
  KEY `fk_invpt_producto` (`producto_id`),
  CONSTRAINT `fk_invpt_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`productos_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_producto_terminado`
--

LOCK TABLES `inventario_producto_terminado` WRITE;
/*!40000 ALTER TABLE `inventario_producto_terminado` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario_producto_terminado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maquinaria`
--

DROP TABLE IF EXISTS `maquinaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maquinaria` (
  `maquinaria_id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_maquinaria` varchar(150) NOT NULL,
  `tipo` varchar(80) DEFAULT NULL,
  `modelo` varchar(100) DEFAULT NULL,
  `estado_operativo` enum('operativa','mantenimiento','fuera_servicio') DEFAULT 'operativa',
  `fecha_ultimo_mantenimiento` date DEFAULT NULL,
  `fecha_inicio_mantenimiento` date DEFAULT NULL,
  `fecha_fin_estimado_mantenimiento` date DEFAULT NULL,
  PRIMARY KEY (`maquinaria_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maquinaria`
--

LOCK TABLES `maquinaria` WRITE;
/*!40000 ALTER TABLE `maquinaria` DISABLE KEYS */;
INSERT INTO `maquinaria` VALUES (1,'Inyectora Principal','Inyectora PVC','INJ-100','operativa','2025-08-01',NULL,NULL),(2,'Inyectora Secundaria','Inyectora PVC','INJ-200','operativa','2025-07-20',NULL,NULL),(3,'Moldeadora B1','Moldeadora','MOL-300','operativa','2025-07-15',NULL,NULL),(4,'Moldeadora B2','Moldeadora','MOL-301','mantenimiento','2025-08-15','2025-08-15','2025-08-25'),(5,'Refiladora','Acabado','REF-400','operativa','2025-08-05',NULL,NULL),(6,'Montacargas','Transporte','MON-500','operativa','2025-08-10',NULL,NULL),(7,'Caldera','Generador Calor','CAL-600','operativa','2025-07-30',NULL,NULL),(8,'Cortadora','Acabado','COR-700','fuera_servicio','2025-06-25',NULL,NULL),(9,'Etiquetadora','Empaque','ETQ-800','operativa','2025-08-02',NULL,NULL),(10,'Empacadora','Empaque','EMP-900','operativa','2025-08-01',NULL,NULL);
/*!40000 ALTER TABLE `maquinaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maquinaria_seguimiento_etapas`
--

DROP TABLE IF EXISTS `maquinaria_seguimiento_etapas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maquinaria_seguimiento_etapas` (
  `maquinaria_seguimiento_etapas_id` int unsigned NOT NULL AUTO_INCREMENT,
  `maquinaria_id` int unsigned NOT NULL,
  `seguimiento_etapas_id` int unsigned NOT NULL,
  PRIMARY KEY (`maquinaria_seguimiento_etapas_id`),
  UNIQUE KEY `uk_mseg` (`maquinaria_id`,`seguimiento_etapas_id`),
  KEY `fk_mseg__seg` (`seguimiento_etapas_id`),
  CONSTRAINT `fk_mseg__maq` FOREIGN KEY (`maquinaria_id`) REFERENCES `maquinaria` (`maquinaria_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_mseg__seg` FOREIGN KEY (`seguimiento_etapas_id`) REFERENCES `seguimiento_etapas` (`seguimiento_etapas_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maquinaria_seguimiento_etapas`
--

LOCK TABLES `maquinaria_seguimiento_etapas` WRITE;
/*!40000 ALTER TABLE `maquinaria_seguimiento_etapas` DISABLE KEYS */;
INSERT INTO `maquinaria_seguimiento_etapas` VALUES (1,1,1),(3,1,3),(4,1,4),(7,1,7),(5,2,5),(2,3,2),(6,3,6),(8,4,8),(9,5,9),(10,6,10);
/*!40000 ALTER TABLE `maquinaria_seguimiento_etapas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materia_prima`
--

DROP TABLE IF EXISTS `materia_prima`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materia_prima` (
  `materia_prima_id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_material` varchar(120) NOT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `unidad_medida` varchar(30) NOT NULL,
  PRIMARY KEY (`materia_prima_id`),
  UNIQUE KEY `uk_materia_prima_nombre` (`nombre_material`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materia_prima`
--

LOCK TABLES `materia_prima` WRITE;
/*!40000 ALTER TABLE `materia_prima` DISABLE KEYS */;
INSERT INTO `materia_prima` VALUES (1,'PVC Granulado','Policloruro de vinilo granulado para inyección','KG'),(2,'Medias protectoras','Medias protectoras deslizantes para bota','PAR'),(3,'Punteras Nylon','Punteras de Nylon comprimido','UNIDAD'),(4,'Punteras Metal','Punteras metálicas de seguridad','UNIDAD'),(5,'Malla','Refuerzo textil para estructura de bota','METRO'),(6,'Pegamento Industrial','Adhesivo para montaje de piezas','LITRO'),(7,'Etiquetas','Etiquetas adhesivas para empaque','UNIDAD'),(8,'Cartón Corrugado','Cajas para empaque de botas','UNIDAD'),(9,'Film Plástico','Envoltura para embalaje','METRO'),(10,'Resistencias Eléctricas','Resistencias para calentamiento de cañón','UNIDAD');
/*!40000 ALTER TABLE `materia_prima` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_produccion`
--

DROP TABLE IF EXISTS `ordenes_produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes_produccion` (
  `ordenes_produccion_id` int unsigned NOT NULL AUTO_INCREMENT,
  `producto_id` int unsigned NOT NULL,
  `cliente_id` int unsigned DEFAULT NULL,
  `cantidad_a_producir` int NOT NULL,
  `fecha_solicitud` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_inicio_planificada` datetime DEFAULT NULL,
  `fecha_fin_planificada` datetime DEFAULT NULL,
  `estado` enum('planificada','en_proceso','completada','cancelada') NOT NULL DEFAULT 'planificada',
  `fecha_fin` datetime DEFAULT NULL,
  PRIMARY KEY (`ordenes_produccion_id`),
  KEY `ix_op_producto` (`producto_id`),
  KEY `fk_op_cliente` (`cliente_id`),
  CONSTRAINT `fk_op__producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`productos_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_op_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_produccion`
--

LOCK TABLES `ordenes_produccion` WRITE;
/*!40000 ALTER TABLE `ordenes_produccion` DISABLE KEYS */;
INSERT INTO `ordenes_produccion` VALUES (1,1,1,500,'2025-09-02 15:14:15','2025-09-01 00:00:00','2025-09-05 00:00:00','en_proceso',NULL),(2,2,1,400,'2025-09-02 15:14:15','2025-09-02 00:00:00','2025-09-06 00:00:00','planificada',NULL),(3,3,1,300,'2025-09-02 15:14:15','2025-09-03 00:00:00','2025-09-07 00:00:00','planificada',NULL),(4,4,1,350,'2025-09-02 15:14:15','2025-09-01 00:00:00','2025-09-05 00:00:00','en_proceso',NULL),(5,5,1,200,'2025-09-02 15:14:15','2025-09-04 00:00:00','2025-09-08 00:00:00','planificada',NULL),(6,6,1,250,'2025-09-02 15:14:15','2025-09-05 00:00:00','2025-09-09 00:00:00','planificada',NULL),(7,7,1,300,'2025-09-02 15:14:15','2025-09-06 00:00:00','2025-09-10 00:00:00','planificada',NULL),(8,8,1,400,'2025-09-02 15:14:15','2025-09-01 00:00:00','2025-09-05 00:00:00','en_proceso',NULL),(9,9,1,350,'2025-09-02 15:14:15','2025-09-07 00:00:00','2025-09-11 00:00:00','planificada',NULL),(10,10,1,500,'2025-09-02 15:14:15','2025-09-08 00:00:00','2025-09-12 00:00:00','planificada',NULL);
/*!40000 ALTER TABLE `ordenes_produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `productos_id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(150) NOT NULL,
  `modelo` varchar(100) DEFAULT NULL,
  `talla` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`productos_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Bota PVC','Standard','38','Negro','Bota PVC laboral negra'),(2,'Bota PVC','Standard','40','Negro','Bota PVC laboral negra'),(3,'Bota PVC','Standard','42','Negro','Bota PVC laboral negra'),(4,'Bota PVC','Refuerzo Metal','39','Blanco','Bota PVC con puntera metálica'),(5,'Bota PVC','Refuerzo Metal','41','Blanco','Bota PVC con puntera metálica'),(6,'Bota PVC','Nylon Light','38','Verde','Bota ligera con puntera de nylon'),(7,'Bota PVC','Nylon Light','40','Verde','Bota ligera con puntera de nylon'),(8,'Bota PVC','Agro','42','Marrón','Bota agroindustrial reforzada'),(9,'Bota PVC','Agro','44','Marrón','Bota agroindustrial reforzada'),(10,'Bota PVC','Impermeable Plus','41','Amarillo','Bota especial impermeable');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `proveedor_id` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre_proveedor` varchar(180) NOT NULL,
  `rif` varchar(30) NOT NULL,
  `direccion` varchar(400) DEFAULT NULL,
  `numero_telefonico` varchar(40) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`proveedor_id`),
  UNIQUE KEY `uk_proveedor_rif` (`rif`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'PVC Supply C.A.','J-12345678-1','Caracas, Venezuela','0414-1111111','contacto@pvcsupply.com'),(2,'Protectores Andinos','J-23456789-2','Mérida, Venezuela','0414-2222222','ventas@protectores.com'),(3,'Metal Parts','J-34567890-3','Valencia, Venezuela','0414-3333333','info@metalparts.com'),(4,'Textiles Lara','J-45678901-4','Barquisimeto, Venezuela','0414-4444444','ventas@textileslara.com'),(5,'Químicos Carabobo','J-56789012-5','Valencia, Venezuela','0414-5555555','info@quimicos.com'),(6,'Etiquetas Express','J-67890123-6','Maracaibo, Venezuela','0414-6666666','ventas@etiquetas.com'),(7,'Cajas del Centro','J-78901234-7','Maracay, Venezuela','0414-7777777','ventas@cajascentro.com'),(8,'Plásticos Global','J-89012345-8','Guarenas, Venezuela','0414-8888888','contacto@plasticosglobal.com'),(9,'Resistencias C.A.','J-90123456-9','Guacara, Venezuela','0414-9999999','ventas@resistencias.com'),(10,'Materiales Guaicaipuro','J-01234567-0','Los Teques, Venezuela','0414-1010101','ventas@guaicaipuro.com');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores_inventario_materia_prima`
--

DROP TABLE IF EXISTS `proveedores_inventario_materia_prima`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores_inventario_materia_prima` (
  `proveedores_inventario_materia_prima_id` int unsigned NOT NULL AUTO_INCREMENT,
  `inventario_materia_prima_id` int unsigned NOT NULL,
  `proveedor_id` int unsigned NOT NULL,
  PRIMARY KEY (`proveedores_inventario_materia_prima_id`),
  KEY `ix_pimp_invmp` (`inventario_materia_prima_id`),
  KEY `ix_pimp_prov` (`proveedor_id`),
  CONSTRAINT `fk_pimp__invmp` FOREIGN KEY (`inventario_materia_prima_id`) REFERENCES `inventario_materia_prima` (`inventario_materia_prima_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pimp__prov` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`proveedor_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores_inventario_materia_prima`
--

LOCK TABLES `proveedores_inventario_materia_prima` WRITE;
/*!40000 ALTER TABLE `proveedores_inventario_materia_prima` DISABLE KEYS */;
INSERT INTO `proveedores_inventario_materia_prima` VALUES (1,1,1),(2,2,1),(3,3,2),(4,4,2),(5,5,3),(6,6,4),(7,7,6),(8,8,7),(9,9,6),(10,10,7);
/*!40000 ALTER TABLE `proveedores_inventario_materia_prima` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seguimiento_etapas`
--

DROP TABLE IF EXISTS `seguimiento_etapas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seguimiento_etapas` (
  `seguimiento_etapas_id` int unsigned NOT NULL AUTO_INCREMENT,
  `ordenes_produccion_id` int unsigned NOT NULL,
  `etapa_id` int unsigned NOT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `cantidad_producida` int DEFAULT NULL,
  `cantidad_desperdicio_kg` decimal(14,3) DEFAULT NULL,
  `observacion` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`seguimiento_etapas_id`),
  KEY `ix_seg_op` (`ordenes_produccion_id`),
  KEY `ix_seg_etapa` (`etapa_id`),
  CONSTRAINT `fk_seg__etapa` FOREIGN KEY (`etapa_id`) REFERENCES `etapas_proceso` (`etapa_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_seg__op` FOREIGN KEY (`ordenes_produccion_id`) REFERENCES `ordenes_produccion` (`ordenes_produccion_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seguimiento_etapas`
--

LOCK TABLES `seguimiento_etapas` WRITE;
/*!40000 ALTER TABLE `seguimiento_etapas` DISABLE KEYS */;
INSERT INTO `seguimiento_etapas` VALUES (1,1,1,'2025-09-01 08:00:00','2025-09-01 12:00:00',480,20.000,'Proceso normal'),(2,1,2,'2025-09-01 12:10:00','2025-09-01 14:00:00',480,10.000,'Moldeo correcto'),(3,2,1,'2025-09-02 09:00:00','2025-09-02 11:00:00',390,10.000,'Poca rebaba'),(4,3,1,'2025-09-03 08:30:00','2025-09-03 11:30:00',295,5.000,'Correcto'),(5,4,1,'2025-09-01 08:00:00','2025-09-01 13:00:00',345,5.000,'Óptimo'),(6,5,1,'2025-09-04 09:00:00','2025-09-04 12:00:00',195,5.000,'Bien'),(7,6,1,'2025-09-05 10:00:00','2025-09-05 13:00:00',245,5.000,'Normal'),(8,7,1,'2025-09-06 08:00:00','2025-09-06 12:00:00',290,10.000,'Algo de rebaba'),(9,8,1,'2025-09-01 09:00:00','2025-09-01 14:00:00',390,10.000,'Correcto'),(10,9,1,'2025-09-07 08:00:00','2025-09-07 11:30:00',340,10.000,'Aceptable');
/*!40000 ALTER TABLE `seguimiento_etapas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_consumo_por_orden`
--

DROP TABLE IF EXISTS `vista_consumo_por_orden`;
/*!50001 DROP VIEW IF EXISTS `vista_consumo_por_orden`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_consumo_por_orden` AS SELECT 
 1 AS `ordenes_produccion_id`,
 1 AS `nombre_producto`,
 1 AS `nombre_material`,
 1 AS `unidad_medida`,
 1 AS `total_consumo`,
 1 AS `costo_total`,
 1 AS `etapas_utilizadas`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vista_consumo_por_orden`
--

/*!50001 DROP VIEW IF EXISTS `vista_consumo_por_orden`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_consumo_por_orden` AS select `o`.`ordenes_produccion_id` AS `ordenes_produccion_id`,`p`.`nombre_producto` AS `nombre_producto`,`m`.`nombre_material` AS `nombre_material`,`m`.`unidad_medida` AS `unidad_medida`,sum(`c`.`cantidad_consumida`) AS `total_consumo`,round(sum((`c`.`cantidad_consumida` * `i`.`precio_unitario`)),2) AS `costo_total`,count(distinct `s`.`seguimiento_etapas_id`) AS `etapas_utilizadas` from (((((`consumo_materiales` `c` join `inventario_materia_prima` `i` on((`c`.`inventario_materia_prima_id` = `i`.`inventario_materia_prima_id`))) join `materia_prima` `m` on((`i`.`materia_prima_id` = `m`.`materia_prima_id`))) join `seguimiento_etapas` `s` on((`c`.`seguimiento_etapas_id` = `s`.`seguimiento_etapas_id`))) join `ordenes_produccion` `o` on((`s`.`ordenes_produccion_id` = `o`.`ordenes_produccion_id`))) join `productos` `p` on((`o`.`producto_id` = `p`.`productos_id`))) group by `o`.`ordenes_produccion_id`,`m`.`materia_prima_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-07 22:09:34
