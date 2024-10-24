# Please install jcvi (the Python version of MCscan), we install the software at Conda environment

#!/bin/sh
source activate MCscan

python -m jcvi.formats.gff bed --type=mRNA --key=Name Oryza_sativa_japonica.gff3 --primary_only -o Oryza_sativa_japonica.bed
python -m jcvi.formats.gff bed --type=mRNA --key=ID Subject_species.gff3 --primary_only -o Subject_species.bed
python -m jcvi.compara.catalog ortholog Oryza_sativa_japonica Subject_species --cscore=.99 --no_strip_names
python -m jcvi.graphics.dotplot Oryza_sativa_japonica.Subject_species.anchors
python -m jcvi.compara.synteny screen --minspan=30 --simple Oryza_sativa_japonica.Subject_species.anchors Oryza_sativa_japonica.Subject_species.anchors.new  
python -m jcvi.compara.synteny mcscan Oryza_sativa_japonica.bed Oryza_sativa_japonica.Subject_species.lifted.anchors --iter=1 -o Oryza_sativa_japonica.Subject_species.i1.blocks
sed -n '/LOC_Os01g39570/,/LOC_Os01g39790/p' Oryza_sativa_japonica.Subject_species.i1.blocks > Oryza_sativa_japonica.Subject_species.blocks
cat Oryza_sativa_japonica.bed Subject_species.bed > Oryza_sativa_japonica.Subject_species.bed
vi Oryza_sativa_japonica.Subject_species.blocks.layout
python -m jcvi.graphics.synteny Oryza_sativa_japonica.Subject_species.blocks Oryza_sativa_japonica.Subject_species.bed Oryza_sativa_japonica.Subject_species.blocks.layout --glyphstyle=arrow --genelabelsize 6

