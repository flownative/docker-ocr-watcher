FROM registry.gitlab.com/flownative/docker/base:1
MAINTAINER Robert Lemke <robert@flownative.com>

# tesseract-ocr: see https://github.com/tesseract-ocr/tesserac
# ocrmypdf: see https://github.com/jbarlow83/OCRmyPDF

RUN add-apt-repository -y ppa:alex-p/tesseract-ocr \
    && apt-get update \
    && apt-get install -y \
        software-properties-common \
        ocrmypdf \
        tesseract-ocr \
        tesseract-ocr-deu \
        tesseract-ocr-eng \
        inotify-tools \
    && apt-get purge --yes --auto-remove

COPY watch.sh /etc/my_init.d/10_watch.sh

CMD ["/sbin/my_init"]
