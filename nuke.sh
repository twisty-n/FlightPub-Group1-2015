git filter-branch --prune-empty -d /dev/shm/scratch \
  --index-filter "git rm --cached -f --ignore-unmatch rails/mysql_dumps/ticket_availabilities.sql" \
  --tag-name-filter cat -- --all
