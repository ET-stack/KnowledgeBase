# MySQL优化手段

## 数据库设计层面

- **范式设计**
  - 减少数据冗余
  - 提高数据一致性
- **索引策略**
  - 选择合适的索引类型 (`BTREE`, `HASH`)
  - 覆盖索引
  - 索引选择性
- **表结构优化**
  - 使用合适的数据类型
  - 避免使用NULL
- **分区表**
  - 水平分区
  - 垂直分区

## SQL查询优化

- **EXPLAIN分析**
  - 识别慢查询
- **避免全表扫描**
  - 使用索引
  - 优化WHERE子句
- **JOIN优化**
  - 减少JOIN表的数量
  - 使用正确的JOIN类型
- **减少子查询**
  - 使用JOIN代替复杂的子查询
- **LIMIT优化**
  - 配合ORDER BY和索引使用

## 系统配置优化

- **my.cnf调整**
  - `innodb_buffer_pool_size`
  - `query_cache_size`
  - `thread_cache_size`
- **日志配置**
  - binlog优化
  - slow_query_log启用
- **InnoDB设置**
  - 事务隔离级别
  - 锁机制优化

## 硬件与架构优化

- **硬件升级**
  - 更快的磁盘（SSD）
  - 内存扩展
- **读写分离**
  - 主从复制
  - 分布式数据库
- **缓存策略**
  - 使用Redis/Memcached缓存热点数据
- **负载均衡**
  - 使用Proxy实现读写分离及负载均衡

## 监控与维护

- **定期分析**
  - 使用`ANALYZE TABLE`
  - 定期检查慢查询日志
- **性能监控**
  - 使用`Performance Schema`
  - 第三方工具（如Prometheus+Grafana）
- **定期备份与恢复策略**
  - 定时备份
  - 灾难恢复计划
