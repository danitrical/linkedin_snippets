# Why Your Database Indexes Might Be Hurting You

Most engineers add indexes to speed things up. Few ever audit whether those indexes are actually being used.

Here's what I've seen in production PostgreSQL systems:

1. Duplicate indexes silently eating write performance
2. Partial indexes ignored because the query planner chose a seq scan anyway
3. Composite indexes with columns in the wrong order, making them useless for 90% of queries

Run this today:

```sql
SELECT schemaname, relname, indexrelname, idx_scan
FROM pg_stat_user_indexes
WHERE idx_scan = 0
ORDER BY pg_relation_size(indexrelid) DESC;
```

That query shows you every index that has never been used since the last stats reset, sorted by size. I've seen teams reclaim 30%+ storage and noticeably improve write throughput just by dropping dead indexes.

The best engineers don't just add indexes. They treat them like code: review them, measure them, and delete them when they stop earning their keep.

What's the worst "performance optimization" you've found that was actually making things slower?

`#postgresql` `#systemdesign` `#backend` `#softwareengineering`