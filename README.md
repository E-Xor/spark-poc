# spark-poc

Play with Spark

## 1st Setup

```
docker pull ubuntu
docker run -it ubuntu bash

apt-get update
apt-get install curl nano -y
\curl -sSL https://get.rvm.io | bash
nano /etc/group # add 0 at the end to rvm group, i.e. `rvm:x:1000:0`
exit

docker commit -m "Installed RVM" 3f4be79e8509 spark
docker images
docker tag 5d570b8f71f8 spark:latest
docker images # just to check
docker run -it spark:latest bash

source /etc/profile.d/rvm.sh
nano ~/.profile
# add: source /etc/profile.d/rvm.sh
rvm list known
rvm install ruby-2.4.0
gem install bundler --no-ri --no-rdoc
exit

docker commit -m "Installed Ruby" 38e5af10d8ba spark:latest
docker images # just to check

vi ~/.profile
# add: alias spark-run='docker run -it -v ~/other-apps/spark-poc/:/root/mounts/spark-poc -p 80:80 --add-host=main_host:$(ipconfig getifaddr en0) --dns=8.8.8.8 spark:latest bash'
source ~/.profile 

spark-run
ls -al ~/mounts/spark-poc/

<INSTALL JAVA>, spark-ruby needs JAVA_HOME at least
apt-cache search java | grep jre
apt-get install default-jre default-jdk
java -version
java -version
# openjdk version "1.8.0_111"
# OpenJDK Runtime Environment (build 1.8.0_111-8u111-b14-2ubuntu0.16.04.2-b14)
# OpenJDK 64-Bit Server VM (build 25.111-b14, mixed mode)
update-alternatives --config java
# There is only one alternative in link group java (providing /usr/bin/java): /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
nano ~/.profile
# add:
# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# export PATH=$PATH:$JAVA_HOME/bin
source ~/.profile

cd ~/mounts/spark-poc/
gem install bundler --no-ri --no-rdoc
bundle install

<!-- # probably not necessary
apt-get install scala # 2.11.6
apt-get install wget
cd ~
wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz
tar xvf spark-2.1.0-bin-hadoop2.7.tgz
# add to ~/.bashrc
  export PATH=$PATH:/root/spark-2.1.0-bin-hadoop2.7/bin
  export SPARK_HOME=/root/spark-2.1.0-bin-hadoop2.7
source ~/.bashrc -->

rm /usr/local/rvm/gems/ruby-2.4.0@spark-poc/gems/ruby-spark-1.2.1/ext/spark/sbt/sbt-launch-0.13.9.jar
ruby-spark build

http://www.rubydoc.info/github/ondra-m/ruby-spark/Spark/Mllib


# NaiveBayes, renew/non-renew predictions, start with weather example below
https://spark.apache.org/docs/latest/ml-classification-regression.html
https://github.com/apache/spark/blob/master/data/mllib/sample_libsvm_data.txt # often used in examples
http://www.rubydoc.info/github/ondra-m/ruby-spark/Spark/Mllib/NaiveBayes 
http://shatterline.com/blog/2013/09/12/not-so-naive-classification-with-the-naive-bayes-classifier/

# Spark NLP

```