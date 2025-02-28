<script>
  let { href = "", name = "", description = "", link = "" } = $props()
</script>

<div class="border p-4 rounded-sm border-gray-700 flex-auto flex items-center">
  <div>
    <h3 class="text-base">{name}</h3>
    <p class="text-gray-400">{description}</p>
  </div>
  <a class="text-base ml-auto" target="_blank" rel="noreferrer" {href}>{link}</a>
</div>
