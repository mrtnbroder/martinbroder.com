animation = false
elm = document.body
domPrefixes = "Webkit Moz O ms Khtml".split(" ")
animation = true if elm.style.animationName

if animation is false
	i = 0

	while i < domPrefixes.length
		if elm.style[domPrefixes[i] + "AnimationName"] isnt `undefined`
			animation = true
			break
		i++

sayhi = document.getElementById 'sayhi'
savedhi = sayhi.innerHTML
sayhi.setAttribute 'href', "mailto:hello@martinbroder.com?subject=Hi!"
# IE sucks. Yeah it does. Really. When you use IE you suck too. Go away!
sayhi.innerHTML = savedhi;

if animation
    sayhi.style.opacity = 0;