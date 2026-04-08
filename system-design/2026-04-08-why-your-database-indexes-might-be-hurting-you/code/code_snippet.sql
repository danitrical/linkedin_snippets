SELECT 
  schemaname, 
  relname, 
  indexrelname, 
  idx_scan, 
  pg_relation_size(indexrelid) AS index_size
FROM pg_stat_user_indexes
WHERE idx_scan = 0
ORDER BY pg_relation_size(indexrelid) DESC;