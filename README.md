# JwtApiClient

Low-level utilities for interacting with APIs using [JWToken](https://jwt.io) authentication and transferring data in the JSON format.

## Requirements

- iOS 15+ as the code uses the `async/await` syntax.

## API

The package exports a protocol with default method implementations as well as the underlying functions.

### JsonApiCompatible protocol

```swift
public protocol JsonApiCompatible {
  static func post<T: Decodable>(_ url: URL!, _ dictionary: [String: Any]) async throws -> T

  static func post<T: Decodable>(_ url: URL!, token: String, dictionary: [String: Any]) async throws -> T

  static func get<T: Decodable>(_ url: URL, token: String) async throws -> T

  // The methods below currently assume the response is empty
  static func delete(_ url: URL, token: String) async throws

  static func patch(_ url: URL!, token: String, dictionary: [String: Any]) async throws
}
```

## tl:dr;

Say, your API returns the following JSON packet on successful authentication:

```json
{ "token": "<some JWT token>" }
```

... or an error if something goes wrong:

```json
{
  "error": {
    "statusCode": 40123,
    "name": "something_went_wrong",
    "message": "Some human-readable explanation"
  }
}
```

The above can be represented by a `catch`-able Swift error object:

```swift
struct ErrorResponse: Decodable {
  let error: ApiError
}

struct ApiError: Decodable {
  let statusCode: Int
  let name: String
  let message: String
}

extension ApiError: Error {}
```

Definition of success and failure responses in Swift:

```swift
public struct TokenResponse: Decodable {
  public let token: String
}

extension TokenResponse {
  enum CodingKeys: CodingKey {
    case token
  }

  public init(from decoder: Decoder) throws {
    guard let container = try? decoder.container(keyedBy: CodingKeys.self),
          let token = try? container.decode(String.self, forKey: .token) else {
        throw try ErrorResponse(from: decoder).error
    }

    self.init(token: token)
  }
}
```

Handling the request:

```swift
let client: JsonApiCompatible = JsonApiClient()

let url = URL(string: "https://fake.api.url/users/login")
let credentials = [
  "login": "joe@bloggs.com",
  "password": "topS3cret"
]

var jwtToken = ""

do {
  let result: TokenResponse = try await client.post(url!, credentials)
  jwtToken = result.token
} catch let error as ApiError {
  // Handle API errors
} catch {
  // Handle other errors
}
```

## Sample usage

Examples below use _functions_ but you might want to use a thin `JsonApiClient` wrapper struct instead.

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
let result: Token = try await postJsonDictionary(url!, credentials)

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
let books: [Book] = try await getJsonWithToken(endpoint, token: jwtToken)
```

This request is an equivalent of the following Curl command:

```bash
curl -X 'GET' \
  'https://fake.api.url/books' \
  -H 'Accept: application/json' \
  -H 'Authorization: Bearer my.valid.jwtoken'
```

### Posting JSON with JWT

Similar to previous examples, you can use the following utility:

```swift
let result: <<YourTypeHere>> = try await postJsonDictionaryWithToken(endpoint, token: jwtToken, dictionary: data)
```

## Credits

The code is based on an [article by Donny
Wals](https://www.donnywals.com/building-a-token-refresh-flow-with-async-await-and-swift-concurrency/)
covering concurrency in the latest version of the [Swift programming
language](https://swift.org).
