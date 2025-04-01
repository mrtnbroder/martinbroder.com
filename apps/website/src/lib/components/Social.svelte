<script lang="ts">
  import IconButton from "$lib/components/IconButton.svelte"
  import Github from "$lib/components/icons/Github.svelte"
  import Instagram from "$lib/components/icons/Instagram.svelte"
  import LinkedIn from "$lib/components/icons/LinkedIn.svelte"
  import Mail from "$lib/components/icons/Mail.svelte"
  import TwitterX from "$lib/components/icons/Twitter-X.svelte"
  import Bluesky from "./icons/Bluesky.svelte"
  import Xing from "./icons/Xing.svelte"
</script>

<ul class="text-gray-60 relative flex justify-center gap-x-3">
  <li>
    <IconButton href="mailto:hello@martinbroder.com">
      <Mail aria-label="Mail" />
    </IconButton>
  </li>
  <li>
    <IconButton href="https://x.com/mrtnbroder">
      <TwitterX aria-label="Twitter" />
    </IconButton>
  </li>
  <li>
    <IconButton href="https://www.linkedin.com/in/martin-broder-25043470/">
      <LinkedIn aria-label="LinkedIn" />
    </IconButton>
  </li>
  <li>
    <IconButton href="https://www.xing.com/profile/Martin_Broder2">
      <Xing aria-label="Xing" />
    </IconButton>
  </li>
  <li>
    <IconButton href="https://github.com/mrtnbroder">
      <Github aria-label="GitHub" />
    </IconButton>
  </li>
  <li>
    <IconButton href="https://www.instagram.com/mrtnbroder/">
      <Instagram aria-label="Instagram" />
    </IconButton>
  </li>
  <li>
    <IconButton href="https://bsky.app/profile/monoboldd.bsky.social">
      <Bluesky aria-label="Bluesky" />
    </IconButton>
  </li>
</ul>
