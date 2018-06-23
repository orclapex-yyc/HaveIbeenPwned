#!/bin/bash
#This script will look if the plain text passwords in ./10-million-password-list-top-1000000.txt exist in
#the file ./pwned-passwords-ordered-2.0.txt
#This script will show the ones that exist and also the ones that doesn't
#
#MIT License
#
#Copyright (c) 2018 
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.
#
#


while read p; do
  hash=`echo -n $p |openssl sha1|cut -d"=" -f2|cut -d" " -f2|tr '[:lower:]' '[:upper:]'`
  countfull=`look -d -f $hash ./pwned-passwords-ordered-2.0.txt`
  res=$?
  count=$(echo $countfull | cut -d":" -f2 )
  if [[ $res -eq 0 ]] ; then
        echo "Count of word: $p with hash: $hash is $count"
  else
        echo "Word: $p not found in ./pwned-passwords-ordered-2.0.txt"
  fi
done < ./10-million-password-list-top-1000000.txt


