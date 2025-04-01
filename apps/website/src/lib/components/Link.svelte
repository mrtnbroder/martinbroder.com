<script lang="ts">
  import type { Snippet } from "svelte"
  import type { ClassValue } from "svelte/elements"

  interface LinkProps {
    class?: ClassValue
    children: Snippet
    [key: string]: unknown
  }

  let { class: className, children, ...props }: LinkProps = $props()

  // let _tag = $state(tag)
</script>

<a class={["Link", className]} {...props}>
  {@render children?.()}
</a>

<style lang="postcss">
  @reference "$lib/styles/app.css";

  .Link {
    @apply text-body1 text-gray-10 font-sans;
    @apply focus:outline-none;
    @apply transition-colors duration-300 ease-in-out;
    @apply focus-visible:underline;

    &[href^="https://"],
    &[href^="mailto:"] {
      &::after {
        @apply ms-1 inline-block origin-center translate-x-0 align-text-top leading-none opacity-50 transition duration-300 ease-in-out;
        content: "↗";
      }
    }

    &:focus-visible::after,
    &:hover::after {
      @apply rotate-45 translate-y-0.5 opacity-100;
    }
  }
</style>
