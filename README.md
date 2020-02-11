![Nightly Builds](https://github.com/flownative/docker-ocr-watcher/workflows/Nightly%20Builds/badge.svg)
![Release to Docker Registries](https://github.com/flownative/docker-ocr-watcher/workflows/Release%20to%20Docker%20Registries/badge.svg)

# OCR Watcher

A Docker image providing automatic OCR for PDF files.

## Example

Consider the following `docker-compose.yaml`. When the service is running,
simply put a PDF file into the "input" directory and wait until it comes
out in "output".

```yaml
version: '3.3'

services:

  ocr-watcher:
    image: flownative/ocr-watcher:dev
    container_name: ocr_watcher
    volumes:
      - ./data/input:/data/input
      - ./data/output:/data/output
    restart: always
```
