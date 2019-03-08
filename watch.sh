#!/bin/bash

mkdir -p /tmp/ocr

echo "Starting OCR watcher ..."

while true
do
    (find /data/input -regex '.*\/[^-]*\.pdf') | \
        while read pathAndFilename; do
            fileExtension="${pathAndFilename##*.}"

            if [[ "$fileExtension" == "pdf" ]]; then
                echo "Starting ocr for ${pathAndFilename}"

                filename=$(basename ${pathAndFilename})
                filenamePrefix=$(echo ${filename} | grep -oE [^._-]+ | head -1)

                ocrmypdf -l deu+eng --sidecar /tmp/ocr/${filename}.txt ${pathAndFilename} /tmp/ocr/${filename}.pdf

                documentNumber=$(head -n 1 /tmp/ocr/${filename}.txt | grep -E ^\s*[0-9]{7}\s*$)
                if [[ -z "${documentNumber}" ]]; then
                    targetFilename=${filename}
                else
                    targetFilename=${filenamePrefix}-${documentNumber}.pdf
                fi

                mv -f /tmp/ocr/${filename}.pdf /data/output/${targetFilename}
                mv ${pathAndFilename} /data/input/--${filename}
                rm /tmp/ocr/${filename}.txt

                echo "Finished ocr, result is ${targetFilename}"
            else
                echo "Ignoring ${pathAndFilename}: not a PDF file"
            fi
        done
    sleep 5
    echo -ne "."
done

echo "OCR watcher exited."
