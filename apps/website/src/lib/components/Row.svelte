<script lang="ts">
  import Link from "./Link.svelte"
  import Text from "./Text.svelte"

  interface RowProps {
    href: string
    company: string
    description: string
    role: string
    daterange: string
    location: string
    link: string
    companyacquired?: string
    class?: string
  }

  let {
    href = "",
    company = "",
    description = "",
    role = "",
    daterange = "",
    location = "",
    companyacquired = "",
    class: className,
  }: RowProps = $props()
</script>

<div class={["flex flex-col space-y-2 p-6 rounded-lg transition hover:bg-[rgba(255,255,255,0.05)]", className]}>
  <div class="flex flex-row space-x-4">
    <Text size="text-body2">
      <Link href={href} target="_blank" rel="noopener noreferrer">
        {company}
      </Link>
      {#if companyacquired}
        <Text tag="span" color="text-gray-60" size="text-body2">
          (acquired {companyacquired})
        </Text>
      {/if}
    </Text>

    <Text color="text-gray-60" size="text-body3" class="ms-auto">
      {daterange}
    </Text>
  </div>
  <div class="flex flex-col gap-x-4 xs:flex-row">
    <Text color="text-gray-60" size="text-body3">{role}</Text>
    <Text color="text-gray-60" size="text-body3" class="xs:ms-auto">
      {location}
    </Text>
  </div>
  <Text size="text-body2" color="text-gray-40">{description}</Text>
</div>
