FROM centos:latest
MAINTAINER Henrik Feldt <henrik@haf.se>

COPY install-haf-packagecloud.sh /install-haf-packagecloud.sh
RUN /install-haf-packagecloud.sh

RUN yum update -y && yum install -y epel-release
RUN yum install -y mono fsharp ruby make tar patch gcc gcc-c++ openssl-devel readline-devel libxml2 libxml2-devel libxslt libxslt-devel ruby-devel zlib-devel
RUN gem install nokogiri albacore bundler

RUN mozroots --import --sync --machine && \
    (yes | certmgr -ssl -m https://nuget.org) && \
    (yes | certmgr -ssl -m https://packages.nuget.org/v1/FeedService.svc/) && \
    (yes | certmgr -ssl -m https://go.microsoft.com) && \
    (yes | certmgr -ssl -m https://nugetgallery.blob.core.windows.net)


RUN groupadd -r app && \
    useradd -d /app -r -g app app && \
    mkdir -p /.paket

#ADD https://github.com/fsprojects/Paket/releases/download/2.40.2/paket.exe /app/.paket/paket.exe
ADD https://github.com/fsprojects/Paket/releases/download/2.40.2/paket.bootstrapper.exe /app/.paket/paket.bootstrapper.exe

COPY . ./app

RUN chown -R app:app /app
RUN chmod u+x /app/.paket/paket.bootstrapper.exe
#RUN /app/.paket/paket.bootstrapper.exe


WORKDIR /app

#RUN /.paket/paket.bootstrapper.exe
#RUN bundle exec rake 

EXPOSE 8080

#ENTRYPOINT ["mono", "AngularSuave/bin/Debug/AngularSuave.exe"]

