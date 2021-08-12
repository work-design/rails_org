# RailsOrg

组织架构管理

## 概述

* 用于 `SaaS` 多租户
* 非常经典的OA部门管理模型设计；

## 命名空间规则
平台级：不支持 organ_id 字段
* panel: 后端，平台级功能
* board: 前端，平台级功能，支持 user_id，不包含 organ_id

组织型功能：organ_id 字段；
* admin: 后端，支持 organ，也可不采用 organ_id 字段
  - 必须
* me: 前端，与 current_member 相关的功能
  - 信息

商店型：支持 organ_id 字段；
* my: 用户端，支持 user_id + organ_id


## 许可证
遵循 [MIT](https://opensource.org/licenses/MIT) 协议
