<script>
  import Row from "$lib/Row.svelte"
</script>

<div class="max-w-(--breakpoint-xl) px-6 mx-auto">
  <header class="pt-10">
    <div class="flex items-center mb-10">
      <img src="/logo.svg" width="48" height="48" alt="martinbroder.com logo" />
      <nav class="ml-auto">
        <ul class="flex space-x-4">
          <li class="text-gray-400">
            <a href="/">@</a>
          </li>
          <li class="text-gray-400">
            <a href="/">Github</a>
          </li>
          <li class="text-gray-400">
            <a href="/">Instagram</a>
          </li>
          <li class="text-gray-400">
            <a href="/">Linkedin</a>
          </li>
          <!-- <li class="text-gray-400">
            <a href="/">Dribbble</a>
          </li> -->
        </ul>
      </nav>
    </div>
  </header>

  <main>
    <h1 class="mb-10 text-xl text-pretty">
      I'm an interdisciplinary designer & <span class="developer">developer</span>,
      <span class="climber">climber</span>, adventurer and <span class="optimist">optimist</span> with
      a focus on startups and agencies to help bring their products to life.
    </h1>

    <h2 class="text-lg">Projects & Companies.</h2>
    <p class="mb-6 text-gray-400">I am honored to have worked with these companies.</p>

    <div class="flex flex-col space-y-4">
      <!-- <Row
        href="https://bundesdruckerei.de"
        name="Bundesdruckerei"
        description="Crafting a digital design system for the german government."
        link="bundesdruckerei.de"
      /> -->
      <Row
        href="https://anyplace.com"
        name="Anyplace Inc."
        description="Global marketplace for flexible housing."
        link="anyplace.com"
      />
      <Row
        href="https://vimcar.de"
        name="Vimcar GmbH"
        description="Fleet management and bookkeeping software for individuals and businesses."
        link="vimcar.de"
      />
      <Row
        href="https://invisionapp.com"
        name="InVisionApp Inc."
        description="Creating a design software for the next generation of digital products."
        link="invisionapp.com"
      />
      <Row
        href="https://uniqlo.com"
        name="UNIQLO Co., Ltd."
        description="Japanese casual wear retailer and manufacturer with a global presence."
        link="uniqlo.com"
      />
    </div>
  </main>

  <footer class="my-10">
    <p class="text-center text-gray-400">© 2010 — 2024 Martin Broder</p>
  </footer>
</div>

<style lang="postcss">
  .climber {
    @apply transition duration-300 ease-in-out bg-clip-text;
    &:hover {
      @apply text-gray-800;
    }
    cursor:
      url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg'  width='40' height='48' viewport='0 0 100 100' style='fill:black;font-size:24px;'><text y='50%'>🧗</text></svg>")
        0 0,
      auto; /*!emojicursor.app*/
  }
  .developer {
    @apply transition duration-300 ease-in-out bg-clip-text bg-linear-to-r from-white to-white;
    &:hover {
      @apply text-transparent from-red-400 to-yellow-400;
    }
    cursor:
      url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg'  width='44' height='53' viewport='0 0 100 100' style='fill:black;font-size:26px;'><text y='50%'>👨‍💻</text></svg>")
        0 0,
      auto; /*!emojicursor.app*/
  }
  .optimist {
    @apply transition duration-300 ease-in-out bg-clip-text bg-linear-to-r from-white to-white;
    &:hover {
      @apply text-transparent from-yellow-400 to-green-400;
    }
    cursor:
      url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg'  width='44' height='53' viewport='0 0 100 100' style='fill:black;font-size:26px;'><text y='50%'>💯</text></svg>")
        16 0,
      auto; /*!emojicursor.app*/
  }
</style>
