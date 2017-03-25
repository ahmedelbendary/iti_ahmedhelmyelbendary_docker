
echo "##################################"
echo "name  : Ahmed helmy elbendary"
echo "track : SA"
echo "##################################"

x=`pwd`
cd mysql/
docker build -t pro_mysql .

cd $x
cd downloader/
docker build -t pro_downloader .

cd $x
cd phpfpm/
docker build -t pro_php-fpm .

cd $x
cd nginx/
docker build -t pro_nginx . 

docker run -d --name mysql pro_mysql 
docker run -i -t --name downloader pro_downloader
docker run -d --name app1 --volumes-from downloader --link mysql:db pro_php-fpm
docker run -d --name app2 --volumes-from downloader --link mysql:db pro_php-fpm
docker run -d -p 90:80 --name nginx --volumes-from downloader --link app1:app1 --link app2:app2 pro_nginx
