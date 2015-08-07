
# First we reset the database to what it needs to be
rake db:reset

# rake db:fixtures:load
# rake fix_ids:fix_all

# Where before we were loading the fixtures, now
# we will insert the data directly into the database

# 
echo "Populating the database. Please be patient"
mysql -u rails --password=password rails_test < mysql_dumps/full_database.sql
#mysql -u rails --password=password rails_test < mysql_dumps/annoying_backup_av_pr.sql

# Then we load any fixtures that we need
# 
# Then we can perform any rake tasks that we want
echo "Enumerating user saved flights"
rake populate_db:enumerate_saved_flights