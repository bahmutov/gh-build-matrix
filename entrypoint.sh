#!/bin/bash

N=$1
# by default N is 1
N=${N:-1}

INDEX=0

OUTPUT='{"containers":['

while [ $INDEX -lt $N ]
do
  if [ $INDEX -lt $(($N-1)) ]
  then
    OUTPUT+="$(($INDEX+1)), "
  else
    OUTPUT+="$(($INDEX+1))"
  fi

  INDEX=$(($INDEX+1))
done

# close the list
OUTPUT+="]}"

# set the job's output
echo "matrix::$OUTPUT" >> $GITHUB_OUTPUT
# and print the list so that everyone can see it
echo ${OUTPUT}
