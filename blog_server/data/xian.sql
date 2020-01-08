/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50714
 Source Host           : localhost:3306
 Source Schema         : xian

 Target Server Type    : MySQL
 Target Server Version : 50714
 File Encoding         : 65001

 Date: 08/01/2020 12:03:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_article
-- ----------------------------
DROP TABLE IF EXISTS `tb_article`;
CREATE TABLE `tb_article`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `title_pic` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '封面图片',
  `author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `content` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '摘要',
  `content_md` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容-Markdown',
  `origin` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来源',
  `state` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态',
  `eye_count` bigint(20) NULL DEFAULT 0 COMMENT '浏览量',
  `publish_time` timestamp(0) NOT NULL DEFAULT '1970-02-01 00:00:01' COMMENT '发布时间',
  `edit_time` timestamp(0) NOT NULL DEFAULT '1970-02-01 00:00:01' COMMENT '上次修改时间',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `content_html` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容-HTML',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_article_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_article_category`;
CREATE TABLE `tb_article_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `article_id` bigint(20) NOT NULL COMMENT '文章ID',
  `category_id` bigint(20) NOT NULL COMMENT '分类ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tb_article_category_tb_article_id_fk`(`article_id`) USING BTREE,
  INDEX `tb_article_category_tb_category_id_fk`(`category_id`) USING BTREE,
  CONSTRAINT `tb_article_category_tb_article_id_fk` FOREIGN KEY (`article_id`) REFERENCES `tb_article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_article_category_tb_category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `tb_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章&&分类关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_article_tags
-- ----------------------------
DROP TABLE IF EXISTS `tb_article_tags`;
CREATE TABLE `tb_article_tags`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `article_id` bigint(20) NOT NULL COMMENT '文章ID',
  `tags_id` bigint(20) NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tb_article_tags_tb_article_id_fk`(`article_id`) USING BTREE,
  INDEX `tb_article_tags_tb_tags_id_fk`(`tags_id`) USING BTREE,
  CONSTRAINT `tb_article_tags_tb_article_id_fk` FOREIGN KEY (`article_id`) REFERENCES `tb_article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_article_tags_tb_tags_id_fk` FOREIGN KEY (`tags_id`) REFERENCES `tb_tags` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章&&标签关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_category`;
CREATE TABLE `tb_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tb_category_name_uindex`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_comments
-- ----------------------------
DROP TABLE IF EXISTS `tb_comments`;
CREATE TABLE `tb_comments`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `p_id` bigint(20) NULL DEFAULT 0 COMMENT '父级ID，给哪个留言进行回复',
  `c_id` bigint(20) NULL DEFAULT 0 COMMENT '子级ID，给哪个留言下的回复进行评论',
  `article_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章标题',
  `article_id` bigint(20) NULL DEFAULT NULL COMMENT '文章ID',
  `author` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言人',
  `author_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给谁留言',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言邮箱',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '留言内容',
  `time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '留言时间',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接',
  `state` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '正常' COMMENT '状态',
  `sort` bigint(20) NULL DEFAULT 0 COMMENT '分类：0默认文章详情页，1友链页，2关于我页',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tb_comments_tb_article_id_fk`(`article_id`) USING BTREE,
  CONSTRAINT `tb_comments_tb_article_id_fk` FOREIGN KEY (`article_id`) REFERENCES `tb_article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_links
-- ----------------------------
DROP TABLE IF EXISTS `tb_links`;
CREATE TABLE `tb_links`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '连接名称',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '连接URL',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '友链表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_tags
-- ----------------------------
DROP TABLE IF EXISTS `tb_tags`;
CREATE TABLE `tb_tags`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tb_tags_name_uindex`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `nickname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `salt` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '盐值',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tb_user_username_uindex`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
