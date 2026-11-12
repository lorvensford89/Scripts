#!/bin/bash
# This is a second comment
mydir=$(pwd)
whoami
ls
echo "My working directory is: $mydir"

echo "This is a preparation for completing the 3rd project."
echo "I am learning DevOps."

age=22.8
person="EL"

# Use of variables(Environment's and User's)
echo "Home for the current user is: $HOME"
echo "$person is a great man, he is $age years old."

#Mathematical operations
var1=$((5 + 5))
var2=$(($var1 * 2))
echo "I have used mathematical operations."
echo "Var1 = $var1"
echo "Var2 = $var2"