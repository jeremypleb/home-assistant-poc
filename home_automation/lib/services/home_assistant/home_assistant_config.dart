// ip addr | grep eth0 | awk 'FNR == 2 { print $2 }' | tr "/" "\n" | awk 'FNR == 1 { print }'
const ADDRESS = "localhost";
const PORT = "8123";
const TOKEN =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJiZGY0MWYxOGNiM2Q0N2E5YTg3ZjRmM2E3NTUzMzM1NyIsImlhdCI6MTYxMjIwNjU0MCwiZXhwIjoxOTI3NTY2NTQwfQ.N7t5jH4u2l5Flfx1jjfvF_aZRWDiAK2m31-bjt8BZrQ";
