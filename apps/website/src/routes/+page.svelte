<script lang="ts">
  import Heading from "$lib/components/Heading.svelte"
  import Row from "$lib/components/Row.svelte"
  import Text from "$lib/components/Text.svelte"
  import Divider from "$lib/components/Divider.svelte"
  import Menu from "$lib/components/Menu.svelte"
  import Scene from "$lib/components/Scene.svelte"
  import Social from "$lib/components/Social.svelte"

  import type { PageData } from "./$types"

  let { data }: { data: PageData } = $props()

  console.log("data", data)

  const today = new Date().getFullYear().toString()
</script>

<Scene />

<div class="mx-6">
  <div class="mx-auto max-w-sm">
    <header class="flex pt-10">
      <div class="mb-10">
        <img
          src="/logo.svg"
          width="48"
          height="48"
          alt="martinbroder.com logo" />
      </div>
      <Menu />
    </header>

    <main>
      <div style:--delay="100ms" class="fade-in relative mb-10">
        <Divider>INTRO</Divider>
        <Heading tag="h1" size="text-heading1" class="mb-10 text-pretty">
          A interdisciplinary design engineer with a focus on startups and
          agencies to help bring their products to life.
        </Heading>
      </div>
      <!-- <h1 class="mb-10 font-serif text-lg text-pretty">
      I'm an interdisciplinary <span class="designer">designer</span> & <span class="developer">developer</span>,
      <span class="climber">climber</span> and <span class="optimist">optimist</span> with
      a focus on startups and agencies to help bring their products to life.
    </h1> -->
      <section class="relative mb-10">
        <Divider>MAIN</Divider>
        <!-- <p class="mb-6 text-gray-400">I am honored to have worked with these companies.</p> -->
        <Heading delayTimes={4} class="mb-4" tag="h2">Ventures.</Heading>
        <div class="flex flex-col gap-y-8 pb-4">
          <Row
            href="https://bundesdruckerei.de"
            role="Senior Frontend Engineer"
            company="Federal Press"
            daterange="2023–Present"
            location="Government, Berlin / Germany"
            description="German federal technology company specializing in products, solutions, and digital transformation for the public sector, as well as key areas of society and the economy. I was responsible for designing, developing, and delivering high-quality tools and assets used by companies within the German public sector, as well as by millions of individuals accessing governmental online services."
            link="bundesdruckerei.de" />
          <Row
            href="https://www.anyplace.com"
            role="Lead Fullstack Engineer, DevOps"
            company="Anyplace"
            daterange="2020–2023"
            location="Real Estate, San Francisco / USA"
            description="As a disruptor in the housing market, specializing in leasing furnished luxury apartments tailored for digital nomads who can work from anywhere. I developed and delivered a comprehensive design system, along with a web app, admin platform, and operational tools to support and scale their business."
            link="anyplace.com" />
          <Row
            href="https://www.vimcar.de/"
            role="Senior Frontend Engineer"
            company="Vimcar"
            daterange="2016–2020"
            location="IT Services, Berlin / Germany"
            description="A leading provider of digital fleet management solutions, offering tools to simplify vehicle tracking and compliance. In its early startup phase, I was responsible for developing the driver’s logbook app and the fleet management system for the web. Initially the sole front-end engineer, I later led a team of developers as the company expanded."
            link="bundesdruckerei.de" />
          <Row
            href="https://miro.com"
            role="Senior Frontend Engineer"
            company="InVision"
            companyacquired="by Miro"
            daterange="2015–2016"
            location="IT Services, San Francisco / USA"
            description="InVision enabled teams to create, share, and refine digital products seamlessly. I contributed to enhancing the tool with new features, optimizing performance—especially on mobile devices—and working closely with a small, cross-functional team of engineers, designers, and product managers."
            link="miro.com" />
        </div>
      </section>
      <section class="relative">
        <Divider>COLOPHON</Divider>
        <!-- <p class="mb-6 text-gray-400">I am honored to have worked with these companies.</p> -->
        <Heading class="mb-4" tag="h3">Colophon.</Heading>
        <div class="mb-10 grid grid-cols-2 gap-4">
          <div>
            <Text class="mb-2">Design</Text>
            <Text color="text-gray-60" size="text-body2">
              <span class="xs:min-w-20 inline-block">Tool:</span>
              <Text tag="span" color="text-gray-40" size="text-body2">
                Figma
              </Text>
            </Text>
            <Text color="text-gray-60" size="text-body2">
              <span class="xs:min-w-20 inline-block">Icons:</span>
              <Text tag="span" color="text-gray-40" size="text-body2">
                Iconify
              </Text>
            </Text>
            <Text color="text-gray-60" size="text-body2">
              <span class="xs:min-w-20 inline-block">Fonts:</span>
              <Text tag="span" color="text-gray-40" size="text-body2">
                Outline, Playfair Display
              </Text>
            </Text>
          </div>

          <div>
            <Text class="mb-2">Stack</Text>
            <Text color="text-gray-60" size="text-body2">
              <span class="xs:min-w-28 inline-block">Framework:</span>
              <Text tag="span" color="text-gray-40" size="text-body2">
                Svelte 5
              </Text>
            </Text>
            <Text color="text-gray-60" size="text-body2">
              <span class="xs:min-w-28 inline-block">CSS:</span>
              <Text tag="span" color="text-gray-40" size="text-body2">
                TailwindCSS
              </Text>
            </Text>
            <Text color="text-gray-60" size="text-body2">
              <span class="xs:min-w-28 inline-block">Language:</span>
              <Text tag="span" color="text-gray-40" size="text-body2">
                TypeScript
              </Text>
            </Text>
          </div>
        </div>
      </section>
      <Social />
    </main>

    <footer class="my-10">
      <Text size="text-body3" class="text-gray-60 text-center">
        {data.joke}
      </Text>
      <Text size="text-body3" class="text-gray-60 text-center">
        © 2010–{today} Martin Broder. All rights reserved.
      </Text>
      <!-- <Text size="text-body3" class="text-gray-60 text-center">
        © 2010–{today} Made with ❤️ and ☕ in Berlin
      </Text> -->
    </footer>
  </div>
