<script lang="ts">
  import Text from "$lib/components/Text.svelte"
  import type { Snippet } from "svelte"
  import type { ClassValue } from "svelte/elements"

  interface DividerProps {
    class?: ClassValue
    children?: Snippet
  }

  let { children }: DividerProps = $props()
</script>

<div
  class="border-gray-90 xs:-left-6 xs:block absolute -left-4 hidden h-full min-h-0 min-w-0 border-s">
  <Text
    aria-hidden
    color="text-gray-60"
    size="text-body4"
    class="absolute top-1/2 -left-5 origin-left -rotate-90">
    {@render children?.()}
  </Text>
</div>
