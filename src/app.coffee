

# NEED TO SWITCH LOADER
gear_ic = require("./assets/gear.png");

console.log gear_ic

# device = new Framer.DeviceView();

# device.setupContext();
# device.deviceType = "google-nexus-6p";
# device.contentScale = 1;

# deviceHeight = device.screen.height
# deviceWidth = device.screen.width

# print "Device height: #{deviceHeight}"
# print "Device height: #{deviceWidth}"

# Set background
bg = new BackgroundLayer
  backgroundColor: "#65be9a"

# Create PageComponent
page = new PageComponent
  width: Screen.width
  height: Screen.height*0.8
  scrollVertical: false
  borderRadius: 3
  x: Align.center()
  y: Align.top(Screen.height*0.1)

figure = new Layer
  backgroundColor: "white"
  borderRadius: 10
  x: Align.left(30)
  y: Align.top(30)
  width: 70
  height: 70

inner_figure = new Layer
  superLayer: figure
  backgroundColor: "#65be9a"
  width: 50
  height: 50
  borderRadius: 8
  image: gear_ic

inner_figure.center()

figure.states.add
  second:
    rotation: 180

figure.states.animationOptions = 
  time: 0.3

title = new Layer
  backgroundColor: "transparent"
  x: Align.right(-30)
  y: Align.top(50)
  width: 270
  height: 50
  html: "<h2 style='font-size:2em; color: white; text-align:left;''>Test Page</h2>"

# Array that will store our layers
allIndicators = []  
amount = 5

# Create layers in a for-loop
for i in [0...amount]
  layer = new Layer
    superLayer: page.content
    width: Screen.width*0.8
    height: Screen.height
    backgroundColor: if (i % 2 == 0) then "#fff" else "#0CE8C2"
    borderRadius: 3
    opacity: 0.4
    x: (Screen.width*0.8) * i

  label = new Layer
    name: "label"
    height: 30
    width: 300
    y: Align.center
    x: Align.center
    superLayer: layer
    backgroundColor: 'transparent'
    html: "<p style='font-size:10em; color: #{if (i % 2 != 0) then "#fff" else "#bfbfbf"}; text-align: center;''>" + (i+1) + "</p>"

    indicator = new Layer 
      backgroundColor: "#fff"
      width: 16, 
      height: 16
      x: 28 * i, 
      y: Screen.height*0.96
      borderRadius: 16, 
      opacity: 0.2
      
    # Stay centered regardless of the amount of cards
    indicator.x += (Screen.width / 2) - (12 * amount)
    
    # States
    indicator.states.add(active: {opacity: 1, scale:1.3})
    indicator.states.animationOptions = time: 0.5
    
    # Store indicators in our array
    allIndicators.push(indicator)

# Staging
page.snapToNextPage()
page.currentPage.opacity = 1

current = page.horizontalPageIndex(page.currentPage)
allIndicators[current].states.switch("active")

# Update pages
page.on "change:currentPage", ->
  indicator.states.switch("default") for indicator in allIndicators
  
  current = page.horizontalPageIndex(page.currentPage)
  allIndicators[current].states.switch("active")

  page.previousPage.animate
    properties:
      opacity: 0.25
    time: 0.3

  figure.states.next()

  page.currentPage.animate
    properties:
      opacity: 1
    time: 0.3