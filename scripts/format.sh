SOLUTION=$1

dotnet format $SOLUTION --severity error --verify-no-changes
