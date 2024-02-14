FROM bitnami/minideb:bookworm
MAINTAINER Robert Lemke <robert@flownative.com>

ARG BUILD_DATE

LABEL org.label-schema.name="OCR Watcher"
LABEL org.label-schema.description="Automatic OCR for PDF files"
LABEL org.label-schema.vendor="Flownative GmbH"
LABEL com.flownative.base-image-build-date=$BUILD_DATE

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

USER 1000
CMD ["/watch.sh"]
