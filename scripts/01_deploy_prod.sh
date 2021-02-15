#mkdir src

#docker build
#docker run --rm -it -v `pwd`/src:/oscobol/src:ro --name oscobol 




m_month=`date +'%b'`
docker logs wordpress_cca_wordpress_1  >test  2>/dev/null ; cat test | grep "/${m_month}/"| grep '\- \-' | cut -d':' -f1> src/data.txt
echo "" >> src/data.txt
sed -i ':a;N;$!ba;s/\n/]\n/g ' src/data.txt
awk '{printf("%-'${LONGUEUR}'s\n", $0) }' src/data.txt > src/data2.txt
mv  src/data2.txt src/data.txt


echo " RUNNING COBOL"
docker build  . -t batch_cobol_run
docker run  --rm -v `pwd`/src:/oscobol/src:rw --name batch_cobol_run  --entrypoint /bin/bash batch_cobol_run  -c "cobc /oscobol/src/BATCH_1.cbl;cobcrun BATCH_1"
