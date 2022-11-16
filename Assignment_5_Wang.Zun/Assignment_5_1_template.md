# Assignment_5_1.md

Student Name: Zun Wang
Student ID: 915109847

Insert answers to Illumina exercises 1 - 7 here.  Submit this .md by git.

__Exercise 1:__  

__a__ What is the read length? (can you do this without manually counting?)  

100, look at the report, it will tell you.

__b__ What is the machine name?  

  HWI-ST611

__c__ How may reads are in this file? (show how you figured this out)

 grep -c '@' GH.lane67.fastq 

 1000000
  
__d__ Are the quality scores Phred+33 or Phred+64? (how did you figure this out?)

phred+64
The AASC

__Exercise 2:__ Compare your fastq results to the examples of [good sequence](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/good_sequence_short_fastqc.html) and [bad sequence](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/bad_sequence_fastqc.html) on the fastqc website.  Comment on any FastQC items that have an "X" by them in the report.  What might have caused these issues? (hint: think about barcodes). 

The per base sequence quality and per sequence content are X, because the read length is too long and there are barcodes and seperating code T in front of the actual sequence.
__Exercise 3:__

__Modify__ and then run this command

    trimmomatic SE -phred64 GH.lane67.fastq.gz GH.lane67.trimmed.fastq SLIDINGWINDOW:5:15 MINLEN:70

__a__ What trimmomatic command did you use?  

trimmomatic SE -phred64 GH.lane67.fastq GH.lane67.trimmed.fastq SLIDINGWINDOW:4:20 MINLEN:50

_b__ How many reads were removed by trimming? 

42107

__c__ Trimmomatic has the option to remove Illumina adapters.  Why did we not do that here?  

It does not have any adapter at all, so we do not need to remove it.

__d__ rerun FastQC on the trimmed sequences.  Which issues did the trimming fix?

(If you want a good challenge you can try to figure out how many reads were trimmed...)

The per base sequence quality is fixed.

__Excercise 4:__ Look at the [README for auto_barcode](https://github.com/mfcovington/auto_barcode) and figure out how to run it to split your samples.  Specify that the split fastq files are placed in the directory `split_fq`.  __Use the perl (.pl) version of the script__

__a__ what command did you use?  

barcode_split_trim.pl --id demo --barcode Brapa_fastq/barcode_key_GH.txt --list --outdir ../output Brapa_fastq/GH.lane67.trimmed.fastq

__b__ what percentage of reads did not match a barcode?  What are possible explanations?

6.1%

__Exercise 5:__  
__a:__ What library has the worst quality based on the `Sequence Quality Histograms`?  Is it bad enough to concern you?  

R500_NDP_2_LEAF, it falls into the yellow area, I think it is not very important.

__b:__ Click on `status checks`.  Which report is the most troublesome?

The per sequence content.

__c:__ Go the report page identified in in __b__.  Click on the libraries that have problems.  Describe the problem.  Bad enough to concern you?

Yes, they are all red for all libraries, probably because the barcodes and the searating codes are still there so the problem remain unsolved.

__Exercise 6:__ use a fish for loop run tophat on all of the fastq files.  Show your code here.

for file in $myfiles;
> do
> mkdir ../tophat_result/$file
> tophat --phred64-quals -p 2 -o ../tophat_result/$file ../../input/Brapa_reference/BrapaV1.5_chrom_only $file
> done

**JD:** -0.25 When was myfiles created?


EXERCISE 7 AND 8 WILL BE PART OF THURSDAY'S LAB

__Exercise 7__: Take a look at the `align_summary.txt` file.  
__a__  What percentage of reads mapped to the reference?

81.1%

__b__  Give 2 reasons why reads might not map to the reference.

Reference can only be a reference. It cannot perfectly match the sample since they are not from the same cell. One reason maybe due to individual variance.

Another reason might be from contamination. The sample is contaminated by other junk sequences so it will not match the reference very well.



__Exercise 8__:  
__a__ Can you distinguish likely SNPs from sequencing/alignment errors?  How?

Yes, there are single nucleotide differences that indicate potential SNPs.

**JD:** -0.25 How can you tell?

__b__ Go to A01:15,660,359-15,665,048 (you can cut and paste this into the viewer and press "Go".  For each of the the three genes in this region: does the annotation (in blue) appear to be correct or incorrect? If incorrect, describe what is wrong

The annotation does not fully cover the grey alignment part above, maybe the reference cannot represent those alignments.
