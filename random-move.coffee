canvas = document.createElement 'canvas'
canvasWidth = canvas.width = 500
canvasHeight = canvas.height = 500
ctx = canvas.getContext '2d' 

document.body.style.background = 'black'
document.body.appendChild canvas

#add a timer function, it should 
#return truthy if it wants to keep running...
$.fx.timer ->
  ctx.clearRect(0, 0, canvasWidth, canvasHeight)
  true
    
rand = (max) ->
  return 0|Math.random() * max
  
#Thing Constructor, initial x and y position
class Thing
  constructor: (@x, @y) ->
    @width = 6
    @height = 6
    @color = "rgb(#{[rand(255),rand(255),rand(255)]})"
    
  #Animate to a new position and size
  go: ->
    dim = rand 20
    #use jQuery.Animation() for the promisy goodness
    opts =
      x: rand canvasWidth
      y: rand canvasHeight
      width: dim
      height: dim
    
    anim = $.Animation this,  opts, { duration: 2000 + rand 1000 }
    
    #call draw after we finish each frame of the animations
    anim.progress this.draw

    #call go after we finish each animation
    anim.done this.go
    
  #draw this thing
  draw: ->
    ctx.fillStyle = @color;
    ctx.fillRect(@x, @y, @width, @height);
        
#create 200 things and go
for i in [1..200]
  t = new Thing rand(canvasWidth), rand(canvasHeight)
  t.go()









