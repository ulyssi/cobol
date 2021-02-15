#mkdir src

#docker build
#docker run --rm -it -v `pwd`/src:/oscobol/src:ro --name oscobol 
docker build  . -t batch_cobol_run
docker run  --rm -v `pwd`/src:/oscobol/src:ro --name batch_cobol_run  --entrypoint /bin/bash batch_cobol_run  -c "cobc /oscobol/src/BATCH_1.cbl;cobcrun BATCH_1"
cat /src/transaction.txt