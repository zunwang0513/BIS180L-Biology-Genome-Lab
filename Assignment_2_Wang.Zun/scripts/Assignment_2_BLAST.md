__Name:__ Zun Wang

__Student ID:__ 915109847

__Where applicable (or when in doubt) provide the code you used to answer the questions__

__Exercise 1__: What is the [sequence format](https://www.genomatix.de/online_help/help/sequence_formats.html) for these sequences?  Do the files contain RNA or DNA sequences?  
These are FASTA sequence and are in DNA.  

__Exercise 2__: For the refseq file, the header line contains a number of fields, separated by "|".  For the first entry in the refseq file, try to figure out what each header is. List each field and what you think it is.  
  
MH781015: accession number  
Dengue virus 2 isolate G3AE: sequence title  
complete genome: genome completeness  
Dengue virus: virus species  
Mexico: contry where it is isolated  
Aedes aegypti: species latin name  


__Exercise 3__: How many of the viruses come from a domesticated cat (_Felis catus_) host?  How many come from a human host?  How many were isolated in the United States? Show the commands used to answer these questions.

1. 276 viruses | grep -c 'Felis catus' ncbi...
2. 29911 viruses | grep -c 'Homo Sapien' ncbi...
3. 19899 | grep -c 'USA' ncbi...


__Exercise 4__: Create a simple (markdown formatted) table with the following information for the refseq and patientseq files:

| file | file size | number of sequences | number of database | average size |
| :----: | :-----: | :------: | :------: | :------: |
| ncbi | 1.6G | 122200 | 1519312049 | 12433 |
| patient | 575.3kb | 8 | 568168 | 71021 |

code: grep -c '>' ncbi.../patient...
      sed -e '/>/d' > newfile.txt
      wc newfile.txt

__Exercise 5:__  How long did it take BLAST to run?
  
  It takes 39.802s.

__Exercise 6:__ Take a look at the beginning of the output file.  What type of virus did "SeqA" come from?

  From Hepatitis B virus.

__Exercise 7:__ Run a new BLAST but limit the results to 2 subjects per query sequence.  (Show your code).  Which patient sequence do you think comes from the virus that causes the respiratory disease? If you are unsure, do some literature/web searches on the different viruses.

  Sequence H. It is coronavirus.  
  code: time blastn  -db ../input/ncbi_virus_110119_2.txt -query ../input/patient_viral.txt -evalue 1e-3 -max_target_seqs 2 -outfmt '7 std stitle' > blastout.default.tsv  
    
__Exercise 8:__ Consider the host species listed for the hits.  Are any of these surprising to you?  Which ones?  Could they still have come from the patient sample or does this represent contamination from another source? (Again some web or literature searches will be helpful).
  Sequence F has a host bacteria, since it is a phage. It can still come from patient, but from bacteria in human.

__Exercise 9:__ Predict how changing the word size will affect search sensitivity and speed.  Explain your reasoning.  
  
  The bigger the word size, the lower the sensitivity, and higher the speed.

__Exercise 10:__ Provide the code used and then record the time in a markdown table    

| word size | time | unique hit |
| :----: | :-----: | :---------: |
| 9 | 1m41s | 2506 |
| 11 | 23s | 2506 |
| 13 |  14s  | 2503 |
| 15 |  7s  | 2485 |
| 17 |  5s  | 2419 |
| 19 |  4s  | 1790 |
| 28 |  2s  | 329 |
| megablast11 | 23s | 2506|
| dcmegablast11 | 1m4s | 2501 |
| blastn | 45.6s | 2509 |
| blastp | 17m47s | 2695 |

for WS in $(seq 9 2 19) 28  
do   
echo "Starting blastn with word size $WS"  
time blastn -db ../input/ncbi_virus_110119_2.txt -query ../input/SeqH.txt -evalue 1e-3 -max_target_seqs 10000 -word_size $WS -outfmt '7 std stitle' > blastout.$WS.tsv  
done


__Exercise 11:__ Use a for loop that builds on the command above to count the number of unique hits in each file.  Add these results to the table above.  Did word size affect time and sensitivity in the direction you predicted from Exercise 9?  (FYI a word size of 7 takes 16 minutes to run, but I decide to spare you that pain).  If you didn't already do this above, explain why word size is affecting the results in the way that it does.  
  
  The bigger word size has lower sensitivity so there are less unique hits and run more faster.  
  code: for WS in $(seq 9 2 19) 28     
  do  
   cut -f 2 -s blastout.$WS.tsv | sort | uniq |head > $WS.tsv;  
   wc $WS.tsv  
  done

__Exercise 12:__ Repeat the `blastn` searches but now comparing `megablast`, `dc-megablast`, and `blastn`.  Use a word_size of 11 but keep the evalue limit of 1e-3.  Add the time and number of (unique) hits to your table.  Comment on the differences.  For these sequences is word_size or algorithm (task) more important for the number of sequences found?
  
  The unique hit is about the same but time varies a lot. Megablast is the fastest and dcmegablast is the slowest. The word_size is more important for the number of sequences found. 
   
  for WS in megablast dc-megablast blastn  
  do   
   echo "Starting blastn with $WS"  
   time blastn -task $WS -db ../input/ncbi_virus_110119_2.txt -query ../input/SeqH.txt -evalue 1e-3 -max_target_seqs 10000 -word_size $WS -outfmt '7 std stitle' > blastout.$WS.tsv  
   cut -f 2 -s blastout.$WS.tsv | sort | uniq |head > $WS.tsv  
   wc $WS.tsv
  done

__Exercise 13:__ How many unique sequences were found by blastp?  Add the blastp result to your table and comment here.
  
  2695 were found using blastp.    
  code: time tblastx -db ../input/ncbi_virus_110119_2.txt -query ../input/SeqH.txt -evalue 1e-3 -outfmt '7 std stitle' -max_target_seqs 10000 > blastout.tblastx.tsv 
