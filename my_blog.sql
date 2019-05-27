/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50641
Source Host           : localhost:3306
Source Database       : my_blog

Target Server Type    : MYSQL
Target Server Version : 50641
File Encoding         : 65001

Date: 2018-12-24 11:00:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `activates_activate`
-- ----------------------------
DROP TABLE IF EXISTS `activates_activate`;
CREATE TABLE `activates_activate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) NOT NULL,
  `author` varchar(256) NOT NULL,
  `category` varchar(50) NOT NULL,
  `datatime` datetime NOT NULL,
  `content` longtext NOT NULL,
  `num` int(11) NOT NULL,
  `code` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activates_activate
-- ----------------------------
INSERT INTO `activates_activate` VALUES ('1', '数据结构常见的八大算法-1', 'LeeLom', '直接插入排序', '2018-11-28 04:23:37', '***\r\n####算法思想：\r\n \r\n\r\n&ensp;&ensp;直接插入排序的核心思想就是：将数组中的所有元素依次跟前面已经排好的元素相比较，如果选择的元素比已排序的元素小，则交换，直到全部元素都比较过。\r\n因此，从上面的描述中我们可以发现，直接插入排序可以用两个循环完成：\r\n\r\n*  第一层循环：遍历待比较的所有数组元素\r\n\r\n\r\n*  第二层循环：将本轮选择的元素(selected)与已经排好序的元素?(ordered)相比较。\r\n\r\n\r\n&ensp;&ensp;如果：selected > ordered，那么将二者交换', '38', '#直接插入排序\r\ndef insert_sort(L):\r\n    #遍历数组中的所有元素，其中0号索引元素默认已排序，因此从1开始\r\n    for x in range(1,len(L)):\r\n    #将该元素与已排序好的前序数组依次比较，如果该元素小，则交换\r\n    #range(x-1,-1,-1):从x-1倒序循环到0\r\n        for i in range(x-1,-1,-1):\r\n    #判断：如果符合条件则交换\r\n            if L[i] > L[i+1]:\r\n                temp = L[i+1]\r\n                L[i+1] = L[i]\r\n                L[i] = temp');
INSERT INTO `activates_activate` VALUES ('2', '数据结构常见的八大排序算法-2', 'LeeLom', '希尔排序', '2018-11-28 06:40:52', '***\r\n####算法思想：\r\n&ensp;&ensp;希尔排序的算法思想：将待排序数组按照步长gap进行分组，然后将每组的元素利用直接插入排序的方法进行排序；每次将gap折半减小，循环上述操作；当gap=1时，利用直接插入，完成排序。\r\n同样的：从上面的描述中我们可以发现：希尔排序的总体实现应该由三个循环完成：\r\n\r\n*  一层循环：将gap依次折半，对序列进行分组，直到gap=1\r\n\r\n\r\n\r\n\r\n*  第二、三层循环：也即直接插入排序所需要的两次循环。具体描述见上。', '17', '#希尔排序\r\ndef insert_shell(L):\r\n    #初始化gap值，此处利用序列长度的一般为其赋值\r\n    gap = (int)(len(L)/2)\r\n    #第一层循环：依次改变gap值对列表进行分组\r\n    while (gap >= 1):\r\n    #下面：利用直接插入排序的思想对分组数据进行排序\r\n    #range(gap,len(L)):从gap开始\r\n        for x in range(gap,len(L)):\r\n    #range(x-gap,-1,-gap):从x-gap开始与选定元素开始倒序比较，每个比较元素之间间隔gap\r\n            for i in range(x-gap,-1,-gap):\r\n    #如果该组当中两个元素满足交换条件，则进行交换\r\n                if L[i] > L[i+gap]:\r\n                    temp = L[i+gap]\r\n                    L[i+gap] = L[i]\r\n                    L[i] =temp\r\n    #while循环条件折半\r\n        gap = (int)(gap/2)');
INSERT INTO `activates_activate` VALUES ('3', '数据结构常见的八大排序算法-3', 'LeeLom', '简单排序', '2018-11-28 06:47:51', '####简单选择排序的基本思想：比较+交换。\r\n\r\n&ensp;&ensp;从待排序序列中，找到关键字最小的元素；\r\n如果最小元素不是待排序序列的第一个元素，将其和第一个元素互换；\r\n从余下的 N - 1 个元素中，找出关键字最小的元素，重复(1)、(2)步，直到排序结束。\r\n\r\n\r\n&ensp;&ensp;因此我们可以发现，简单选择排序也是通过两层循环实现。\r\n\r\n\r\n*  第一层循环：依次遍历序列当中的每一个元素\r\n\r\n\r\n*  第二层循环：将遍历得到的当前元素依次与余下的元素进行比较，符合最小元素的条件，则交换。', '17', '# 简单选择排序\r\ndef select_sort(L):\r\n#依次遍历序列中的每一个元素\r\n    for x in range(0,len(L)):\r\n#将当前位置的元素定义此轮循环当中的最小值\r\n        minimum = L[x]\r\n#将该元素与剩下的元素依次比较寻找最小元素\r\n        for i in range(x+1,len(L)):\r\n            if L[i] < minimum:\r\n                temp = L[i];\r\n                L[i] = minimum;\r\n                minimum = temp\r\n#将比较后得到的真正的最小值赋值给当前位置\r\n        L[x] = minimum');
INSERT INTO `activates_activate` VALUES ('4', '数据结构常见的八大排序算法-4', 'LeeLom', '堆排序', '2018-11-28 07:27:08', '****\r\n####堆的概念\r\n&ensp;&ensp;堆：本质是一种数组对象。特别重要的一点性质：<b>任意的叶子节点小于（或大于）它所有的父节点</b>。对此，又分为大顶堆和小顶堆，大顶堆要求节点的元素都要大于其孩子，小顶堆要求节点元素都小于其左右孩子，两者对左右孩子的大小关系不做任何要求。\r\n利用堆排序，就是基于大顶堆或者小顶堆的一种排序方法。下面，我们通过大顶堆来实现。\r\n\r\n####基本思想：\r\n&ensp;&ensp;堆排序可以按照以下步骤来完成：\r\n\r\n*  首先将序列构建称为大顶堆；\r\n（这样满足了大顶堆那条性质：位于根节点的元素一定是当前序列的最大值）\r\n\r\n*  取出当前大顶堆的根节点，将其与序列末尾元素进行交换\r\n（此时：序列末尾的元素为已排序的最大值；由于交换了元素，当前位于根节点的堆并不一定满足大顶堆的性质）\r\n对交换后的n-1个序列元素进行调整，使其满足大顶堆的性质\r\n\r\n*  重复2.3步骤，直至堆中只有1个元素为止', '60', '#-------------------------堆排序--------------------------------\r\n#**********获取左右叶子节点**********\r\ndef LEFT(i):\r\n    return 2*i + 1\r\ndef RIGHT(i):\r\n    return 2*i + 2\r\n#********** 调整大顶堆 **********\r\n#L:待调整序列 length: 序列长度 i:需要调整的结点\r\ndef adjust_max_heap(L,length,i):\r\n#定义一个int值保存当前序列最大值的下标\r\n    largest = i\r\n#执行循环操作：两个任务：1 寻找最大值的下标；2.最大值与父节点交换\r\n    while (1):\r\n#获得序列左右叶子节点的下标\r\n        left,right = LEFT(i),RIGHT(i)\r\n#当左叶子节点的下标小于序列长度 并且 左叶子节点的值大于父节点时，将左叶子节点的下标赋值给largest\r\n        if (left < length) and (L[left] > L[i]):\r\n            largest = left\r\n            print(\'左叶子节点\')\r\n        else:\r\n            largest = i\r\n#当右叶子节点的下标小于序列长度 并且 右叶子节点的值大于父节点时，将右叶子节点的下标值赋值给largest\r\n        if (right < length) and (L[right] > L[largest]):\r\n            largest = right\r\n            print(\'右叶子节点\')\r\n#如果largest不等于i 说明当前的父节点不是最大值，需要交换值\r\n        if (largest != i):\r\n            temp = L[i]\r\n            L[i] = L[largest]\r\n            L[largest] = temp\r\n            i = largest\r\n            print(largest)\r\n            continue\r\n        else:\r\n            break\r\n#********** 建立大顶堆 **********\r\ndef build_max_heap(L):\r\n    length = len(L)\r\n    for x in range((int)((length-1)/2),-1,-1):\r\n        adjust_max_heap(L,length,x)\r\n#********** 堆排序 **********\r\ndef heap_sort(L):\r\n#先建立大顶堆，保证最大值位于根节点；并且父节点的值大于叶子结点\r\n    build_max_heap(L)\r\n#i：当前堆中序列的长度.初始化为序列的长度\r\n    i = len(L)\r\n#执行循环：1. 每次取出堆顶元素置于序列的最后(len-1,len-2,len-3...)\r\n#         2. 调整堆，使其继续满足大顶堆的性质，注意实时修改堆中序列的长度\r\n    while (i > 0):\r\n        temp = L[i-1]\r\n        L[i-1] = L[0]\r\n        L[0] = temp\r\n#堆中序列长度减1\r\n        i = i-1\r\n#调整大顶堆\r\n        adjust_max_heap(L,i,0)');

-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_group_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_permission`
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add group', '2', 'add_group');
INSERT INTO `auth_permission` VALUES ('5', 'Can change group', '2', 'change_group');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete group', '2', 'delete_group');
INSERT INTO `auth_permission` VALUES ('7', 'Can add permission', '3', 'add_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can change permission', '3', 'change_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete permission', '3', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('10', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('11', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('13', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('14', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('16', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('17', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('19', 'Can add site', '7', 'add_site');
INSERT INTO `auth_permission` VALUES ('20', 'Can change site', '7', 'change_site');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete site', '7', 'delete_site');
INSERT INTO `auth_permission` VALUES ('22', 'Can add username', '8', 'add_usertwo');
INSERT INTO `auth_permission` VALUES ('23', 'Can change username', '8', 'change_usertwo');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete username', '8', 'delete_usertwo');
INSERT INTO `auth_permission` VALUES ('25', 'Can add activate', '9', 'add_activate');
INSERT INTO `auth_permission` VALUES ('26', 'Can change activate', '9', 'change_activate');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete activate', '9', 'delete_activate');
INSERT INTO `auth_permission` VALUES ('28', 'Can add comment_bases', '10', 'add_comment_bases');
INSERT INTO `auth_permission` VALUES ('29', 'Can change comment_bases', '10', 'change_comment_bases');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete comment_bases', '10', 'delete_comment_bases');
INSERT INTO `auth_permission` VALUES ('31', 'Can add teachiing_text', '11', 'add_teachiing_text');
INSERT INTO `auth_permission` VALUES ('32', 'Can change teachiing_text', '11', 'change_teachiing_text');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete teachiing_text', '11', 'delete_teachiing_text');
INSERT INTO `auth_permission` VALUES ('34', 'Can add mulu', '12', 'add_mulu');
INSERT INTO `auth_permission` VALUES ('35', 'Can change mulu', '12', 'change_mulu');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete mulu', '12', 'delete_mulu');
INSERT INTO `auth_permission` VALUES ('37', 'Can add 课程', '13', 'add_teach_title');
INSERT INTO `auth_permission` VALUES ('38', 'Can change 课程', '13', 'change_teach_title');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete 课程', '13', 'delete_teach_title');
INSERT INTO `auth_permission` VALUES ('40', 'Can add 章', '14', 'add_z_title');
INSERT INTO `auth_permission` VALUES ('41', 'Can change 章', '14', 'change_z_title');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete 章', '14', 'delete_z_title');
INSERT INTO `auth_permission` VALUES ('43', 'Can add 节', '15', 'add_j_title');
INSERT INTO `auth_permission` VALUES ('44', 'Can change 节', '15', 'change_j_title');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete 节', '15', 'delete_j_title');
INSERT INTO `auth_permission` VALUES ('46', 'Can add comment_ss_s', '16', 'add_comment_ss_s');
INSERT INTO `auth_permission` VALUES ('47', 'Can change comment_ss_s', '16', 'change_comment_ss_s');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete comment_ss_s', '16', 'delete_comment_ss_s');
INSERT INTO `auth_permission` VALUES ('49', 'Can add comment_ss', '17', 'add_comment_ss');
INSERT INTO `auth_permission` VALUES ('50', 'Can change comment_ss', '17', 'change_comment_ss');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete comment_ss', '17', 'delete_comment_ss');

-- ----------------------------
-- Table structure for `auth_user`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$36000$wqH5fOdMcl7h$5XKZNBQjOq1HiPSJpCB9pdtVIaoqdG+j0ji3X9mZIiE=', '2018-12-23 06:43:03', '1', 'sunli', '', '', '3398536845@qq.com', '1', '1', '2018-11-26 11:45:55');

-- ----------------------------
-- Table structure for `auth_user_groups`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for `auth_user_user_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `comment_comment_bases`
-- ----------------------------
DROP TABLE IF EXISTS `comment_comment_bases`;
CREATE TABLE `comment_comment_bases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_text` longtext NOT NULL,
  `comment_time` datetime NOT NULL,
  `article_id_id` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_comment_base_article_id_id_819a4419_fk_activates` (`article_id_id`),
  KEY `comment_comment_bases_user_id_id_18c35c3f_fk_User_usertwo_id` (`user_id_id`),
  CONSTRAINT `comment_comment_base_article_id_id_819a4419_fk_activates` FOREIGN KEY (`article_id_id`) REFERENCES `activates_activate` (`id`),
  CONSTRAINT `comment_comment_bases_user_id_id_18c35c3f_fk_User_usertwo_id` FOREIGN KEY (`user_id_id`) REFERENCES `user_usertwo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment_comment_bases
-- ----------------------------
INSERT INTO `comment_comment_bases` VALUES ('8', '做的挺好的', '2018-12-21 03:12:20', '2', '3');
INSERT INTO `comment_comment_bases` VALUES ('9', '写的挺好！', '2018-12-21 03:50:50', '4', '3');
INSERT INTO `comment_comment_bases` VALUES ('10', '不错啊', '2018-12-22 02:31:57', '4', '4');
INSERT INTO `comment_comment_bases` VALUES ('11', '咋回事啊', '2018-12-22 03:02:49', '2', '4');
INSERT INTO `comment_comment_bases` VALUES ('12', '还可以吧，受益匪浅！', '2018-12-23 11:17:24', '4', '3');

-- ----------------------------
-- Table structure for `comment_s_comment_ss`
-- ----------------------------
DROP TABLE IF EXISTS `comment_s_comment_ss`;
CREATE TABLE `comment_s_comment_ss` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_content` longtext NOT NULL,
  `datatime` datetime NOT NULL,
  `user_normal_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_s_comment_ss_user_normal_id_3569c1b5_fk_User_usertwo_id` (`user_normal_id`),
  CONSTRAINT `comment_s_comment_ss_user_normal_id_3569c1b5_fk_User_usertwo_id` FOREIGN KEY (`user_normal_id`) REFERENCES `user_usertwo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment_s_comment_ss
-- ----------------------------
INSERT INTO `comment_s_comment_ss` VALUES ('18', '哈哈哈哈哈哈', '2018-12-21 09:33:30', '3');
INSERT INTO `comment_s_comment_ss` VALUES ('19', '可以的哟！', '2018-12-21 13:21:52', '4');
INSERT INTO `comment_s_comment_ss` VALUES ('20', '哈哈哈哈哈', '2018-12-22 02:30:25', '4');
INSERT INTO `comment_s_comment_ss` VALUES ('21', '还不错，我觉得收益匪浅！', '2018-12-22 03:01:20', '4');
INSERT INTO `comment_s_comment_ss` VALUES ('22', '咋回事啊！', '2018-12-22 03:02:12', '4');
INSERT INTO `comment_s_comment_ss` VALUES ('23', '鸡毛东西', '2018-12-22 03:03:05', '4');
INSERT INTO `comment_s_comment_ss` VALUES ('24', '啥玩意啊', '2018-12-22 03:04:13', '4');
INSERT INTO `comment_s_comment_ss` VALUES ('25', 'hhhhh', '2018-12-22 07:25:55', '4');
INSERT INTO `comment_s_comment_ss` VALUES ('26', 'what fuck', '2018-12-22 07:42:26', '5');

-- ----------------------------
-- Table structure for `comment_s_comment_ss_s`
-- ----------------------------
DROP TABLE IF EXISTS `comment_s_comment_ss_s`;
CREATE TABLE `comment_s_comment_ss_s` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reply_content` longtext NOT NULL,
  `datatime` datetime NOT NULL,
  `reply_user_id` int(11) NOT NULL,
  `user_normal_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_s_comment_ss_reply_user_id_d9a4d073_fk_comment_s` (`reply_user_id`),
  KEY `comment_s_comment_ss_user_normal_id_34d8a8c5_fk_User_user` (`user_normal_id`),
  CONSTRAINT `comment_s_comment_ss_reply_user_id_d9a4d073_fk_comment_s` FOREIGN KEY (`reply_user_id`) REFERENCES `comment_s_comment_ss` (`id`),
  CONSTRAINT `comment_s_comment_ss_user_normal_id_34d8a8c5_fk_User_user` FOREIGN KEY (`user_normal_id`) REFERENCES `user_usertwo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment_s_comment_ss_s
-- ----------------------------
INSERT INTO `comment_s_comment_ss_s` VALUES ('30', '整的不错啊', '2018-12-23 06:43:45', '18', '4');
INSERT INTO `comment_s_comment_ss_s` VALUES ('31', '真的挺好的，真的挺不错的，真是好的平台！！', '2018-12-23 09:09:57', '26', '3');
INSERT INTO `comment_s_comment_ss_s` VALUES ('32', '二级评论真尼玛难做啊', '2018-12-23 09:20:53', '22', '3');
INSERT INTO `comment_s_comment_ss_s` VALUES ('33', '还不错，真的挺好！', '2018-12-23 09:23:46', '25', '3');
INSERT INTO `comment_s_comment_ss_s` VALUES ('34', '还可以啊，鸡毛啥的', '2018-12-23 09:26:20', '23', '3');

-- ----------------------------
-- Table structure for `django_admin_log`
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2018-11-26 12:30:36', '1', 'sunli', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('2', '2018-11-26 12:34:13', '1', 'sunli', '3', '', '8', '1');
INSERT INTO `django_admin_log` VALUES ('3', '2018-11-28 04:23:37', '1', '数据结构常见的八大算法-1', '1', '[{\"added\": {}}]', '9', '1');
INSERT INTO `django_admin_log` VALUES ('4', '2018-11-28 06:28:41', '1', '数据结构常见的八大算法-1', '2', '[{\"changed\": {\"fields\": [\"content\"]}}]', '9', '1');
INSERT INTO `django_admin_log` VALUES ('5', '2018-11-28 06:30:49', '1', '数据结构常见的八大算法-1', '2', '[{\"changed\": {\"fields\": [\"content\"]}}]', '9', '1');
INSERT INTO `django_admin_log` VALUES ('6', '2018-11-28 06:36:19', '1', '数据结构常见的八大算法-1', '2', '[{\"changed\": {\"fields\": [\"content\"]}}]', '9', '1');
INSERT INTO `django_admin_log` VALUES ('7', '2018-11-28 06:40:52', '2', '数据结构常见的八大排序算法-2', '1', '[{\"added\": {}}]', '9', '1');
INSERT INTO `django_admin_log` VALUES ('8', '2018-11-28 06:42:17', '2', '数据结构常见的八大排序算法-2', '2', '[{\"changed\": {\"fields\": [\"content\"]}}]', '9', '1');
INSERT INTO `django_admin_log` VALUES ('9', '2018-11-28 06:47:51', '3', '数据结构常见的八大排序算法-3', '1', '[{\"added\": {}}]', '9', '1');
INSERT INTO `django_admin_log` VALUES ('10', '2018-11-28 07:06:22', '2', '数据结构常见的八大排序算法-2', '2', '[{\"changed\": {\"fields\": [\"code\"]}}]', '9', '1');
INSERT INTO `django_admin_log` VALUES ('11', '2018-11-28 07:27:08', '4', '数据结构常见的八大排序算法-4', '1', '[{\"added\": {}}]', '9', '1');
INSERT INTO `django_admin_log` VALUES ('12', '2018-11-28 07:42:06', '4', '数据结构常见的八大排序算法-4', '2', '[{\"changed\": {\"fields\": [\"content\"]}}]', '9', '1');
INSERT INTO `django_admin_log` VALUES ('13', '2018-11-28 08:47:37', '1', 'JavaScript', '1', '[{\"added\": {}}]', '11', '1');
INSERT INTO `django_admin_log` VALUES ('14', '2018-11-28 08:47:41', '2', 'python', '1', '[{\"added\": {}}]', '11', '1');
INSERT INTO `django_admin_log` VALUES ('15', '2018-11-28 08:47:47', '3', 'Git', '1', '[{\"added\": {}}]', '11', '1');
INSERT INTO `django_admin_log` VALUES ('16', '2018-11-28 09:22:12', '1', 'python', '1', '[{\"added\": {}}]', '13', '1');
INSERT INTO `django_admin_log` VALUES ('17', '2018-11-28 09:22:28', '2', 'Git', '1', '[{\"added\": {}}]', '13', '1');
INSERT INTO `django_admin_log` VALUES ('18', '2018-11-28 10:03:11', '1', '【python教程】--【1】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('19', '2018-11-28 10:04:34', '1', 'python简介', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('20', '2018-11-29 01:00:56', '1', '【python教程】--【3】', '2', '[{\"changed\": {\"fields\": [\"ordernum\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('21', '2018-11-29 01:01:07', '1', '【python教程】--【1】', '2', '[{\"changed\": {\"fields\": [\"ordernum\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('22', '2018-12-01 06:11:24', '1', '【python简介】--【1】', '2', '[{\"changed\": {\"fields\": [\"title\", \"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('23', '2018-12-01 06:11:55', '2', '【安装python】--【2】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('24', '2018-12-01 06:12:20', '3', '【第一个python程序】--【3】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('25', '2018-12-01 06:13:15', '4', '【python基础】--【4】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('26', '2018-12-01 06:13:44', '5', '【函数】--【5】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('27', '2018-12-01 06:14:01', '6', '【高级特性】--【6】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('28', '2018-12-01 06:14:20', '7', '【函数式编程】--【7】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('29', '2018-12-01 06:14:45', '8', '【模块】--【8】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('30', '2018-12-01 06:15:30', '9', '【面向对象编程】--【9】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('31', '2018-12-01 06:15:58', '10', '【面向对象得高级编程】--【10】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('32', '2018-12-01 06:16:32', '11', '【错误、调试和测试】--【11】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('33', '2018-12-01 06:16:52', '12', '【IO编程】--【12】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('34', '2018-12-01 06:17:41', '13', '【进程和线程】--【13】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('35', '2018-12-01 06:18:19', '14', '【正则表达式】--【14】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('36', '2018-12-01 06:18:48', '15', '【常用内建模块】--【15】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('37', '2018-12-01 06:19:44', '16', '【常用第三方模块】--【16】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('38', '2018-12-01 06:20:22', '17', '【virtualenv】--【17】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('39', '2018-12-01 06:20:45', '18', '【图形界面】--【18】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('40', '2018-12-01 06:21:09', '19', '【网络编程】--【19】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('41', '2018-12-01 06:21:27', '20', '【电子邮件】--【20】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('42', '2018-12-01 06:21:43', '21', '【访问数据库】--【21】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('43', '2018-12-01 06:21:59', '22', '【web开发】--【22】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('44', '2018-12-01 06:22:18', '23', '【异步IO】--【23】', '1', '[{\"added\": {}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('45', '2018-12-01 06:36:15', '1', 'python解释器', '2', '[{\"changed\": {\"fields\": [\"title\", \"text\", \"article\"]}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('46', '2018-12-01 06:37:02', '2', '使用文本编辑器', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('47', '2018-12-01 06:37:56', '3', 'python代码运行助手', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('48', '2018-12-01 06:38:53', '3', 'python代码运行助手', '2', '[{\"changed\": {\"fields\": [\"text\", \"ordernum\"]}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('49', '2018-12-01 06:39:34', '4', '输入和输出', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('50', '2018-12-01 12:03:01', '5', '数据结构和变量 5', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('51', '2018-12-01 12:03:55', '6', '字符串和编码 6', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('52', '2018-12-01 12:04:49', '7', '使用list和tuple 7', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('53', '2018-12-01 12:05:31', '8', '条件判断 8', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('54', '2018-12-01 12:06:28', '9', '循环 9', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('55', '2018-12-01 12:07:11', '10', '使用dict和set 10', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('56', '2018-12-01 12:10:37', '11', '调用函数 11', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('57', '2018-12-01 12:11:12', '12', '定义函数 12', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('58', '2018-12-01 12:11:27', '13', '函数参数 13', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('59', '2018-12-01 12:12:21', '14', '递归函数 14', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('60', '2018-12-01 12:13:36', '15', '切片 15', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('61', '2018-12-01 12:14:16', '16', '迭代 16', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('62', '2018-12-01 12:15:32', '17', '列表生成式 17', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('63', '2018-12-01 12:16:25', '18', '生成器 18', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('64', '2018-12-01 12:16:55', '19', '迭代器 19', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('65', '2018-12-01 12:22:20', '20', '高阶函数 20', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('66', '2018-12-01 12:23:00', '21', '返回函数 21', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('67', '2018-12-01 12:23:32', '22', '匿名函数 22', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('68', '2018-12-01 12:24:22', '23', '装饰器 23', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('69', '2018-12-01 12:25:28', '24', '偏函数 24', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('70', '2018-12-01 12:26:19', '25', '使用模块 25', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('71', '2018-12-01 12:26:50', '26', '安装第三方模块 26', '1', '[{\"added\": {}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('72', '2018-12-02 12:41:35', '1', 'python解释器 1', '2', '[]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('73', '2018-12-02 12:41:47', '2', '使用文本编辑器 2', '2', '[]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('74', '2018-12-02 12:41:56', '3', 'python代码运行助手 3', '2', '[]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('75', '2018-12-02 12:42:01', '4', '输入和输出 4', '2', '[]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('76', '2018-12-02 12:42:06', '5', '数据结构和变量 5', '2', '[]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('77', '2018-12-02 12:42:15', '5', '数据结构和变量 5', '2', '[]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('78', '2018-12-02 13:56:18', '1', '【python简介】--【1】', '2', '[{\"changed\": {\"fields\": [\"ordernum\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('79', '2018-12-02 13:57:02', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"ordernum\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('80', '2018-12-02 13:57:39', '3', '【第一个python程序】--【3】', '2', '[{\"changed\": {\"fields\": [\"ordernum\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('81', '2018-12-02 13:58:01', '4', '【python基础】--【4】', '2', '[{\"changed\": {\"fields\": [\"ordernum\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('82', '2018-12-02 13:58:22', '6', '【高级特性】--【6】', '2', '[{\"changed\": {\"fields\": [\"ordernum\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('83', '2018-12-02 13:59:36', '8', '【模块】--【8】', '2', '[{\"changed\": {\"fields\": [\"ordernum\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('84', '2018-12-02 14:00:13', '11', '【错误、调试和测试】--【11】', '2', '[{\"changed\": {\"fields\": [\"ordernum\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('85', '2018-12-02 14:05:46', '2', '使用文本编辑器 2', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '15', '1');
INSERT INTO `django_admin_log` VALUES ('86', '2018-12-02 14:09:28', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('87', '2018-12-04 07:01:15', '1', '【python简介】--【1】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('88', '2018-12-04 07:08:03', '1', '【python简介】--【1】', '2', '[{\"changed\": {\"fields\": [\"text\", \"readcount\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('89', '2018-12-04 07:14:44', '1', '【python简介】--【1】', '2', '[{\"changed\": {\"fields\": [\"text\", \"readcount\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('90', '2018-12-04 07:19:54', '1', '【python简介】--【1】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('91', '2018-12-05 04:18:53', '1', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'dfsdffds\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('92', '2018-12-05 04:23:03', '2', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'ahhahahha\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('93', '2018-12-05 04:26:59', '3', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'hahhahhaha\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('94', '2018-12-05 04:54:30', '6', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'hello\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('95', '2018-12-05 04:54:30', '5', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'gfgfhh\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('96', '2018-12-05 04:54:31', '4', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'hahhahhaha\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('97', '2018-12-05 05:19:00', '7', '【sunli】--【bdfdgdgdgg】', '1', '[{\"added\": {}}]', '17', '1');
INSERT INTO `django_admin_log` VALUES ('98', '2018-12-05 06:23:28', '13', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\\n\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('99', '2018-12-05 06:23:28', '12', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'\\u54c8\\u54c8\\u54c8\\u54c8\\u53d1\\u4e24\\u4efd\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('100', '2018-12-05 06:23:29', '11', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('101', '2018-12-05 06:23:29', '10', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'svfsdfsafsd\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('102', '2018-12-05 06:23:29', '9', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'grsdsddg\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('103', '2018-12-05 06:23:29', '8', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'sdfgfgsgfds\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('104', '2018-12-05 06:23:29', '7', '【sunli】--【bdfdgdgdgg】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('105', '2018-12-06 19:46:46', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('106', '2018-12-06 19:57:43', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('107', '2018-12-06 20:04:21', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('108', '2018-12-06 20:05:22', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('109', '2018-12-06 20:06:59', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\", \"readcount\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('110', '2018-12-06 20:12:57', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\", \"readcount\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('111', '2018-12-07 03:51:25', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('112', '2018-12-07 03:55:16', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('113', '2018-12-07 04:01:30', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('114', '2018-12-07 04:05:10', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('115', '2018-12-07 04:06:29', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('116', '2018-12-07 04:07:47', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('117', '2018-12-07 04:09:14', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('118', '2018-12-07 04:10:45', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('119', '2018-12-07 04:11:18', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('120', '2018-12-07 05:49:31', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('121', '2018-12-07 05:51:08', '1', '【python简介】--【1】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('122', '2018-12-07 05:53:09', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('123', '2018-12-07 06:02:49', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('124', '2018-12-07 06:05:53', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('125', '2018-12-07 06:07:17', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('126', '2018-12-07 06:07:46', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('127', '2018-12-07 06:08:00', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('128', '2018-12-07 06:22:33', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('129', '2018-12-07 06:25:44', '2', '【安装python】--【2】', '2', '[{\"changed\": {\"fields\": [\"text\"]}}]', '14', '1');
INSERT INTO `django_admin_log` VALUES ('130', '2018-12-08 18:11:15', '3', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'\\u54c8\\u54c8\\u54c8\\u54c8\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('131', '2018-12-08 18:11:15', '2', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('132', '2018-12-08 18:11:15', '1', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'hello\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('133', '2018-12-08 18:13:11', '5', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'\\u54c8\\u54c8\\u54c8\\u54c8\\xb7\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('134', '2018-12-08 18:13:11', '4', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('135', '2018-12-08 18:13:53', '6', '【sunli】--【<QueryDict: {u\'cm_text\': [u\'\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\']}>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('136', '2018-12-08 19:43:57', '3', 'bdd', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('137', '2018-12-18 03:09:29', '2', 'sunli', '3', '', '8', '1');
INSERT INTO `django_admin_log` VALUES ('138', '2018-12-20 09:20:30', '13', '【sunli】--【一点反应都没】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('139', '2018-12-20 09:20:30', '12', '【sunli】--【哈哈哈哈哈】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('140', '2018-12-20 09:20:30', '11', '【bdd】--【<div></div>】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('141', '2018-12-20 09:28:34', '14', '【sunli】--【sfaffaffafaf】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('142', '2018-12-21 09:31:21', '16', '【sunli】--【写的不错\n】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('143', '2018-12-21 09:31:21', '15', '【bdd】--【哈哈哈哈哈】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('144', '2018-12-21 09:31:21', '10', '【bdd】--【对于python方面的东西很有兴趣\n】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('145', '2018-12-21 09:36:27', '17', '【bdd】--【收益匪浅！】', '3', '', '17', '1');
INSERT INTO `django_admin_log` VALUES ('146', '2018-12-22 01:48:55', '11', '【sunli】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('147', '2018-12-22 01:48:56', '10', '【sunli】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('148', '2018-12-22 01:48:56', '9', '【sunli】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('149', '2018-12-22 07:39:37', '12', '【sunli】--【挺好的，嘿嘿】--【bdd】', '1', '[{\"added\": {}}]', '16', '1');
INSERT INTO `django_admin_log` VALUES ('150', '2018-12-22 07:40:43', '5', 'kobe', '1', '[{\"added\": {}}]', '8', '1');
INSERT INTO `django_admin_log` VALUES ('151', '2018-12-22 07:41:56', '13', '【sunli】--【嘿嘿嘿嘿嘿嘿！！！！！！！！！！！】--【kobe】', '1', '[{\"added\": {}}]', '16', '1');
INSERT INTO `django_admin_log` VALUES ('152', '2018-12-22 07:43:10', '14', '【kobe】--【very nice ,today!!】--【bdd】', '1', '[{\"added\": {}}]', '16', '1');
INSERT INTO `django_admin_log` VALUES ('153', '2018-12-22 13:34:04', '18', '【【kobe】--【what fuck】】--【undefined】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('154', '2018-12-22 13:34:04', '17', '【【kobe】--【what fuck】】--【undefined】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('155', '2018-12-22 13:34:04', '16', '【【kobe】--【what fuck】】--【undefined】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('156', '2018-12-22 13:34:04', '15', '【【kobe】--【what fuck】】--【undefined】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('157', '2018-12-23 06:43:19', '29', '【【sunli】--【hhhhh】】--【撒发生大发发顺丰】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('158', '2018-12-23 06:43:19', '28', '【【sunli】--【咋回事啊！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('159', '2018-12-23 06:43:19', '27', '【【sunli】--【还不错，我觉得收益匪浅！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('160', '2018-12-23 06:43:19', '26', '【【sunli】--【鸡毛东西】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('161', '2018-12-23 06:43:19', '25', '【【sunli】--【啥玩意啊】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('162', '2018-12-23 06:43:20', '24', '【【kobe】--【what fuck】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('163', '2018-12-23 06:43:20', '29', '【【sunli】--【hhhhh】】--【撒发生大发发顺丰】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('164', '2018-12-23 06:43:20', '23', '【【sunli】--【咋回事啊！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('165', '2018-12-23 06:43:20', '22', '【【sunli】--【可以的哟！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('166', '2018-12-23 06:43:20', '28', '【【sunli】--【咋回事啊！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('167', '2018-12-23 06:43:20', '21', '【【sunli】--【可以的哟！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('168', '2018-12-23 06:43:20', '27', '【【sunli】--【还不错，我觉得收益匪浅！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('169', '2018-12-23 06:43:20', '20', '【【sunli】--【哈哈哈哈哈】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('170', '2018-12-23 06:43:20', '26', '【【sunli】--【鸡毛东西】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('171', '2018-12-23 06:43:20', '19', '【【kobe】--【what fuck】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('172', '2018-12-23 06:43:20', '25', '【【sunli】--【啥玩意啊】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('173', '2018-12-23 06:43:20', '14', '【【kobe】--【what fuck】】--【very nice ,today!!】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('174', '2018-12-23 06:43:20', '24', '【【kobe】--【what fuck】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('175', '2018-12-23 06:43:20', '13', '【【sunli】--【啥玩意啊】】--【嘿嘿嘿嘿嘿嘿！！！！！！！！！！！】--【kobe】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('176', '2018-12-23 06:43:21', '23', '【【sunli】--【咋回事啊！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('177', '2018-12-23 06:43:21', '22', '【【sunli】--【可以的哟！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('178', '2018-12-23 06:43:21', '12', '【【sunli】--【hhhhh】】--【挺好的，嘿嘿】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('179', '2018-12-23 06:43:21', '21', '【【sunli】--【可以的哟！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('180', '2018-12-23 06:43:21', '8', '【【bdd】--【哈哈哈哈哈哈】】--【真好！】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('181', '2018-12-23 06:43:21', '20', '【【sunli】--【哈哈哈哈哈】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('182', '2018-12-23 06:43:21', '7', '【【bdd】--【哈哈哈哈哈哈】】--【哈哈哈哈哈哈】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('183', '2018-12-23 06:43:21', '19', '【【kobe】--【what fuck】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('184', '2018-12-23 06:43:21', '29', '【【sunli】--【hhhhh】】--【撒发生大发发顺丰】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('185', '2018-12-23 06:43:21', '6', '【【bdd】--【哈哈哈哈哈哈】】--【ahahhha】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('186', '2018-12-23 06:43:21', '14', '【【kobe】--【what fuck】】--【very nice ,today!!】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('187', '2018-12-23 06:43:21', '28', '【【sunli】--【咋回事啊！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('188', '2018-12-23 06:43:21', '27', '【【sunli】--【还不错，我觉得收益匪浅！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('189', '2018-12-23 06:43:21', '13', '【【sunli】--【啥玩意啊】】--【嘿嘿嘿嘿嘿嘿！！！！！！！！！！！】--【kobe】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('190', '2018-12-23 06:43:21', '26', '【【sunli】--【鸡毛东西】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('191', '2018-12-23 06:43:21', '12', '【【sunli】--【hhhhh】】--【挺好的，嘿嘿】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('192', '2018-12-23 06:43:21', '25', '【【sunli】--【啥玩意啊】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('193', '2018-12-23 06:43:21', '8', '【【bdd】--【哈哈哈哈哈哈】】--【真好！】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('194', '2018-12-23 06:43:21', '24', '【【kobe】--【what fuck】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('195', '2018-12-23 06:43:21', '7', '【【bdd】--【哈哈哈哈哈哈】】--【哈哈哈哈哈哈】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('196', '2018-12-23 06:43:21', '23', '【【sunli】--【咋回事啊！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('197', '2018-12-23 06:43:22', '6', '【【bdd】--【哈哈哈哈哈哈】】--【ahahhha】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('198', '2018-12-23 06:43:22', '22', '【【sunli】--【可以的哟！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('199', '2018-12-23 06:43:22', '21', '【【sunli】--【可以的哟！】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('200', '2018-12-23 06:43:22', '20', '【【sunli】--【哈哈哈哈哈】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('201', '2018-12-23 06:43:22', '19', '【【kobe】--【what fuck】】--【undefined】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('202', '2018-12-23 06:43:22', '14', '【【kobe】--【what fuck】】--【very nice ,today!!】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('203', '2018-12-23 06:43:22', '13', '【【sunli】--【啥玩意啊】】--【嘿嘿嘿嘿嘿嘿！！！！！！！！！！！】--【kobe】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('204', '2018-12-23 06:43:22', '12', '【【sunli】--【hhhhh】】--【挺好的，嘿嘿】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('205', '2018-12-23 06:43:22', '8', '【【bdd】--【哈哈哈哈哈哈】】--【真好！】--【sunli】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('206', '2018-12-23 06:43:22', '7', '【【bdd】--【哈哈哈哈哈哈】】--【哈哈哈哈哈哈】--【bdd】', '3', '', '16', '1');
INSERT INTO `django_admin_log` VALUES ('207', '2018-12-23 06:43:23', '6', '【【bdd】--【哈哈哈哈哈哈】】--【ahahhha】--【bdd】', '3', '', '16', '1');

-- ----------------------------
-- Table structure for `django_content_type`
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('9', 'activates', 'activate');
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('13', 'blog_teach', 'teach_title');
INSERT INTO `django_content_type` VALUES ('10', 'comment', 'comment_bases');
INSERT INTO `django_content_type` VALUES ('17', 'comment_s', 'comment_ss');
INSERT INTO `django_content_type` VALUES ('16', 'comment_s', 'comment_ss_s');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('7', 'sites', 'site');
INSERT INTO `django_content_type` VALUES ('12', 'teaching', 'mulu');
INSERT INTO `django_content_type` VALUES ('11', 'teaching', 'teachiing_text');
INSERT INTO `django_content_type` VALUES ('15', 'teach_blog', 'j_title');
INSERT INTO `django_content_type` VALUES ('14', 'teach_blog', 'z_title');
INSERT INTO `django_content_type` VALUES ('8', 'User', 'usertwo');

-- ----------------------------
-- Table structure for `django_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2018-11-26 11:19:44');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2018-11-26 11:19:57');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2018-11-26 11:19:59');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2018-11-26 11:19:59');
INSERT INTO `django_migrations` VALUES ('5', 'contenttypes', '0002_remove_content_type_name', '2018-11-26 11:20:00');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0002_alter_permission_name_max_length', '2018-11-26 11:20:01');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0003_alter_user_email_max_length', '2018-11-26 11:20:02');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0004_alter_user_username_opts', '2018-11-26 11:20:02');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0005_alter_user_last_login_null', '2018-11-26 11:20:02');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0006_require_contenttypes_0002', '2018-11-26 11:20:02');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0007_alter_validators_add_error_messages', '2018-11-26 11:20:02');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0008_alter_user_username_max_length', '2018-11-26 11:20:03');
INSERT INTO `django_migrations` VALUES ('13', 'sessions', '0001_initial', '2018-11-26 11:20:04');
INSERT INTO `django_migrations` VALUES ('14', 'sites', '0001_initial', '2018-11-26 11:20:05');
INSERT INTO `django_migrations` VALUES ('15', 'sites', '0002_alter_domain_unique', '2018-11-26 11:20:05');
INSERT INTO `django_migrations` VALUES ('16', 'User', '0001_initial', '2018-11-26 11:38:13');
INSERT INTO `django_migrations` VALUES ('17', 'activates', '0001_initial', '2018-11-28 03:50:10');
INSERT INTO `django_migrations` VALUES ('18', 'comment', '0001_initial', '2018-11-28 03:55:02');
INSERT INTO `django_migrations` VALUES ('19', 'teaching', '0001_initial', '2018-11-28 08:45:12');
INSERT INTO `django_migrations` VALUES ('20', 'blog_teach', '0001_initial', '2018-11-28 09:20:11');
INSERT INTO `django_migrations` VALUES ('21', 'teach_blog', '0001_initial', '2018-11-28 09:59:17');
INSERT INTO `django_migrations` VALUES ('22', 'comment_s', '0001_initial', '2018-12-04 12:59:32');

-- ----------------------------
-- Table structure for `django_session`
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('1hjev3zjnt38zqkc6l3uiga1pq8a04ex', 'MTBlNDcwZWU4ODBlZDQ2NDFiZTk2NzM2YTM1NTVkNWM5ZDBmYTFkYjp7InVzZXJuYW1lIjoic3VubGkiLCJwYXNzd29ybGQiOiJzMTk5NjEyMjQiLCJfc2Vzc2lvbl9leHBpcnkiOjAsImlzX2xvZ2luIjp0cnVlfQ==', '2018-12-29 11:27:32');
INSERT INTO `django_session` VALUES ('7wehd4pkyuw1zni5jtffiy6nfsxqtros', 'N2JlMDYzMWFhOTBlMDBjMTBlYjk4YmNjMGUwYzA2YTcxY2QzMTUzNjp7InVzZXJuYW1lIjoic3VubGkiLCJwYXNzd29ybGQiOiJzMTk5NjEyMjRsIiwiaXNfbG9naW4iOnRydWUsIl9zZXNzaW9uX2V4cGlyeSI6MH0=', '2019-01-03 08:23:18');
INSERT INTO `django_session` VALUES ('7wrfc615l4yb55ped71a5opcc0logxsv', 'M2Q1OWI5NmJlMjU4MDk3NGFjNWFmMmViNzkwYTk0MzgxZjYzYTRlODp7InVzZXJuYW1lIjoiYmRkIiwicGFzc3dvcmxkIjoiczE5OTYxMjI0IiwiX3Nlc3Npb25fZXhwaXJ5IjowLCJpc19sb2dpbiI6dHJ1ZX0=', '2019-01-03 07:27:02');
INSERT INTO `django_session` VALUES ('7xado3m3er0n3w2207547f0pp27mqxyp', 'YzQyNWQxMDA0M2Y0MmFlZWJiOGU5ZGE1YTFiNDFjYTNjMjRiMjZlZDp7InVzZXJuYW1lIjoic3VubGkiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX3Nlc3Npb25fZXhwaXJ5IjowLCJfYXV0aF91c2VyX2hhc2giOiJlYzc3NjEwZDRjZjY1YjYzMDg4YWEwZjZiNWQ2MTc3NzlhYTlkNGRkIiwicGFzc3dvcmxkIjoiczE5OTYxMjI0bCIsImlzX2xvZ2luIjp0cnVlfQ==', '2019-01-06 06:43:47');
INSERT INTO `django_session` VALUES ('8ur3f88fmvk0mdwudsvymby2ozpw1myo', 'NjJhZDNiOTcxYWNiNmE1ZDkzZWQ0NzQ1NTQ0YjE3YzNjMTRhYTJhNjp7InVzZXJuYW1lIjoiYmRkIiwicGFzc3dvcmxkIjoiczE5OTYxMjI0IiwiaXNfbG9naW4iOnRydWUsIl9zZXNzaW9uX2V4cGlyeSI6MH0=', '2019-01-03 07:28:07');
INSERT INTO `django_session` VALUES ('8ye7xsg1fd2qkg5d5ypxc5yytdtwye0u', 'YWJiNGEzM2NjNzE0YjZhMDlkZjIyYWI2YjExNjEwYTUzZGM0NTMxNzp7ImNvZGVfMyI6IlM0NE1EUyJ9', '2018-12-30 06:45:52');
INSERT INTO `django_session` VALUES ('b7fjyuipg8rwsqvxt8kdz0lnutll8pay', 'MDg0MTcxOWQwYTU5MTRhNDIxYjc2ZWJjMWZmOTQ5N2FhN2I3NjhkNjp7Il9hdXRoX3VzZXJfaGFzaCI6ImVjNzc2MTBkNGNmNjViNjMwODhhYTBmNmI1ZDYxNzc3OWFhOWQ0ZGQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=', '2018-12-12 09:25:33');
INSERT INTO `django_session` VALUES ('bb38adeaqko4nvnil4lp0vy0ra24ljeb', 'Y2E3Yjg1ZGQ0NWZmZTcyZWE1NTljYzUxOTVkZTQ2YzA0OWYyNWRjYzp7InVzZXJuYW1lIjoic3VubGkiLCJwYXNzd29ybGQiOiJzMTk5NjEyMjRsIiwiX3Nlc3Npb25fZXhwaXJ5IjowLCJpc19sb2dpbiI6dHJ1ZX0=', '2019-01-03 07:58:32');
INSERT INTO `django_session` VALUES ('cr8b7rd9k8xo6slivm5ej4pvkflpew2b', 'YWU3MmU2OTFlMmFiMDFhNDdkNGZmNjJiNmUwNjY4MTg4YjAxYmFiNzp7InVzZXJuYW1lIjoiYmRkIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9zZXNzaW9uX2V4cGlyeSI6MCwiX2F1dGhfdXNlcl9oYXNoIjoiZWM3NzYxMGQ0Y2Y2NWI2MzA4OGFhMGY2YjVkNjE3Nzc5YWE5ZDRkZCIsInBhc3N3b3JsZCI6InMxOTk2MTIyNCIsImlzX2xvZ2luIjp0cnVlfQ==', '2019-01-03 11:17:17');
INSERT INTO `django_session` VALUES ('d3ja6neozdggueo56aiqm0t7lj1ce840', 'Y2E3Yjg1ZGQ0NWZmZTcyZWE1NTljYzUxOTVkZTQ2YzA0OWYyNWRjYzp7InVzZXJuYW1lIjoic3VubGkiLCJwYXNzd29ybGQiOiJzMTk5NjEyMjRsIiwiX3Nlc3Npb25fZXhwaXJ5IjowLCJpc19sb2dpbiI6dHJ1ZX0=', '2019-01-03 07:52:19');
INSERT INTO `django_session` VALUES ('dtsmhefl632ypm9qm69br2856by2h8ow', 'MDg0MTcxOWQwYTU5MTRhNDIxYjc2ZWJjMWZmOTQ5N2FhN2I3NjhkNjp7Il9hdXRoX3VzZXJfaGFzaCI6ImVjNzc2MTBkNGNmNjViNjMwODhhYTBmNmI1ZDYxNzc3OWFhOWQ0ZGQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=', '2019-01-03 12:52:07');
INSERT INTO `django_session` VALUES ('ewpe6t5o0hjkwntol0qtmp1j6b2eageh', 'MTBlNDcwZWU4ODBlZDQ2NDFiZTk2NzM2YTM1NTVkNWM5ZDBmYTFkYjp7InVzZXJuYW1lIjoic3VubGkiLCJwYXNzd29ybGQiOiJzMTk5NjEyMjQiLCJfc2Vzc2lvbl9leHBpcnkiOjAsImlzX2xvZ2luIjp0cnVlfQ==', '2018-12-29 11:35:32');
INSERT INTO `django_session` VALUES ('iiwqerv4ogyy7kb4k49p602j07yqirr7', 'MjgyNmFlYjU2MGZmNzE0NzBkZWEwNWIzNjgyNzhhMTFkYWU3MjUxNjp7ImNvZGVfMyI6Ijg1VDMxMCJ9', '2018-12-12 01:33:55');
INSERT INTO `django_session` VALUES ('k4zo4yzy31ox1seu7ien6snlu4fl1mrj', 'ZTA0MWRjNTY5ZDc4YmY1NjQ5YTdlY2QxZmM3ZmRjMDQ2ZTI0NzYyNDp7InVzZXJuYW1lIjoic3VubGkiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX3Nlc3Npb25fZXhwaXJ5IjowLCJfYXV0aF91c2VyX2hhc2giOiJlYzc3NjEwZDRjZjY1YjYzMDg4YWEwZjZiNWQ2MTc3NzlhYTlkNGRkIiwicGFzc3dvcmxkIjoiczE5OTYxMjI0IiwiaXNfbG9naW4iOnRydWV9', '2018-12-22 19:37:41');
INSERT INTO `django_session` VALUES ('mpz8997n7jjmpn6x8b60ycln7bx1lphx', 'YWU3MmU2OTFlMmFiMDFhNDdkNGZmNjJiNmUwNjY4MTg4YjAxYmFiNzp7InVzZXJuYW1lIjoiYmRkIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9zZXNzaW9uX2V4cGlyeSI6MCwiX2F1dGhfdXNlcl9oYXNoIjoiZWM3NzYxMGQ0Y2Y2NWI2MzA4OGFhMGY2YjVkNjE3Nzc5YWE5ZDRkZCIsInBhc3N3b3JsZCI6InMxOTk2MTIyNCIsImlzX2xvZ2luIjp0cnVlfQ==', '2018-12-22 19:44:45');
INSERT INTO `django_session` VALUES ('n35qx9qxdwu4co8kwubr5vhu26t3anme', 'YzQxMzRlNzY2Zjg0ZjFkYTIwMjA0MjQ5ZDYwMWUzYjk0NjY3OTM3Mzp7Il9hdXRoX3VzZXJfaGFzaCI6ImVjNzc2MTBkNGNmNjViNjMwODhhYTBmNmI1ZDYxNzc3OWFhOWQ0ZGQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2018-12-12 09:07:48');
INSERT INTO `django_session` VALUES ('ofae0p1mxp1r37vxoop8roafjanofnjs', 'M2Q1OWI5NmJlMjU4MDk3NGFjNWFmMmViNzkwYTk0MzgxZjYzYTRlODp7InVzZXJuYW1lIjoiYmRkIiwicGFzc3dvcmxkIjoiczE5OTYxMjI0IiwiX3Nlc3Npb25fZXhwaXJ5IjowLCJpc19sb2dpbiI6dHJ1ZX0=', '2019-01-03 07:49:46');
INSERT INTO `django_session` VALUES ('op8y8us7lno76r9e40b0yiysh5ycozci', 'NTI1NTgzZjI2M2ZlY2FiODI5NDJmZTJlNWZhOGJiYzNkMTI2YWY4MTp7fQ==', '2018-12-10 11:29:43');
INSERT INTO `django_session` VALUES ('py8v4q2vltdfkpsahe3hyjijyg20jov0', 'YWU3MmU2OTFlMmFiMDFhNDdkNGZmNjJiNmUwNjY4MTg4YjAxYmFiNzp7InVzZXJuYW1lIjoiYmRkIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9zZXNzaW9uX2V4cGlyeSI6MCwiX2F1dGhfdXNlcl9oYXNoIjoiZWM3NzYxMGQ0Y2Y2NWI2MzA4OGFhMGY2YjVkNjE3Nzc5YWE5ZDRkZCIsInBhc3N3b3JsZCI6InMxOTk2MTIyNCIsImlzX2xvZ2luIjp0cnVlfQ==', '2019-01-03 07:05:52');
INSERT INTO `django_session` VALUES ('rfw8znxpc1376pm9f9lq7ngolqncew7m', 'ZTA0MWRjNTY5ZDc4YmY1NjQ5YTdlY2QxZmM3ZmRjMDQ2ZTI0NzYyNDp7InVzZXJuYW1lIjoic3VubGkiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX3Nlc3Npb25fZXhwaXJ5IjowLCJfYXV0aF91c2VyX2hhc2giOiJlYzc3NjEwZDRjZjY1YjYzMDg4YWEwZjZiNWQ2MTc3NzlhYTlkNGRkIiwicGFzc3dvcmxkIjoiczE5OTYxMjI0IiwiaXNfbG9naW4iOnRydWV9', '2018-12-19 06:20:54');
INSERT INTO `django_session` VALUES ('rnkncrkcci15ns8boh0n219lxb3mp15o', 'Njk2NDcwZWRkNTVmNTkzYTVlNjRjMWQxYjFkMTM4NGViNjExMzVjYjp7InVzZXJuYW1lIjoic3VubGkiLCJwYXNzd29ybGQiOiJzMTk5NjEyMjQiLCJpc19sb2dpbiI6dHJ1ZSwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==', '2018-12-22 19:39:34');
INSERT INTO `django_session` VALUES ('rp2g0iq12o46qkbnxlq848m56jyce2yl', 'M2Q1OWI5NmJlMjU4MDk3NGFjNWFmMmViNzkwYTk0MzgxZjYzYTRlODp7InVzZXJuYW1lIjoiYmRkIiwicGFzc3dvcmxkIjoiczE5OTYxMjI0IiwiX3Nlc3Npb25fZXhwaXJ5IjowLCJpc19sb2dpbiI6dHJ1ZX0=', '2019-01-03 14:32:00');
INSERT INTO `django_session` VALUES ('s31nrxb9jugk34vdeupi3qchbw62i3py', 'ZTA0MWRjNTY5ZDc4YmY1NjQ5YTdlY2QxZmM3ZmRjMDQ2ZTI0NzYyNDp7InVzZXJuYW1lIjoic3VubGkiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX3Nlc3Npb25fZXhwaXJ5IjowLCJfYXV0aF91c2VyX2hhc2giOiJlYzc3NjEwZDRjZjY1YjYzMDg4YWEwZjZiNWQ2MTc3NzlhYTlkNGRkIiwicGFzc3dvcmxkIjoiczE5OTYxMjI0IiwiaXNfbG9naW4iOnRydWV9', '2018-12-12 04:36:03');
INSERT INTO `django_session` VALUES ('s329iqe1lach96qota6slnb9bfu2b3z4', 'NjJhZDNiOTcxYWNiNmE1ZDkzZWQ0NzQ1NTQ0YjE3YzNjMTRhYTJhNjp7InVzZXJuYW1lIjoiYmRkIiwicGFzc3dvcmxkIjoiczE5OTYxMjI0IiwiaXNfbG9naW4iOnRydWUsIl9zZXNzaW9uX2V4cGlyeSI6MH0=', '2019-01-03 07:12:39');
INSERT INTO `django_session` VALUES ('sakkmhx5uw6ooq487ui85sqrfil7bhy5', 'MTBlNDcwZWU4ODBlZDQ2NDFiZTk2NzM2YTM1NTVkNWM5ZDBmYTFkYjp7InVzZXJuYW1lIjoic3VubGkiLCJwYXNzd29ybGQiOiJzMTk5NjEyMjQiLCJfc2Vzc2lvbl9leHBpcnkiOjAsImlzX2xvZ2luIjp0cnVlfQ==', '2018-12-19 05:30:07');
INSERT INTO `django_session` VALUES ('tzf2c2nphandgng56kfbvaw6ln1ya6nd', 'YzQxMzRlNzY2Zjg0ZjFkYTIwMjA0MjQ5ZDYwMWUzYjk0NjY3OTM3Mzp7Il9hdXRoX3VzZXJfaGFzaCI6ImVjNzc2MTBkNGNmNjViNjMwODhhYTBmNmI1ZDYxNzc3OWFhOWQ0ZGQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2019-01-05 13:34:20');
INSERT INTO `django_session` VALUES ('wkqxdzpwz3mlacccdiqqwpj2eoax11ha', 'YzQxMzRlNzY2Zjg0ZjFkYTIwMjA0MjQ5ZDYwMWUzYjk0NjY3OTM3Mzp7Il9hdXRoX3VzZXJfaGFzaCI6ImVjNzc2MTBkNGNmNjViNjMwODhhYTBmNmI1ZDYxNzc3OWFhOWQ0ZGQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2018-12-12 08:54:55');
INSERT INTO `django_session` VALUES ('xxqa1e5mz3jfzdwbb22eekmlykquk4o5', 'NjJhZDNiOTcxYWNiNmE1ZDkzZWQ0NzQ1NTQ0YjE3YzNjMTRhYTJhNjp7InVzZXJuYW1lIjoiYmRkIiwicGFzc3dvcmxkIjoiczE5OTYxMjI0IiwiaXNfbG9naW4iOnRydWUsIl9zZXNzaW9uX2V4cGlyeSI6MH0=', '2019-01-04 08:07:45');
INSERT INTO `django_session` VALUES ('xy2ttgadbx2rg6sx2hjijrweihoux803', 'Y2E3Yjg1ZGQ0NWZmZTcyZWE1NTljYzUxOTVkZTQ2YzA0OWYyNWRjYzp7InVzZXJuYW1lIjoic3VubGkiLCJwYXNzd29ybGQiOiJzMTk5NjEyMjRsIiwiX3Nlc3Npb25fZXhwaXJ5IjowLCJpc19sb2dpbiI6dHJ1ZX0=', '2019-01-03 11:11:03');
INSERT INTO `django_session` VALUES ('xygpdf2t6x3rbftxtul9u3hyx6z0o65d', 'MDg0MTcxOWQwYTU5MTRhNDIxYjc2ZWJjMWZmOTQ5N2FhN2I3NjhkNjp7Il9hdXRoX3VzZXJfaGFzaCI6ImVjNzc2MTBkNGNmNjViNjMwODhhYTBmNmI1ZDYxNzc3OWFhOWQ0ZGQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=', '2018-12-12 06:56:42');
INSERT INTO `django_session` VALUES ('y8cfil8yvl8jqw7qiymocbykf9hj9vrb', 'YWU3MmU2OTFlMmFiMDFhNDdkNGZmNjJiNmUwNjY4MTg4YjAxYmFiNzp7InVzZXJuYW1lIjoiYmRkIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9zZXNzaW9uX2V4cGlyeSI6MCwiX2F1dGhfdXNlcl9oYXNoIjoiZWM3NzYxMGQ0Y2Y2NWI2MzA4OGFhMGY2YjVkNjE3Nzc5YWE5ZDRkZCIsInBhc3N3b3JsZCI6InMxOTk2MTIyNCIsImlzX2xvZ2luIjp0cnVlfQ==', '2019-01-05 08:26:37');
INSERT INTO `django_session` VALUES ('ymk1s8lfqosyt89uq9dbtw0pcukvi1vv', 'MDg0MTcxOWQwYTU5MTRhNDIxYjc2ZWJjMWZmOTQ5N2FhN2I3NjhkNjp7Il9hdXRoX3VzZXJfaGFzaCI6ImVjNzc2MTBkNGNmNjViNjMwODhhYTBmNmI1ZDYxNzc3OWFhOWQ0ZGQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=', '2018-12-12 07:13:11');

-- ----------------------------
-- Table structure for `django_site`
-- ----------------------------
DROP TABLE IF EXISTS `django_site`;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_site
-- ----------------------------
INSERT INTO `django_site` VALUES ('1', 'example.com', 'example.com');

-- ----------------------------
-- Table structure for `teach_blog_j_title`
-- ----------------------------
DROP TABLE IF EXISTS `teach_blog_j_title`;
CREATE TABLE `teach_blog_j_title` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(70) NOT NULL,
  `text` longtext NOT NULL,
  `ordernum` int(10) unsigned NOT NULL,
  `readcount` int(10) unsigned NOT NULL,
  `article_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `teach_blog_j_title_article_id_db5f4ee2_fk_teach_blog_z_title_id` (`article_id`),
  CONSTRAINT `teach_blog_j_title_article_id_db5f4ee2_fk_teach_blog_z_title_id` FOREIGN KEY (`article_id`) REFERENCES `teach_blog_z_title` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teach_blog_j_title
-- ----------------------------
INSERT INTO `teach_blog_j_title` VALUES ('1', 'python解释器', '<p>1</p>', '1', '10', '2');
INSERT INTO `teach_blog_j_title` VALUES ('2', '使用文本编辑器', '<p>哈哈哈哈哈</p>', '2', '1', '3');
INSERT INTO `teach_blog_j_title` VALUES ('3', 'python代码运行助手', '<p>3</p>', '3', '1', '3');
INSERT INTO `teach_blog_j_title` VALUES ('4', '输入和输出', '4', '4', '0', '3');
INSERT INTO `teach_blog_j_title` VALUES ('5', '数据结构和变量', '<p>5</p>', '5', '1', '4');
INSERT INTO `teach_blog_j_title` VALUES ('6', '字符串和编码', '6', '6', '0', '4');
INSERT INTO `teach_blog_j_title` VALUES ('7', '使用list和tuple', '7', '7', '0', '4');
INSERT INTO `teach_blog_j_title` VALUES ('8', '条件判断', '8', '8', '0', '4');
INSERT INTO `teach_blog_j_title` VALUES ('9', '循环', '9', '9', '0', '4');
INSERT INTO `teach_blog_j_title` VALUES ('10', '使用dict和set', '10', '10', '0', '4');
INSERT INTO `teach_blog_j_title` VALUES ('11', '调用函数', '<p>11</p>', '11', '11', '5');
INSERT INTO `teach_blog_j_title` VALUES ('12', '定义函数', '<p>12</p>', '12', '1', '5');
INSERT INTO `teach_blog_j_title` VALUES ('13', '函数参数', '13', '13', '0', '5');
INSERT INTO `teach_blog_j_title` VALUES ('14', '递归函数', '14', '14', '0', '5');
INSERT INTO `teach_blog_j_title` VALUES ('15', '切片', '15', '15', '0', '6');
INSERT INTO `teach_blog_j_title` VALUES ('16', '迭代', '16', '16', '0', '6');
INSERT INTO `teach_blog_j_title` VALUES ('17', '列表生成式', '17', '17', '0', '6');
INSERT INTO `teach_blog_j_title` VALUES ('18', '生成器', '18', '18', '0', '6');
INSERT INTO `teach_blog_j_title` VALUES ('19', '迭代器', '19', '19', '0', '6');
INSERT INTO `teach_blog_j_title` VALUES ('20', '高阶函数', '20', '20', '0', '7');
INSERT INTO `teach_blog_j_title` VALUES ('21', '返回函数', '<p>21</p>', '21', '1', '7');
INSERT INTO `teach_blog_j_title` VALUES ('22', '匿名函数', '22', '22', '0', '7');
INSERT INTO `teach_blog_j_title` VALUES ('23', '装饰器', '23', '23', '0', '7');
INSERT INTO `teach_blog_j_title` VALUES ('24', '偏函数', '24', '24', '0', '7');
INSERT INTO `teach_blog_j_title` VALUES ('25', '使用模块', '<p>25</p>', '25', '4', '8');
INSERT INTO `teach_blog_j_title` VALUES ('26', '安装第三方模块', '<p>26</p>', '26', '4', '8');

-- ----------------------------
-- Table structure for `teach_blog_z_title`
-- ----------------------------
DROP TABLE IF EXISTS `teach_blog_z_title`;
CREATE TABLE `teach_blog_z_title` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(70) NOT NULL,
  `text` longtext NOT NULL,
  `ordernum` int(10) unsigned NOT NULL,
  `readcount` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teach_blog_z_title
-- ----------------------------
INSERT INTO `teach_blog_z_title` VALUES ('1', 'python简介', '<p>Python 是一个高层次的结合了解释性、编译性、互动性和面向对象的脚本语言。</p>\n\n<p>Python 的设计具有很强的可读性，相比其他语言经常使用英文关键字，其他语言的一些标点符号，它具有比其他语言更有特色语法结构。</p>\n\n<ul>\n<Li>\n&emsp;<strong>Python 是一种解释型语言：</strong> 这意味着开发过程中没有了编译这个环节。类似于PHP和Perl语言。</li>\n\n<li>\n&emsp;<strong>Python 是交互式语言：</strong> 这意味着，您可以在一个Python提示符，直接互动执行写你的程序。\n</li>\n\n<li>\n&emsp;<strong>Python 是面向对象语言:</strong> 这意味着Python支持面向对象的风格或代码封装在对象的编程技术。\n</li>\n\n<li>\n&emsp;<strong>Python 是初学者的语言：</strong>Python 对初级程序员而言，是一种伟大的语言，它支持广泛的应用程序开发，从简单的文字处理到 WWW 浏览器再到游戏。\n</li>\n\n</ul>\n\n<hr>\n\n<h4>Python 发展历史</h4>\n\n<p>Python 是由 Guido van Rossum 在八十年代末和九十年代初，在荷兰国家数学和计算机科学研究所设计出来的。</p>\n\n<p>Python 本身也是由诸多其他语言发展而来的,这包括 ABC、Modula-3、C、C++、Algol-68、SmallTalk、Unix shell 和其他的脚本语言等等。</p>\n\n<p>像 Perl 语言一样，Python 源代码同样遵循 GPL(GNU General Public License)协议。</p>\n\n<p>现在 Python 是由一个核心开发团队在维护，Guido van Rossum 仍然占据着至关重要的作用，指导其进展。 \n<hr></p>\n\n<h4>Python 特点</h4>\n\n<p>&emsp;<strong>1.易于学习：</strong>Python有相对较少的关键字，结构简单，和一个明确定义的语法，学习起来更加简单。</p>\n\n<p>&emsp;<strong>2.易于阅读：</strong>Python代码定义的更清晰。</p>\n\n<p>&emsp;<strong>3.易于维护：</strong>Python的成功在于它的源代码是相当容易维护的。</p>\n\n<p>&emsp;<strong>4.一个广泛的标准库：</strong>Python的最大的优势之一是丰富的库，跨平台的，在UNIX，Windows和Macintosh兼容很好。</p>\n\n<p><br>\n<p>&emsp;<strong>5.互动模式：</strong>互动模式的支持，您可以从终端输入执行代码并获得结果的语言，互动的测试和调试代码片断。</p>\n<br>\n<p>&emsp;<strong>6.可移植：</strong>基于其开放源代码的特性，Python已经被移植（也就是使其工作）到许多平台。</p>\n<br>\n<p>&emsp;<strong>7.</strong>可扩展：如果你需要一段运行很快的关键代码，或者是想要编写一些不愿开放的算法，你可以使用C或C++完成那部分程序，然后从你的Python程序中调用。</p>\n<br>\n<p>&emsp;<strong>8.数据库：</strong>Python提供所有主要的商业数据库的接口。</p>\n<br>\n<p>&emsp;<strong>9.GUI编程：</strong>Python支持GUI可以创建和移植到许多系统调用。</p>\n<br>\n<p>&emsp;<strong>10.可嵌入:</strong> 你可以将Python嵌入到C/C++程序，让你的程序的用户获得\"脚本化\"的能力。</p></p>', '1', '187');
INSERT INTO `teach_blog_z_title` VALUES ('2', '安装python', '<h4>Python <font color=\"red\">环境搭建</font></h4>\n\n<p>本章节我们将向大家介绍如何在本地搭建<strong>Python</strong>开发环境。</p>\n\n<p><strong>Python</strong>可应用于多平台包括 <strong>Linux</strong> 和 <strong>Mac OS X</strong>。</p>\n\n<p>可以通过终端窗口输入 \"python\" 命令来查看本地是否已经安装<strong>Python</strong>以及<strong>Python</strong>的安装版本。</p>\n\n<ul>\n<li>\n<p>&emsp;Unix (Solaris, Linux, FreeBSD, AIX, HP/UX, SunOS, IRIX, 等等。)</p>\n</li>\n<li>\n<p>&emsp;Win 9x/NT/2000</p>\n</li>\n<li>\n<p>&emsp;Macintosh (Intel, PPC, 68K)</p>\n</li>\n<li>\n<p>&emsp;OS/2</p>\n</li>\n<li>\n<p>&emsp;DOS (多个DOS版本)</p>\n</li>\n<li>\n<p>&emsp;PalmOS</p>\n</li>\n<li>\n<p>&emsp;Nokia 移动手机</p>\n</li>\n<li>\n<p>&emsp;Windows CE</p>\n</li>\n<li>\n<p>&emsp;Acorn/RISC OS</p>\n</li>\n<li>\n<p>&emsp;BeOS</p>\n</li>\n<li>\n<p>&emsp;Amiga</p>\n</li>\n<li>\n<p>&emsp;VMS/OpenVMS</p>\n</li>\n<li>\n<p>&emsp;QNX</p>\n</li>\n<li>\n<p>&emsp;VxWorks</p>\n</li>\n<li>\n<p>&emsp;Psion</p>\n</li>\n<li>\n<p>&emsp;Python 同样可以移植到 Java 和 .NET 虚拟机上。\n<hr></p>\n</li>\n</ul>\n\n<h4>Python下载</h4>\n\n<p>Python最新源码，二进制文档，新闻资讯等可以在Python的官网查看到：</p>\n\n<p>Python官网：<a href=\"https://www.python.org/\">https://www.python.org/</a></p>\n\n<p>你可以在以下链接中下载 Python 的文档，你可以下载 HTML、PDF 和 PostScript 等格式的文档。</p>\n\n<p>Python文档下载地址：<a href=\"https://www.python.org/doc/\">https://www.python.org/doc/</a></p>\n\n<hr>\n\n<h4>Python安装</h4>\n\n<p>Python已经被移植在许多平台上（经过改动使它能够工作在不同平台上）。</p>\n\n<p>您需要下载适用于您使用平台的二进制代码，然后安装Python。</p>\n\n<p>如果您平台的二进制代码是不可用的，你需要使用C编译器手动编译源代码。</p>\n\n<p>编译的源代码，功能上有更多的选择性， 为python安装提供了更多的灵活性。</p>\n\n<p>以下是各个平台安装包的下载地址：\n<img src=\"http://www.runoob.com/wp-content/uploads/2013/11/DC24DD0C-08A2-4D61-8C6F-4CA1EEB23535.jpg\" width=800 height=250 /></p>\n\n<p>以下为不同平台上安装 Python 的方法：</p>\n\n<h4>Unix &amp; Linux 平台安装 Python:</h4>\n\n<p>以下为在 Unix &amp; Linux 平台上安装 Python 的简单步骤：</p>\n\n<p>打开 WEB 浏览器访问<a href=\"https://www.python.org/downloads/source/\">https://www.python.org/downloads/source/</a></p>\n\n<ul>\n<li>\n<p>&emsp;选择适用 于Unix/Linux 的源码压缩包。</p>\n</li>\n<li>\n<p>&emsp;下载及解压压缩包。</p>\n</li>\n<li>\n<p>&emsp;如果你需要自定义一些选项修改Modules/Setup</p>\n</li>\n<li>\n<p>&emsp;<strong>执行 </strong>./configure 脚本</p>\n</li>\n<li>\n<p>&emsp;make</p>\n</li>\n<li>\n<p>&emsp;make install</p>\n</li>\n</ul>\n\n<p>执行以上操作后，Python 会安装在 /usr/local/bin 目录中，Python 库安装在 /usr/local/lib/pythonXX，XX 为你使用的 Python 的版本号。</p>\n\n<p><hr>\n<h4>Window 平台安装 Python:</h4>\n* &emsp;以下为在 Window 平台上安装 Python 的简单步骤：</p>\n\n<ul>\n<li>\n<p>&emsp;打开 WEB 浏览器访问<a href=\"https://www.python.org/downloads/windows/\">https://www.python.org/downloads/windows/</a></p>\n</li>\n<li>\n<p>&emsp;在下载列表中选择Window平台安装包，包格式为：python-XYZ.msi 文件 ， XYZ 为你要安装的版本号。</p>\n</li>\n<li>\n<p>&emsp;要使用安装程序 <strong>python-XYZ.msi, Windows</strong> 系统必须支持 <strong>Microsoft Installer 2.0</strong> 搭配使用。只要保存安装文件到本地计算机，然后运行它，看看你的机器支持 <strong>MSI</strong>。<strong>Windows XP</strong> 和更高版本已经有 <strong>MSI</strong>，很多老机器也可以安装 <strong>MSI</strong>。</p>\n</li>\n<li>\n<p>&emsp;下载后，双击下载包，进入 <strong>Python</strong> 安装向导，安装非常简单，你只需要使用默认的设置一直点击\"下一步\"直到安装完成即可。</p>\n</li>\n</ul>\n\n<p><hr>\n<h4>MAC 平台安装 Python:</h4>\n<strong>MAC</strong> 系统一般都自带有 <strong>Python2.x</strong>版本 的环境，你也可以在链接 <a href=\"https://www.python.org/downloads/mac-osx/\">https://www.python.org/downloads/mac-osx/</a> 上下载最新版安装。</p>\n\n<hr>\n\n<h4>在 Unix/Linux 设置环境变量</h4>\n\n<p>&emsp;<strong>在 csh shell:</strong> 输入</p>\n\n<table ><tr><td bgcolor=\"#00000\"><font color=\"#FF5511\" face=\"DejaVu Sans Mono\">setenv PATH \"$PATH:/usr/local/bin/python\"</font></td></tr></table>\n\n<p>&emsp;&emsp;&emsp;, 按下\"Enter\"。\n<br>\n&emsp;<strong>在 bash shell (Linux):</strong> 输入</p>\n\n<table ><tr><td bgcolor=\"#00000\"><font color=\"#FF5511\" face=\"DejaVu Sans Mono\">export PATH=\"$PATH:/usr/local/bin/python\" </font></td></tr></table>\n\n<p>&emsp;&emsp;&emsp;，按下\"Enter\"。\n<br>\n&emsp;<strong>在 sh 或者 ksh shell</strong>: 输入 </p>\n\n<table ><tr><td bgcolor=\"#00000\"><font color=\"#FF5511\" face=\"DejaVu Sans Mono\">\nPATH=\"$PATH:/usr/local/bin/python\" </font></td></tr></table>\n\n<p>&emsp;&emsp;&emsp;, 按下\"Enter\"。\n<br>\n<strong>注意:</strong> /usr/local/bin/python 是 Python 的安装目录。</p>\n\n<h4>在 Windows 设置环境变量</h4>\n\n<p>在环境变量中添加Python目录：</p>\n\n<p><strong>在命令提示框中(cmd) :</strong> 输入 </p>\n\n<table ><tr><td bgcolor=\"#00000\"><font color=\"#FF5511\" face=\"DejaVu Sans Mono\">path=%path%;C:\\Python</font></td></tr></table>\n\n<p>按下\"Enter\"。</p>\n\n<p><strong>注意:</strong> C:\\Python 是Python的安装目录。</p>\n\n<p>也可以通过以下方式设置：\n<br>\n<br>\n&emsp;右键点击\"计算机\"，然后点击\"属性\"\n<br>\n<br>\n&emsp;然后点击\"高级系统设置\"\n<br>\n<br>\n&emsp;选择\"系统变量\"窗口下面的\"Path\",双击即可！\n<br>\n<br>\n&emsp;然后在\"Path\"行，添加python安装路径即可(我的D:\\Python32)，所以在后面，添加该路径即可。 <strong>ps：记住，路径直接用分号\"；\"隔开！</strong>\n<br>\n<br>\n&emsp;最后设置成功以后，在cmd命令行，输入命令\"python\"，就可以有相关显示。\n<br>\n<img src=\"http:////www.runoob.com/wp-content/uploads/2013/11/201209201707594792.png\" width=800 height=500 />\n<hr>\n<h4>Python 环境变量<h4>\n<br>\n<br>\n下面几个重要的环境变量，它应用于Python：\n<br>\n<br>\n<table border=0 margin=0 padding=0>\n<tr >\n<td bgcolor=\"grey\">变量名</td>\n<td bgcolor=\"grey\">描述</td>\n</tr>\n<tr >\n<td bgcolor=\"C0C0C0\">PYTHONPATH</td>\n<td bgcolor=\"C0C0C0\">PYTHONPATH是Python搜索路径，默认我们import的模块都会从PYTHONPATH里面寻找。</td>\n</tr>\n<tr >\n<td bgcolor=\"grey\">PYTHONSTARTUP</td>\n<td bgcolor=\"grey\">Python启动后，先寻找PYTHONSTARTUP环境变量，然后执行此变量指定的文件中的代码。</td>\n</tr>\n<tr >\n<td bgcolor=\"C0C0C0\">PYTHONCASEOK</td>\n<td bgcolor=\"C0C0C0\">加入PYTHONCASEOK的环境变量, 就会使python导入模块的时候不区分大小写.</td>\n</tr>\n<tr >\n<td bgcolor=\"grey\">PYTHONHOME   </td>\n<td bgcolor=\"grey\">另一种模块搜索路径。它通常内嵌于的PYTHONSTARTUP或PYTHONPATH目录中，使得两个模块库更容易切换。</td>\n</tr>\n</table></p>', '2', '29');
INSERT INTO `teach_blog_z_title` VALUES ('3', '第一个python程序', '<p>3</p>', '3', '3');
INSERT INTO `teach_blog_z_title` VALUES ('4', 'python基础', '<p>4</p>', '4', '1');
INSERT INTO `teach_blog_z_title` VALUES ('5', '函数', '5', '5', '0');
INSERT INTO `teach_blog_z_title` VALUES ('6', '高级特性', '<p>6</p>', '6', '0');
INSERT INTO `teach_blog_z_title` VALUES ('7', '函数式编程', '<p>7</p>', '7', '2');
INSERT INTO `teach_blog_z_title` VALUES ('8', '模块', '<p>8</p>', '8', '0');
INSERT INTO `teach_blog_z_title` VALUES ('9', '面向对象编程', '<p>9</p>', '9', '1');
INSERT INTO `teach_blog_z_title` VALUES ('10', '面向对象得高级编程', '10', '10', '0');
INSERT INTO `teach_blog_z_title` VALUES ('11', '错误、调试和测试', '<p>11</p>', '11', '0');
INSERT INTO `teach_blog_z_title` VALUES ('12', 'IO编程', '12', '12', '0');
INSERT INTO `teach_blog_z_title` VALUES ('13', '进程和线程', '<p>13</p>', '13', '1');
INSERT INTO `teach_blog_z_title` VALUES ('14', '正则表达式', '14', '14', '0');
INSERT INTO `teach_blog_z_title` VALUES ('15', '常用内建模块', '15', '15', '0');
INSERT INTO `teach_blog_z_title` VALUES ('16', '常用第三方模块', '<p>16</p>', '16', '2');
INSERT INTO `teach_blog_z_title` VALUES ('17', 'virtualenv', '<p>17</p>', '17', '1');
INSERT INTO `teach_blog_z_title` VALUES ('18', '图形界面', '18', '18', '0');
INSERT INTO `teach_blog_z_title` VALUES ('19', '网络编程', '<p>19</p>', '19', '3');
INSERT INTO `teach_blog_z_title` VALUES ('20', '电子邮件', '20', '20', '0');
INSERT INTO `teach_blog_z_title` VALUES ('21', '访问数据库', '<p>21</p>', '21', '1');
INSERT INTO `teach_blog_z_title` VALUES ('22', 'web开发', '22', '22', '0');
INSERT INTO `teach_blog_z_title` VALUES ('23', '异步IO', '<p>23</p>', '23', '7');

-- ----------------------------
-- Table structure for `user_usertwo`
-- ----------------------------
DROP TABLE IF EXISTS `user_usertwo`;
CREATE TABLE `user_usertwo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `email` varchar(254) NOT NULL,
  `sex` varchar(32) NOT NULL,
  `c_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_usertwo
-- ----------------------------
INSERT INTO `user_usertwo` VALUES ('3', 'bdd', 's19961224', '33985368ss@qq.com', 'male', '2018-12-08 19:43:57');
INSERT INTO `user_usertwo` VALUES ('4', 'sunli', 's19961224l', '3398536845@qq.com', 'man', '2018-12-18 03:11:28');
INSERT INTO `user_usertwo` VALUES ('5', 'kobe', 's19961224', '3333333333@qq.com', 'male', '2018-12-22 07:40:43');
