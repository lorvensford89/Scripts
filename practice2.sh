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

# Mathematical operations
var1=$((5 + 5))
var2=$(($var1 * 2))
echo "I have used mathematical operations."
echo "Var1 = $var1"
echo "Var2 = $var2"

# Conditional statement
user=el
if grep $user /etc/passwd
then
echo "The user $user Exists"
elif ls /home
then
echo "The user doesn't exist but anyway there is a directory under /home"
else
echo "The user $user doesn't exist"
fi

# Comparison
val1=text
val2="another text"
if [ "$val1" \> "$val2" ]
then
echo "$val1 is greater than $val2"
else
echo "$val1 is less than $val2"
fi

num1=45
num2=76
if [ $num1 -gt $num2 ]
then
echo "$num1 is greater than $num2"
elif [ $num1 -lt $num2 ]
then 
echo "$num1 is less than $num2"
else
echo "$num1 is equal to $num2"
fi

# Using floating-point numbers
a=7
b=2
echo $((a + b))
echo "scale=2; $a / $b" | bc
echo $((a % b))
result=$(echo "scale=2; $a / $b" | bc)
echo "Storing floating-point number in a variable and use it: $result"