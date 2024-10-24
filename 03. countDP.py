import pandas as pd
with open('Sa.DP','r') as file:
	lines=file.readlines()
df=pd.read_csv('Sa.DP',sep='\t')
sample_name=[]
for line in lines:
	if 'CHROM' in line:
		for sample in line.strip().split('\t')[2:]:
			sample_name.append(sample)
for sample in sample_name:
	f_subset=df[(df['POS'] >= 22375575)& (df['POS'] <= 22377307) ]
	m_subset=df[(df['POS'] >= 22379059)& (df['POS'] <= 22382876) ]
	mm_subset=df[(df['POS'] >= 22381676)& (df['POS'] <= 22382596) ]
	fl_subset=df[(df['POS'] >= 22385203)& (df['POS'] <= 22386611) ]

	f_del=(f_subset[sample]==0).sum()
	f_delp=f_del/f_subset.shape[0]
	m_del=(m_subset[sample]==0).sum()
	m_delp=m_del/m_subset.shape[0]
	mm_del=(mm_subset[sample]==0).sum()
	mm_delp=mm_del/mm_subset.shape[0]
	fl_del=(fl_subset[sample]==0).sum()
	fl_delp=fl_del/fl_subset.shape[0]
	open('del.txt','a').write(sample+'\t'+str(f_del)+'\t'+str(f_delp)+'\t'+str(m_del)+'\t'+str(m_delp)+'\t'+str(mm_del)+'\t'+str(mm_delp)+'\t'+str(fl_del)+'\t'+str(fl_delp)+'\n')


