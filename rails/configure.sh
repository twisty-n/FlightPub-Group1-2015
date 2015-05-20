
# First we reset the database to what it needs to be
rake db:reset

# rake db:fixtures:load
# rake fix_ids:fix_all

# Where before we were loading the fixtures, now
# we will insert the data directly into the database

# 
mysql -u rails -p password rails_test < mysql_dumps/full_database.sql

# Then we load any fixtures that we need