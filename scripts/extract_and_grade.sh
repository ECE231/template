#! /bin/bash
echo Extract and Grading script for ECE231 homework submissions
if [ "$#" -ne 1 ]; then
  echo You must supply the name of the tar.gz file to grade
  echo "USAGE: grade.sh <file to grade>"
  exit -1
fi
echo Grading submitted file $1
FILENAME=$(basename $1 .tar.gz)
echo Extracting homework number ${HW_NUMBER} from file name
HW_NUMBER=${FILENAME: -2}

mkdir $FILENAME
cd $FILENAME

echo Unzipping source directory
tar -xzf ../$1

echo building code
mkdir build 
cd build
cmake ../ECE231 > cmake_output.txt
if [ $? -eq 0 ] 
then
  echo cmake succeeded
else
  echo "CMAKE FAILED: CAN'T CONTINUE"
  exit -1
fi
make > make_output.txt
if [ $? -eq 0 ] 
then
  echo make succeeded
else
  echo "MAKE FAILED: CAN'T CONTINUE"
  exit -1
fi

../ECE231/scripts/grade.sh $HW_NUMBER
