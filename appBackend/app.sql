/*
 Navicat Premium Data Transfer

 Source Server         : 服务器数据库
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : 47.94.160.237:3306
 Source Schema         : podcast

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 26/10/2021 17:35:59
*/

create database if not exists podcast default character set utf8 collate utf8_general_ci;

use podcast;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_article
-- ----------------------------
DROP TABLE IF EXISTS `t_article`;
CREATE TABLE `t_article` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `classify` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_article
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_classify
-- ----------------------------
DROP TABLE IF EXISTS `t_classify`;
CREATE TABLE `t_classify` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_classify
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_media
-- ----------------------------
DROP TABLE IF EXISTS `t_media`;
CREATE TABLE `t_media` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `size` bigint DEFAULT NULL,
  `time` bigint DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `is_show` bit(1) NOT NULL,
  `img` varchar(255) DEFAULT NULL,
  `classify_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_media
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_personal_column
-- ----------------------------
DROP TABLE IF EXISTS `t_personal_column`;
CREATE TABLE `t_personal_column` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `media_id_array` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `classify_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_personal_column
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `name_zh` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
BEGIN;
INSERT INTO `t_role` VALUES (1, 'ROLE_admin', '管理员');
INSERT INTO `t_role` VALUES (2, 'ROLE_user', '普通用户');
INSERT INTO `t_role` VALUES (3, 'ROLE_media', '审核员');
COMMIT;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_non_expired` bit(1) NOT NULL,
  `account_non_locked` bit(1) NOT NULL,
  `credentials_non_expired` bit(1) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `power` bigint DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
BEGIN;
INSERT INTO `t_user` VALUES (1, b'1', b'1', b'1', b'1', '$2a$10$g0LlMVrfUlmRxYKUPpzsT.Ww6pdSJoHWrFdGJqd9sF96YRbqS78zG', 1, 'admin', NULL);
INSERT INTO `t_user` VALUES (2, b'1', b'1', b'1', b'1', '$2a$10$93sUDzzbjGCBOxi/WdeNYuuF.oaEjZ9ygip3HoMOEiRO/ww7KkoE.', 1, 'podcasts', NULL);
INSERT INTO `t_user` VALUES (3, b'1', b'1', b'1', b'1', '$2a$10$9284hgIkXcBVjYQA1Csqx..pcfLh5KKfkID9UpjoDQ3fNf0kfY14K', 1, 'liulinboyi', NULL);
INSERT INTO `t_user` VALUES (4, b'1', b'1', b'1', b'1', '$2a$10$9MOQY1pMCGKsOFnIpaAZm.fqhgxOrXFlqXdx2XWX9lnMWRalmjbgO', 1, 'liziheng', NULL);
COMMIT;

-- ----------------------------
-- Table structure for t_user_roles
-- ----------------------------
DROP TABLE IF EXISTS `t_user_roles`;
CREATE TABLE `t_user_roles` (
  `t_user_id` bigint NOT NULL,
  `roles_id` bigint NOT NULL,
  KEY `FKj47yp3hhtsoajht9793tbdrp4` (`roles_id`),
  KEY `FK7l00c7jb4804xlpmk1k26texy` (`t_user_id`),
  CONSTRAINT `FK7l00c7jb4804xlpmk1k26texy` FOREIGN KEY (`t_user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `FKj47yp3hhtsoajht9793tbdrp4` FOREIGN KEY (`roles_id`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_roles
-- ----------------------------
BEGIN;
INSERT INTO `t_user_roles` VALUES (1, 1);
INSERT INTO `t_user_roles` VALUES (2, 1);
INSERT INTO `t_user_roles` VALUES (3, 1);
INSERT INTO `t_user_roles` VALUES (4, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
