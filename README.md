# RailsOrg

## 概述

* 用于 `SaaS` 多租户
* 非常经典的OA部门管理模型设计；

## 命名空间规则
平台级：不支持 organ_id 字段
* panel: 后端
* board: 前端

组织型：支持 organ_id 字段；
* admin: 后端，可不采用 organ_id 字段
* our: 后端，支持 current_organ, current_organ 不可为空。
* my: 前端，支持 current_member/current_organ


## License
License 采用 [LGPL-3.0](https://opensource.org/licenses/LGPL-3.0).
