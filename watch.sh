#!/bin/bash

mkdir -p /tmp/ocr

echo "Starting OCR watcher ...x"

while true
do
    (ls /data/input | grep '.pdf$' | grep -v '^--') | \
        while read -r filename; do
            pathAndFilename="/data/input/${filename}"

            echo "Starting ocr for ${pathAndFilename}"

            filenamePrefix=$(echo "${filename}" | grep -oE '[^._-]+' | head -1)

            ocrmypdf -l deu+eng --sidecar "/tmp/ocr/${filename}.txt" "${pathAndFilename}" "/tmp/ocr/${filename}.pdf"

            if [[ -f "/tmp/ocr/${filename}.txt" ]]; then
                documentNumber=$(head -n 1 "/tmp/ocr/${filename}.txt" | grep -E '^\s*[0-9]{7}\s*$')
                if [[ -z "${documentNumber}" ]]; then
                    targetFilename=${filename}
                else
                    targetFilename=${filenamePrefix}-${documentNumber}.pdf
                fi

                chmod 666 "/tmp/ocr/${filename}.pdf"
                mv -f "/tmp/ocr/${filename}.pdf" "/data/output/${targetFilename}"
                rm "${pathAndFilename}"
                rm "/tmp/ocr/${filename}.txt"

                echo "Finished ocr, result is ${targetFilename}"
            else
                echo "Text recognition failed, copying file without OCR to ${targetFilename}"
                mv -f "${pathAndFilename}" "/data/output/${targetFilename}"
            fi
        done
    sleep 5
    echo -ne "."
done

echo "OCR watcher exited."
