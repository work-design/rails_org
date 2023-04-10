# RailsOrg

[![测试](https://github.com/work-design/rails_org/actions/workflows/test.yml/badge.svg)](https://github.com/work-design/rails_org/actions/workflows/test.yml)
[![Docker构建](https://github.com/work-design/rails_org/actions/workflows/cd.yml/badge.svg)](https://github.com/work-design/rails_org/actions/workflows/cd.yml)
[![Gem](https://github.com/work-design/rails_org/actions/workflows/gempush.yml/badge.svg)](https://github.com/work-design/rails_org/actions/workflows/gempush.yml)

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
* in: 在上下游中，物资流入。如：购入、租入
* out: 在上下有中，物资流出。如：售出、租出
* me: 前端，与 current_member 相关的功能
  - 信息

商店型：支持 organ_id 字段；
* my: B2C 场景，User 作为消费者，user_id + organ_id；
* mem: B2B 场景，Member（属于 member_organ）作为消费者；
* our: B2B 场景，Organ 做为消费者；

## 使用
`org/board/organs` 我的企业列表

## 许可证
遵循 [MIT](LICENSE) 协议
