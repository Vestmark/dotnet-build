SOLUTION=$1

dotnet test $SOLUTION --logger:trx --results-directory:/src/TestResults /p:CollectCoverage=true /p:CoverletOutputFormat=json%2Clcov%2Copencover /p:CoverletOutput=/src/TestResults/lcov