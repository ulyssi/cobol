mkdir src
wget -O src/HELLO.cbl https://raw.githubusercontent.com/opensourcecobol/oc-dockerfile/master/HELLO.cbl
docker pull opensourcecobol/opensource-cobol
docker run --rm -it -v `pwd`/src:/oscobol/src:ro --name oscobol opensourcecobol/opensource-cobol