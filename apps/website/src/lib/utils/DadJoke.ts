import { OpenAiClient, OpenAiCompletions } from "@effect/ai-openai"
import { Completions } from "@effect/ai"
import { NodeHttpClient } from "@effect/platform-node"
import { Config, Effect, Layer } from "effect"

const generateDadJoke = Effect.gen(function* () {
  const completions = yield* Completions.Completions
  const response = yield* completions.create("Generate a hilarious dad joke")

  return response
})

const Gpt4o = OpenAiCompletions.model("gpt-4o")

const OpenAi = OpenAiClient.layerConfig({
  apiKey: Config.redacted("OPENAI_API_KEY"),
})

export const OpenAiWithHttp = Layer.provide(OpenAi, NodeHttpClient.layerUndici)

export const main = Effect.gen(function* () {
  const gpt4o = yield* Gpt4o
  const response = yield* gpt4o.provide(generateDadJoke)

  return response.text
})

export const OpenAiDadJoke = Effect.provide(main, OpenAiWithHttp)
