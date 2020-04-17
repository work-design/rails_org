# RailsOrg

## 概述

* 用于 `SaaS` 多租户
* 非常经典的OA部门管理模型设计；

## 命名空间规则
* panel: 平台级功能，不支持 organ_id 字段
* admin: 组织型功能，支持 organ_id 字段，且 organ_id 可以 nil
* our: 组织型功能，支持 current_organ, current_organ 不可为空。


## License
License 采用 [LGPL-3.0](https://opensource.org/licenses/LGPL-3.0).
