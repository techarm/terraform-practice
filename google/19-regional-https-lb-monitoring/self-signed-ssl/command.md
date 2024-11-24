```
# Create your app key:
openssl genrsa -out app.key 2048

# Create your app1 certificate signing request:
openssl req -new -key app.key -out app.csr -subj "/CN=app.example.com"

# Create your app1 certificate:
openssl x509 -req -days 7300 -in app.csr -signkey app.key -out app.crt
```
