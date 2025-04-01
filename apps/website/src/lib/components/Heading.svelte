<script lang="ts">
  import type { Snippet } from "svelte"
  import type { ClassValue } from "svelte/elements"

  interface HeadingProps {
    tag?: "h1" | "h2" | "h3" | "h4" | "h5" | "h6"
    size?:
      | "text-body1"
      | "text-body2"
      | "text-body3"
      | "text-body4"
      | "text-heading1"
      | "text-heading2"
    color?: ClassValue
    class?: ClassValue
    children: Snippet
    [key: string]: unknown
  }

  let {
    tag = "h3",
    size = "text-heading2",
    color = "text-gray-10",
    class: className,
    children,
    ...props
  }: HeadingProps = $props()
  // let _tag = $state(tag)
</script>

<svelte:element
  this={tag}
  class={[size, "font-serif", color, className]}
  {...props}>
  {@render children?.()}
</svelte:element>

<style lang="postcss">
  @reference "$lib/styles/app.css";
</style>
