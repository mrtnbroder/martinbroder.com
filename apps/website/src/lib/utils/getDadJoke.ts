import {
  HttpClient,
  HttpClientRequest,
  HttpClientResponse
} from "@effect/platform"
import { NodeHttpClient } from "@effect/platform-node"; // For running in Node.js
import { Effect, Schema } from "effect"

// Define the URL for the API endpoint
const url = "https://icanhazdadjoke.com/"

// Define a schema for the expected JSON response structure
// This ensures the response has the fields we expect with the correct types.
const DadJokeResponse = Schema.Struct({
  id: Schema.String,
  joke: Schema.String,
  status: Schema.Literal(200), // Expecting a 200 status code in the JSON body
})

// Type alias for the inferred type from the schema
type DadJokeResponse = Schema.Schema.Type<typeof DadJokeResponse>

// Create the Effect program to fetch and parse the joke
export const getDadJoke = Effect.gen(function* () {
  // Get the default HttpClient service
  const client = yield* HttpClient.HttpClient

  // Create a GET request
  const request = HttpClientRequest.get(url).pipe(
    // const request = HttpClient.request.get(url).pipe(
    // Set the required "Accept" header for JSON response
    HttpClientRequest.setHeader("Accept", "application/json"),
    // Set a User-Agent header (good practice for public APIs)
    HttpClientRequest.setHeader(
      "User-Agent",
      "MyEffectApp (github.com/mrtnbroder)",
    ), // Optional but recommended
  )
  // Execute the request using the client
  const jokeResponse = yield* client.execute(request)
  // Execute the request using the client
  return yield* HttpClientResponse.schemaBodyJson(DadJokeResponse)(jokeResponse)
})

// Provide the necessary layer for the HttpClient (using the Node.js implementation)
export const runnable = Effect.provide(getDadJoke, NodeHttpClient.layer)

// --- To run this code ---
// 1. Make sure you have the necessary packages:
//    npm install effect @effect/platform @effect/platform-node @effect/schema
//    or yarn add effect @effect/platform @effect/platform-node @effect/schema
//    or pnpm add effect @effect/platform @effect/platform-node @effect/schema
// 2. Execute the runnable Effect:
// NodeRuntime.runMain(runnable);
// Or, if you're integrating this into another Effect program or framework (like SvelteKit):
// Effect.runPromise(runnable).then(console.log).catch(console.error);

// Example of running it directly:
// NodeRuntime.runMain(runnable)
