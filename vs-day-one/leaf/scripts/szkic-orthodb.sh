# podbaza "gene_xrefs" dla arabidopsis, żeby szybciej wydobywać ortologi
zgrep -E '^3702_' odb12v2_gene_xrefs.tab.gz > 3702_odb12v2_gene_xrefs.tab

# to samo dla kukurydzy
zgrep -E '^4577_' odb12v2_gene_xrefs.tab.gz > 4577_odb12v2_gene_xrefs.tab

# podbaza "OG2genes" dla arabidopsis, żeby szybciej wydobywać ortologi
zcat odb12v2_OG2genes.tab.gz | awk -F'\t' -v OFS='\t' '$2~"^3702_"' > 3702_odb12v2_OG2genes.tab

# to samo dla kukurydzy
zcat odb12v2_OG2genes.tab.gz | awk -F'\t' -v OFS='\t' '$2~"^4577_"' > 4577_odb12v2_OG2genes.tab

# wyszukanie wg UP arabidopsis
grep -w Q9C9W9 3702_odb12v2_gene_xrefs.tab > x1
# i do wyciecia 1. kolumna ("Ortho DB gene id")

# wyszukanie wg "Ortho DB gene id"
grep -w 3702_0:00044a 3702_odb12v2_OG2genes.tab > x2
# i do wyciecia 1. kolumna ("OG unique id")
cut -f1 x2 > x21

# wybór z odb12v2_OG2genes.tab.gz genów ("Ortho DB gene id") kukurydzy
grep -w 255172at3193 4577_odb12v2_OG2genes.tab > xy2


# wydobycie UP wg "Ortho DB gene id" dla kukurydzy
grep -w 4577_0:00161f 4577_odb12v2_gene_xrefs.tab > x3
# powinno dać listę genów ("Ortho DB gene id") dla kukurydzy

# Najłatwiej skleić wszystko razem
sort -k1,1 -t $'\t' 3702_odb12v2_gene_xrefs.tab > 3702xref
sort -k2,2 -t $'\t' 3702_odb12v2_OG2genes.tab > 3702genes
join -1 1 -2 2 -t $'\t' 3702xref 3702genes | sort -k4,4 -t $'\t' > x
join -1 4 -2 1 -t $'\t' x 4577_odb12v2_OG2genes.tab > x2
sort -k5,5 -t $'\t' x2 > x3
sort -k1,1 -t $'\t' 4577_odb12v2_gene_xrefs.tab > x4
join -1 5 -2 1 x3 x4 -t $'\t' > all4files_joined

# polecenie do wydobywania
#grep -w Q9C9W9 all4files_joined | awk -F'\t' -v OFS='\t' '$7~"UniProt"{print $4,$6}' | sort -u 

# IDs białek At z adnotacją "rhythmic process" w UniProt
# /media/mj/ANTIX-LIVE/project1-stat/input-data/at-ortho_rhythmic-process/at_UP

# wydobycie z bazy
grep -wf /media/mj/ANTIX-LIVE/project1-stat/input-data/at-ortho_rhythmic-process/at_UP all4files_joined | awk -F'\t' -v OFS='\t' '$7~"UniProt"{print $4,$6}' | sort -u > all4files_joined_othoUP

# add At description
join -j 1 -t $'\t' all4files_joined_othoUP /media/mj/ANTIX-LIVE/project1-stat/input-data/at-ortho_rhythmic-process/at_UP_descr > all4files_joined_othoUP_descr

# copy to source At orthologue directory
cp -a all4files_joined_othoUP_descr /media/mj/ANTIX-LIVE/project1-stat/input-data/at-ortho_rhythmic-process/

# check differences between mapping with UniProt and OrthoDB
## at_UP-zm_UP file from "UniProt method"
awk -F'\t' -v OFS='\t' '{print $7,$2}' /media/mj/ANTIX-LIVE/project1-stat/input-data/at-ortho_rhythmic-process/mart-all-gramene_up-zea | sort -u > /media/mj/ANTIX-LIVE/project1-stat/input-data/at-ortho_rhythmic-process/UP_at_zm

# many differences
diff /media/mj/ANTIX-LIVE/project1-stat/input-data/at-ortho_rhythmic-process/UP_at_zm all4files_joined_othoUP | less

# Next step -> copy 12-NAMzUP-leaf-rhythm-ortho-At.qmd to new file and check networks
