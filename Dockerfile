FROM centos:centos7
MAINTAINER you<info@ez-design.net>

RUN yum -y install git libunwind libicu freetype-devel jpeglib-devel giflib-devel libjpeg-turbo-devel mysql && \
    yum -y groupinstall "Development Tools" && \
    curl -sSL -o dotnet.tar.gz https://go.microsoft.com/fwlink/?LinkID=836297 && \
    mkdir -p /opt/dotnet &&  \
    tar zxf dotnet.tar.gz -C /opt/dotnet && \
    ln -s /opt/dotnet/dotnet /usr/local/bin && \
    mkdir /work/ && \
    mkdir /ffmpeg/ && \
    cd /work/ && \
    curl -sSL -o /work/ffmpeg-git-64bit-static.tar.xz https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-64bit-static.tar.xz && \
    tar Jxfv /work/ffmpeg-git-64bit-static.tar.xz -C /ffmpeg/ --strip-components 1 && \
    ln -s /ffmpeg/ffmpeg /usr/local/bin && \
    curl -o /work/swftools-2013-04-09-1007.tar.gz http://www.swftools.org/swftools-2013-04-09-1007.tar.gz && \
    tar -zvxf /work/swftools-2013-04-09-1007.tar.gz && \
    cd /work/swftools-2013-04-09-1007 && \
    curl -o lib/pdf/xpdf-3.04.tar.gz ftp://ftp.foolabs.com/pub/xpdf/xpdf-3.04.tar.gz && \
    ./configure --libdir=/usr/lib64 --bindir=/usr/bin && \
    make && \
    make install && \
    mkdir /RTFreeWeb/wwwroot/records
COPY docker-entrypoint.sh /
RUN chmod 766 /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 5000
CMD ["dotnet", "/RTFreeWeb/RTFreeWeb.dll"]
