SOLUTION=$1

dotnet test $SOLUTION --logger:trx --results-directory:/src/TestResults --collect:"XPlat Code Coverage;Format=opencover"
