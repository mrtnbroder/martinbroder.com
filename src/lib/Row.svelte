<script>
  export let href = ""
  export let name = ""
  export let description = ""
  export let link = ""
</script>

<div class="border p-4 rounded-sm border-gray-700 flex-auto flex items-center">
  <div>
    <h3 class="text-base">{name}</h3>
    <p class="text-gray-400">{description}</p>
  </div>
  <a class="text-base ml-auto" target="_blank" rel="noreferrer" {href}>{link}</a>
</div>
