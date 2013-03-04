var animation, domPrefixes, elm, i, savedhi, sayhi;

animation = false;

elm = document.body;

domPrefixes = "Webkit Moz O ms Khtml".split(" ");

if (elm.style.animationName) {
  animation = true;
}

if (animation === false) {
  i = 0;
  while (i < domPrefixes.length) {
    if (elm.style[domPrefixes[i] + "AnimationName"] !== undefined) {
      animation = true;
      break;
    }
    i++;
  }
}

sayhi = document.getElementById('sayhi');

savedhi = sayhi.innerHTML;

sayhi.setAttribute('href', "mailto:hello@martinbroder.com?subject=Hi!");

sayhi.innerHTML = savedhi;

if (animation) {
  sayhi.style.opacity = 0;
}
