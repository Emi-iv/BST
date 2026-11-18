#!/bin/bash
#Atsisiunčia žmogaus GRCh38 genomą, anotaciją ir tranksriptomą iš GENCODE
#Paleidimas (iš ~/BST/hw3):  bash src/prepare_reference.sh

set -euo pipefail

VERSION=50
URL=https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_${VERSION}
REF=reference

GENOME=$REF/GRCh38.primary_assembly.genome.fa
GTF=$REF/gencode.v${VERSION}.primary_assembly.annotation.gtf
TRANSCRIPTS=$REF/gencode.v${VERSION}.transcripts.fa

mkdir -p "$REF"

if [[ ! -f "$GENOME" ]]; then
    echo "Atsiunčiamas GRCh38.genome.fa"
    wget -O "$GENOME.gz" "$URL/GRCh38.primary_assembly.genome.fa.gz"
    gunzip "$GENOME.gz"
else
    echo "GRCh38.genome.fa jau atsiųstas"
fi


if [[ ! -f "$GTF" ]]; then
    echo "Atsiunčiamas gencode.v${VERSION}.primary_assembly.annotation.gtf"
    wget -O "$GTF.gz" "$URL/gencode.v${VERSION}.primary_assembly.annotation.gtf.gz"
    gunzip "$GTF.gz"
else
    echo "gencode.v${VERSION}.primary_assembly.annotation.gtf jau atsiųstas"
fi


if [[ ! -f "$TRANSCRIPTS" ]]; then
    echo "Atsiunčiamas gencode.v${VERSION}.transcripts.fa"
    wget -O "$TRANSCRIPTS.gz" "$URL/gencode.v${VERSION}.transcripts.fa.gz"
    gunzip "$TRANSCRIPTS.gz"
else
    echo "gencode.v${VERSION}.transcripts.fa jau atsiųstas"
fi

ls -lh "$REF"