<script lang="ts">
  let { width = 24, height = 24, ...props } = $props()
</script>

<svg
  viewBox="0 0 24 24"
  width={width}
  height={height}
  xmlns="http://www.w3.org/2000/svg"
  focusable="false"
  {...props}>
  <path
    fill="none"
    stroke="currentColor"
    stroke-linecap="round"
    stroke-linejoin="round"
    stroke-width="1.5"
    d="M4 5h16M4 12h16M4 19h16"
    color="currentColor" />
</svg>
