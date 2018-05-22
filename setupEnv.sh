#!/bin/sh

#python install
sudo apt-get install -y build-essential checkinstall git cmake python3-pip
sudo apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
sudo pip3 install virtualenv

#Download V-REP
wget http://coppeliarobotics.com/files/V-REP_PRO_EDU_V3_5_0_Linux.tar.gz
tar -xvzf V-REP_PRO_EDU_V3_5_0_Linux.tar.gz
rm V-REP_PRO_EDU_V3_5_0_Linux.tar.gz

# move vrep files for python binding
cp -f ./V-REP_PRO_EDU_V3_5_0_Linux/programming/remoteApiBindings/python/python/vrep.py ./
cp -f ./V-REP_PRO_EDU_V3_5_0_Linux/programming/remoteApiBindings/python/python/vrepConst.py ./
cp -f ./V-REP_PRO_EDU_V3_5_0_Linux/programming/remoteApiBindings/lib/lib/Linux/64Bit/remoteApi.so ./


#crete and activate the virtual environment
virtualenv --python=python3.5 venv
source venv/bin/activate

pip install -r requirements.txt

mkdir -p build
cd build

#pybrain install
git clone git://github.com/pybrain/pybrain.git
cd pybrain
python setup.py install
cd ..

#install boost
wget https://dl.bintray.com/boostorg/release/1.66.0/source/boost_1_66_0.tar.gz
tar -xvzf boost_1_66_0.tar.gz boost
rm boost_1_66_0.tar.gz
cd boost_1_66_0
./bootstrap.sh --prefix=/usr
sudo ./b2 install

cd ..

./setupCarl.sh
./setupStormpy.sh
