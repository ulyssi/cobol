
rm src/*.txt
rm src/.htpasswd

echo "============================== GENERATION DE LA DONNEE======================"
m_month=`date +'%b'`
docker logs wordpress_cca_wordpress_1  >test  2>/dev/null ; cat test | grep "/${m_month}/"| grep '\- \-' | cut -d':' -f1> src/data.txt
echo "" >> src/data.txt
sed -i ':a;N;$!ba;s/\n/]\n/g ' src/data.txt
LONGUEUR=50 
awk '{printf("%-'${LONGUEUR}'s\n", $0) }' src/data.txt > src/data2.txt
mv  src/data2.txt src/data.txt

echo "===============================TRAITEMENT ET MISE EN FORME==================="
echo " RUNNING COBOL"
docker build  . -t batch_cobol_run
docker run  --rm -v `pwd`/src:/oscobol/src:rw --name batch_cobol_run  --entrypoint /bin/bash batch_cobol_run  -c "cobc /oscobol/src/BATCH_2.cbl;cobcrun BATCH_2"

echo "===============================EXPOSE DATA==================="


# rm expose/.htpasswd
# mkdir expose

# cp -rv src expose

# docker stop  nginx_expose_data
# docker rm nginx_expose_data


# docker run --name nginx_expose_data -p 8585:80  -v  `pwd`/expose:/usr/share/nginx/html -d nginx
# docker exec  nginx_expose_data bash -c 'sed  -i "s/index  index.html index.htm;/autoindex on;/g" /etc/nginx/conf.d/default.conf '
# docker exec  nginx_expose_data bash -c 'nginx -s reload '

# ##Protection des données.

# echo "tom:{SHA}loNd2L+nGL1kR8zIevia4Wddrso=" >  expose/.htpasswd
# docker exec  nginx_expose_data bash -c 'sed  -i "s/autoindex on;/autoindex on;auth_basic   \"closed site\";auth_basic_user_file \/usr\/share\/nginx\/html\/.htpasswd;/g" /etc/nginx/conf.d/default.conf '
# docker exec  nginx_expose_data bash -c 'sed  -i "s/location \/ {/location \/src {/g" /etc/nginx/conf.d/default.conf '
# docker exec  nginx_expose_data bash -c 'nginx -s reload '