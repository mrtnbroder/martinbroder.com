<script lang="ts">
  import { useMachine } from "@xstate/svelte"
  import { createBrowserInspector } from "@statelyai/inspect"

  import { machine } from "./machine"

  const items = [
    { value: "apple", label: "Apple" },
    { value: "banana", label: "Banana" },
    { value: "blueberry", label: "Blueberry" },
    { value: "boysenberry", label: "Boysenberry" },
    { value: "cherry", label: "Cherry" },
    { value: "cranberry", label: "Cranberry", disabled: true },
    { value: "durian", label: "Durian" },
    { value: "eggplant", label: "Eggplant" },
    { value: "fig", label: "Fig" },
    { value: "grape", label: "Grape" },
    { value: "guava", label: "Guava" },
    { value: "huckleberry", label: "Huckleberry" },
  ]

  const { inspect } = createBrowserInspector()
  const { snapshot, send } = useMachine(machine, {
    inspect,
    input: {
      options: items,
    },
  })

  // Handle input change based on value
  function handleInput(event: Event & { currentTarget: EventTarget & HTMLInputElement }) {
    send({ type: "input.input", value: event.currentTarget.value })
  }

  function handleFocus(event: Event & { currentTarget: EventTarget & HTMLInputElement }) {
    send({ type: "input.focus" })
  }

  function handleBlur(event: Event & { currentTarget: EventTarget & HTMLInputElement }) {
    send({ type: "input.blur" })
  }

  function handleKeyUp(event: KeyboardEvent) {
    send({ type: "input.keyup", event })
  }

  function handleKeyDown(event: KeyboardEvent) {
    send({ type: "input.keydown", event })
  }

  function selectOption(event: Event & { currentTarget: EventTarget & HTMLInputElement }) {
    send({ type: "option.select", event })
  }
</script>

<div class="prose prose-invert mx-auto py-8">
  <h1>About</h1>
  <p>
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut
    labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
    laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
    voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
    non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  </p>
  <p>
    Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque
    laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto
    beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut
    odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.
  </p>
</div>

<style lang="postcss">
  @reference "tailwindcss";

  .input-field {
    @apply border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-500;
  }

  .input-field:hover {
    @apply border-blue-400;
  }

  /* Additional styles for input field when active */
  .input-field:active {
    @apply border-blue-600;
  }

  /* Additional styles for input field when focused */
  .input-field:focus {
    @apply ring-blue-500 ring-2;
    @apply transition duration-200 ease-in-out; /* Adding smooth transition on focus */
  }
</style>
