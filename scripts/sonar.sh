SOLUTION=$1
SERVICE_NAME=$2
SONAR_TARGET_BRANCH=$3

export PATH=$PATH:/home/jenkins/.dotnet/tools

dotnet sonarscanner begin \
    /k:$SERVICE_NAME \
    /d:sonar.login=${SONAR_AUTH_TOKEN} \
    /d:sonar.host.url=${SONAR_HOST_URL} \
    /v:${BUILD_NUMBER} \
    /s:/src/SonarQube.Analysis.xml \
    /d:sonar.cs.opencover.reportsPaths=/src/TestResults/lcov.opencover.xml \
    /d:sonar.branch.name=${BRANCH_NAME} \
    $SONAR_TARGET_BRANCH
dotnet publish $SOLUTION -c Release
dotnet sonarscanner end /d:sonar.login=${SONAR_AUTH_TOKEN}