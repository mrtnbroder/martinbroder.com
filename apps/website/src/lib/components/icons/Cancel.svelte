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
  <g
    fill="none"
    stroke="currentColor"
    stroke-linecap="round"
    stroke-linejoin="round"
    stroke-width="1.5"
    color="currentColor">
    <path
      fill="none"
      stroke="currentColor"
      stroke-linecap="round"
      stroke-linejoin="round"
      stroke-width="1.5"
      d="M19 5L5 19M5 5l14 14"
      color="currentColor" />
  </g>
</svg>
