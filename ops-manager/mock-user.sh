OPSMANAGER_HOST="localhost"
PORT="8080"

curl --digest   --header "Accept: application/json"   --header "Content-Type: application/json"   --include   --request POST "http://${OPSMANAGER_HOST}:${PORT}/api/public/v1.0/unauth/users?pretty=true"   --data '
    {
      "username": "admin",
      "password": "Passw0rd.",
      "firstName": "mock",
      "lastName": "account"
    }'
