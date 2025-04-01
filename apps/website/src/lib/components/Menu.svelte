<script lang="ts">
  import Link from "$lib/components/Link.svelte"
  import Social from "$lib/components/Social.svelte"
  import Cancel from "$lib/components/icons/Cancel.svelte"
  import Menu from "$lib/components/icons/Menu.svelte"
</script>

<div class="ml-auto flex justify-end">
  <div class="anchor">
    <button
      class="text-body2 hover:bg-gray-90 hover:border-gray-60 hover:text-gray-40 down inline-flex size-12 cursor-pointer items-center justify-center rounded-sm font-sans transition-colors"
      type="button"
      popovertargetaction="toggle"
      popovertarget="menu">
      <Menu />
    </button>
  </div>
  <dialog popover id="menu" class="bg-gray-95 target max-h-max max-w-sm">
    <div class="mx-6">
      <nav class="pointer-events-auto relative mx-auto max-w-sm p-6">
        <button
          class="text-gray-60 bg-gray-95 hover:bg-gray-90 hover:text-gray-40 down absolute top-10 right-0 inline-flex size-12 cursor-pointer items-center justify-center rounded-sm font-sans transition-colors"
          popovertargetaction="hide"
          popovertarget="menu">
          <Cancel />
        </button>
        <ul class="flex flex-col justify-center gap-y-4 text-center">
          <li>
            <Link href="/about">About</Link>
          </li>
          <li>
            <Link href="/">Blog</Link>
          </li>
          <li>
            <Link href="/">Now</Link>
          </li>
          <li>
            <Link href="/">Imprint</Link>
          </li>
        </ul>
      </nav>
      <Social />
    </div>
  </dialog>
</div>

<style lang="postcss">
  @reference "$lib/styles/app.css";

  .anchor {
    anchor-name: --menu;
  }
  .target {
    position-anchor: --menu;
    position: absolute;
    top: anchor(start);
    left: auto;
    right: anchor(end);
    transform: translate(24px, -24px);
  }
</style>
