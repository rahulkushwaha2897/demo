sudo chmod -Rf 777 .
php bin/console cache:clear
sudo chmod -Rf 777 .
sudo rm -rf var/sessions/*
php bin/console assets:install --symlink --relative
sudo chown -R www-data:www-data .
sudo chmod -Rf 777 .
php bin/console pimcore:cache:clear
