# Create Cards
main = new Layer
	height: Screen.height
	width: Screen.width

allCards = []

for i in [0...4]
	card = new Layer
		parent: main
		name: "card" + i
		height: Screen.height - (Screen.height*(i/4))
		width: Screen.width
		backgroundColor: "white"
		shadowY: 3
		shadowBlur: 40
	label = new Layer
		height: 30
		width: 200
#		y: Align.bottom(-30)
		maxY: card.height
		x: Align.center
		superLayer: card
		backgroundColor: 'transparent'
		html: "<p style='font-size:24px; color: #333; text-align: center;''>- TAP HERE -</p>" + i
	
	allCards.push card
		
	# Define States	
	card.states.add
		default:
			height: Screen.height - (Screen.height*(i/4))
			opacity: 1
		open: 
			height: Screen.height
			opacity: 1
		closed:
			height: 0
			opacity: 0

	# Define Events
	card.onTapEnd ->
		this.states.animationOptions =
			curve: "ease-in"
			time: ".25"
		this.states.next("open", "default")
		for sib in this.siblings
			if (sib.index > this.index)
				sib.states.next("closed", "default")

for eachCard in allCards
	eachCard.on "change:frame", (event, layer) ->
		layer.children[0].maxY = layer.height