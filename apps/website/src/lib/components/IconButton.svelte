<script lang="ts">
  import type { Snippet } from "svelte"

  interface IconButtonProps {
    href?: string
    class?: string
    children?: Snippet
  }

  let {
    href = "",
    class: className,
    children,
    ...props
  }: IconButtonProps = $props()
</script>

<a
  class={[
    "bg-gray-95 border-gray-80 hover:bg-gray-90 hover:border-gray-60 hover:text-gray-40 down inline-flex size-10 items-center justify-center rounded border",
    className,
  ]}
  href={href}
  referrerpolicy="no-referrer"
  rel="noopener noreferrer"
  target={href ? "_blank" : undefined}
  {...props}>
  {@render children?.()}
</a>
