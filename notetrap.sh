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
	echo "Print usage statement"
}

# parameter evaluation
case $1 in
	-e) edit $2;;
	-l) list;;
	-s) search $2;;
	-p) print $2;;
	-a) append $2;;
	-*) usage;;
	*)  add $1;;
esac
