{\rtf1\ansi\ansicpg1251\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 CREATE TABLE `country` (\
  `id` mediumint unsigned NOT NULL AUTO_INCREMENT,\
  `name` varchar(255) NOT NULL,\
  PRIMARY KEY (`id`),\
  UNIQUE KEY `id_UNIQUE` (`id`)\
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;\
\
SELECT * FROM lession_1.country;CREATE TABLE `country` (\
  `id` mediumint unsigned NOT NULL AUTO_INCREMENT,\
  `name` varchar(255) NOT NULL,\
  PRIMARY KEY (`id`),\
  UNIQUE KEY `id_UNIQUE` (`id`)\
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;\
CREATE TABLE `state` (\
  `id` int unsigned NOT NULL,\
  `name` varchar(255) NOT NULL,\
  `population` int NOT NULL,\
  `country_id` mediumint unsigned NOT NULL,\
  PRIMARY KEY (`id`),\
  UNIQUE KEY `id_UNIQUE` (`id`),\
  UNIQUE KEY `country_id_UNIQUE` (`country_id`),\
  CONSTRAINT `fk_state_country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT\
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;\
}