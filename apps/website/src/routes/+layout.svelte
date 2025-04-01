<script lang="ts">
  import { metadata } from "$lib/meta/meta"
  import { PUBLIC_UMAMI } from "$env/static/public"
  import { websiteSchema } from "$lib/meta/meta"

  import "$lib/styles/app.css"

  let { children } = $props()
</script>

<svelte:head>
  {@html `<script type="application/ld+json">${JSON.stringify(websiteSchema)}</script>`}
  <script
    defer
    src="https://umami.martinbroder.com/script.js"
    data-website-id={PUBLIC_UMAMI}></script>
  <title>
    {metadata.title}
  </title>
  <meta name="description" content={metadata.description} />
  <meta property="og:title" content={metadata.opengraph.title} />
  <meta property="og:description" content={metadata.opengraph.description} />
  <meta property="og:url" content={metadata.opengraph.url} />
  <meta property="og:type" content="website" />
  <meta property="og:image" content={metadata.opengraph.image} />
  <meta property="og:image:width" content="1280" />
  <meta property="og:image:height" content="552" />
  <meta name="twitter:card" content={metadata.twitter.cardType} />
  <meta name="twitter:site" content={metadata.twitter.creator} />
  <meta name="twitter:creator" content={metadata.twitter.creator} />
  <meta name="twitter:title" content={metadata.twitter.title} />
  <meta name="twitter:description" content={metadata.twitter.description} />
  <meta name="twitter:image" content={metadata.twitter.image} />
  <meta name="twitter:image:alt" content={metadata.twitter.imageAlt} />
</svelte:head>

{@render children()}
