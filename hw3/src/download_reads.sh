#!/bin/bash
#Atsisiunčia FASTQ failus pagal SRR numerius iš accessions.txt
#Paleidimas (iš ~/BST/hw3): bash src/download_reads.sh accessions.txt

set -euo pipefail
ACC_FILE=${1:-accessions.txt}
if [[ ! -f "$ACC_FILE" ]]; then
    echo "Failas $ACC_FILE neegzistuoja"
    echo "Naudojimas: bash src/download_reads.sh accessions.txt"
    exit 1
fi

mkdir -p data/raw data/sra

while read ACC; do
    [[ -z "$ACC" ]] && continue

    if [[ -f "data/raw/${ACC}_1.fastq.gz" && -f "data/raw/${ACC}_2.fastq.gz" ]]; then
            echo "$ACC jau atsiųstas"
            continue
    fi

    echo "Atsiunčiami $ACC failai"
    prefetch "$ACC" -O data/sra
    fasterq-dump --split-files -O data/raw "data/sra/$ACC/$ACC.sra"
    gzip data/raw/${ACC}_*.fastq
    rm-rf "data/sra/$ACC.sra"

done < "$ACC_FILE"