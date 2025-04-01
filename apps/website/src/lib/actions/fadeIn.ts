import type { Action } from "svelte/action"

interface FadeInOptions {
  delay?: number
  delayTimes?: number
  ignore?: boolean
}

export const fadeIn: Action<HTMLElement, FadeInOptions> = (
  node: HTMLElement,
  { delay = 100, delayTimes = 1, ignore = false },
) => {
  if (ignore || delayTimes === 0) return

  const delayInMs = delay * delayTimes

  // the node has been mounted in the DOM
  node.style.setProperty("--delay", `${delayInMs}ms`)
  node.classList.add("motion-safe:animate-fadeIn")
}
