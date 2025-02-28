<script lang="ts">
  import { useMachine } from "@xstate/svelte"
  import { machine } from "./machine"

  const { snapshot, send } = useMachine(machine)

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
</script>

<div class="mx-auto max-w-2xl p-6">
  <h1>About</h1>
  <h3>State: {$snapshot.value}</h3>
  <h3>Filter: {$snapshot.context.filter}</h3>
  <input
    class="input-field"
    type="text"
    bind:value={$snapshot.context.value}
    oninput={handleInput}
    onfocus={handleFocus}
    onblur={handleBlur}
    onkeyup={handleKeyUp}
  />
</div>

<style lang="postcss">
  @reference "tailwindcss/theme";

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
