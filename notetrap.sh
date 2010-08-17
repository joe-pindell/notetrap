#! /bin/sh
note_dir=~/notes
note_date=$(date +"%Y-%m-%d")
note_file=$note_date.txt
note_time=$(date +"%r")

add() {
	# add a new note
	echo "$note_date: $note_time: $(t n): $*" >> $note_dir/$note_file
}

append() {
	# append to previous note
	echo "this function has not been implemented - still debating 
it's worth"
}

edit() {
	# edit a note
	if [ $# = 0 ]; then
		a_file=$note_dir/$note_file
	else
		a_file=$note_dir/$*.txt
	fi
	if [ -f $a_file ]; then
		pico $a_file
	else
		echo 
		echo "The file '$a_file' does not exist to edit."
		echo
	fi
}

list() {
	# list all the notes (with most recent at the bottom)
	ls -c1 $note_dir
}

search() {
	# search notes for text
	grep -h --color=auto "$*" $note_dir/*.txt
}

print() {
	# print the contents of a note file
	if [ $# = 0 ]; then
		msg="Notes from today:"
		a_file=$note_dir/$note_file
	else
		msg="Notes from $*.txt:"
		a_file=$note_dir/$*.txt
	fi
	echo
	if [ -f $a_file ]; then
		echo $msg
		cat $a_file
	else
		echo "The note file '$a_file' does not exist."
	fi
	echo
}

usage() {
	# print usage
	cat << EOT
  Notetrap
  ========

  Notetrap is a simple command line note taking application implemented 
  as a shell script. Each note entered on the command line is appended 
  with a date, time, current timetrap timesheet (t now), and filed 
  away 
  into the daily note file. The script also contains some utility 
  functions to list, edit, and search through the notefiles.

  All the note files are stored in the /usr/notes directory unless 
  otherwise modified. 

  This is the result of inspiration drawn largely from Lifehacker posts 
  about managing life through text files. It's name is a 
  nod to timetrap http://github.com/samg/timetrap by samg.

  Usage
  -------
  Call notetrap by executing the shell script with one of the following 
  parameters:
  
  "a note" this writes the note into a daily note file.
	notetrap.sh "I just read a really interesting article"

  -e [notefilename] opens notefilename in editor. The default 
	notefilename is the current day. The file extension is .txt and 
	not needed as part of the parameter.
	notetrap.sh -e
	notetrap.sh -e Notefile

  -h display the usage text

  -l lists all the note files (most recent is last)

  -p [notefilename] prints the contents of notefilename to the screen. 
	If no notefilename is specified, then the current daily note 
	file is used.
	notetrap.sh -p
	notetrap.sh -p 2010-08-12

  -s search the note files for text 

  As a shortcut, alias "n" to notetrap.sh in your profile. 

EOT
}

# parameter evaluation
case $1 in
	-a) append $2;;
	-e) edit $2;;
	-h) usage;;
	-l) list;;
	-p) print $2;;
	-s) search $2;;
	-*) usage;;
	*)  add $1;;
esac
