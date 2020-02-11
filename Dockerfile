FROM flownative/base:2
MAINTAINER Robert Lemke <robert@flownative.com>

# tesseract-ocr: see https://github.com/tesseract-ocr/tesseract
#                and https://tesseract-ocr.github.io/tessdoc/Home.html
# ocrmypdf:      see https://github.com/jbarlow83/OCRmyPDF

RUN install_packages \
    software-properties-common \
    ocrmypdf \
    tesseract-ocr \
    tesseract-ocr-deu \
    tesseract-ocr-eng \
    inotify-tools

COPY watch.sh /watch.sh

CMD ["/watch.sh"]
