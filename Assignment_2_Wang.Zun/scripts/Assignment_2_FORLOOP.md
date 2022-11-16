__Name:__ Zun Wang

__Student ID:__ 915109847

__Where applicable (or when in doubt) provide the code you used to answer the questions__

__Exercise One__: Write a for loop to pluralize peach, tomato, potato (remember that these end in "es" when plural)

fruits="peach tomato potato"  
> for fruit in ${fruits}  
  &nbsp; do  
  &nbsp;&nbsp;&nbsp; echo "${fruit}es"  
  &nbsp; done
  
__Exercise Two__ In your own words provide a "translation" of the above loop. 
 
  Translation: for each file in the list of files $myfiles, take one file at a time and place it in a new variable $file. Then run the command cat $file is run to print the file. Go back to the top, place the next file in the list into $file and repeat the echo command. This will continue until there are no more files. 
     
__Exercise Three__ Modify the above loop to the following output

>for file in $myfiles  
&nbsp; do  
&nbsp;&nbsp;&nbsp; echo -n "file $file contains:"  
&nbsp;&nbsp;&nbsp; cat $file  
&nbsp; done
