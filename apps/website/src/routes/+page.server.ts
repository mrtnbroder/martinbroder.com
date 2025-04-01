// import { OpenAiDadJoke } from "$lib/utils/DadJoke"
import { runnable } from "$lib/utils/getDadJoke"
import { Console, Effect } from "effect"
import type { PageServerLoad } from "./$types"

// Create a cached version of the joke effect that lasts for a specific duration
// const cachedJoke = OpenAiDadJoke.pipe(
//   Effect.map((joke) => ({ joke })),
//   Effect.tap(Console.log),
//   Effect.cached, // Cache the result
//   Effect.flatten
// )

export const load: PageServerLoad = async () => {
  const joke = await Effect.runPromise(runnable)
  console.log("joke", joke)
  return joke
}
