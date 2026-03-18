wget https://github.com/bol-van/zapret/releases/download/v72.12/zapret-v72.12.tar.gz
tar -xvf zapret-v72.12.tar.gz
cd zapret-v72.12/
rm config 
rm config.default
cp ../../config/zapret/config .
cd ..
rm zapret-v72.12.tar.gz
rm -rf zapret-v72.12