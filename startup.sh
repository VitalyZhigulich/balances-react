until nc -z -v -w30 $DB_HOST $DB_PORT; do
 sleep 1
done

bundle exec rails db:prepare

bundle exec rails s -p 3000 -b '0.0.0.0'
