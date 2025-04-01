<script lang="ts">
  import type { Snippet } from "svelte"
  import type { ClassValue } from "svelte/elements"

  interface TextProps {
    tag?: "p" | "span"
    size?: "text-body1" | "text-body2" | "text-body3" | "text-body4" | "text-heading1" | "text-heading2"
    color?: ClassValue
    class?: ClassValue
    children: Snippet
    [key: string]: unknown
  }

  let {
    tag = "p",
    size = "text-body1",
    color = "text-gray-10",
    class: className,
    children,
    ...props
  }: TextProps = $props()
</script>

<svelte:element this={tag} class={["font-sans", size, color, className]} {...props}>
  {@render children?.()}
</svelte:element>