</div>

<!-- <style lang="postcss">
  @reference "$lib/styles/app.css";

  .designer {
    @apply bg-linear-to-r from-white to-white bg-clip-text transition duration-300 ease-in-out;
    &:hover {
      /* @apply text-transparent from-pink-400 to-purple-400; */
    }
    cursor:
      url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg'  width='40' height='48' viewport='0 0 100 100' style='fill:black;font-size:24px;'><text y='50%'>🎨</text></svg>")
        16 0,
      auto; /*!emojicursor.app*/
  }
  .climber {
    @apply bg-linear-to-r from-white to-white bg-clip-text transition duration-300 ease-in-out;
    &:hover {
      /* @apply text-transparent from-teal-400 to-blue-400; */
    }
    cursor:
      url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg'  width='40' height='48' viewport='0 0 100 100' style='fill:black;font-size:24px;'><text y='50%'>🧗</text></svg>")
        0 0,
      auto; /*!emojicursor.app*/
  }
  .developer {
    @apply bg-linear-to-r from-white to-white bg-clip-text transition duration-300 ease-in-out;
    &:hover {
      /* @apply text-transparent from-red-400 to-yellow-400; */
    }
    cursor:
      url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg'  width='44' height='53' viewport='0 0 100 100' style='fill:black;font-size:26px;'><text y='50%'>👨‍💻</text></svg>")
        0 0,
      auto; /*!emojicursor.app*/
  }
  .optimist {
    @apply bg-linear-to-r from-white to-white bg-clip-text transition duration-300 ease-in-out;
    &:hover {
      /* @apply text-transparent from-yellow-400 to-green-400; */
    }
    cursor:
      url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg'  width='44' height='53' viewport='0 0 100 100' style='fill:black;font-size:26px;'><text y='50%'>💯</text></svg>")
        16 0,
      auto; /*!emojicursor.app*/
  }
</style> -->
