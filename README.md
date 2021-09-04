# JwtApiClient

Low-level utilities for interacting with APIs using [JWToken](https://jwt.io) authentication and transferring data in the JSON format.

## Requirements

- iOS 15+ as the code uses the `async/await` syntax.

## Sample usage

### Obtaining JWT token

1. Define the token API endpoint response model, e.g.:

```swift
struct Token: Decodable {
  let token: String
}
```

2. Provide the endpoint URL and credentials, e.g.:

```swift
let url = URL(string: "https://fake.api.url/users/login")
let credentials = [
  "email": "joe@bloggs.com",
  "password": "topS3cret"
]
```

3. Make a `POST` request, e.g.:

```swift
let result: Token = try await requestTokenWithJsonCredentials(url!, credentials)

print("My JWT token: \(result.token)")
```

This request is an equivalent of the following [Curl](https://curl.se) command:

```bash
curl -X 'POST' \
  'https://fake.api.url/users/login' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
    "email": "joe@bloggs.com",
    "password": "topS3cret"
  }'
```

### Getting resources requiring JWT

1. Define the API endpoint response model, e.g.:

```swift
struct Book: Decodable {
  let id: Int
  let title: String
  let author: String
}
```

2. Provide the endpoint URL and token, e.g.:

```swift
let endpoint = URL(string: "https://fake.api.url/books")
let jwtToken = "my.valid.jwtoken"
```

3. Make a `GET` request, e.g.:

```swift
let books: [Book] = try await requestWithAuthorisation(endpoint, token: jwtToken)
```

This request is an equivalent of the following Curl command:

```bash
curl -X 'GET' \
  'https://fake.api.url/books' \
  -H 'Accept: application/json' \
  -H 'Authorization: Bearer my.valid.jwtoken'
```

## Credits

The code is based on an [article by Donny
Wals](https://www.donnywals.com/building-a-token-refresh-flow-with-async-await-and-swift-concurrency/)
covering concurrency in the latest version of the [Swift programming
language](https://swift.org).
