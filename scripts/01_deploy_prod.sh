#mkdir src

#docker build
#docker run --rm -it -v `pwd`/src:/oscobol/src:ro --name oscobol 
docker build  . -t batch_cobol_run
docker run  --rm -v `pwd`/src:/oscobol/src:ro --name batch_cobol_run  --entrypoint /bin/bash batch_cobol_run  -c "cobc /oscobol/src/batch.cbl;cobcrun batch_1"