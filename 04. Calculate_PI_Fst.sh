# PI
vcftools --gzvcf merge.gvcf.gz --keep indica.txt --window-pi 20000 --window-pi-step 5000 --out indica.chr01.20k.5k
vcftools --gzvcf merge.gvcf.gz --keep japonica.txt --window-pi 20000 --window-pi-step 5000 --out japonica.chr01.20k.5k
vcftools --gzvcf merge.gvcf.gz --keep SouthAsia_indica.txt --window-pi 20000 --window-pi-step 5000 --out SouthAsia_indica.chr01.20k.5k

#Fst
vcftools --gzvcf merge.gvcf.gz --weir-fst-pop SouthAsia_indica.txt --weir-fst-pop Orufipogon.txt --fst-window-size 20000 --fst-window-step 5000 --out SouthAsia_indica.Orufipogon.chr01.20k.5k
vcftools --gzvcf merge.gvcf.gz --weir-fst-pop japonica.txt --weir-fst-pop Orufipogon.txt --fst-window-size 20000 --fst-window-step 5000 --out japonica.Orufipogon.chr01.20k.5k
vcftools --gzvcf merge.gvcf.gz --weir-fst-pop indica.txt --weir-fst-pop Orufipogon.txt --fst-window-size 20000 --fst-window-step 5000 --out indica.Orufipogon.chr01.20k.5k
