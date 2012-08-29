
something = []
totalCount = 50
canvas = document.createElement 'canvas'
canvasWidth = canvas.width = 500
canvasHeight = canvas.height = 500

width = canvasWidth / totalCount

ctx = canvas.getContext '2d'

document.body.style.background = 'black'
document.body.appendChild canvas


#add a timer function, it should return truthy if it wants to keep running...
$.fx.timer ->
  ctx.clearRect(0, 0, canvasWidth, canvasHeight)
  for o in something
    o.draw()  
  true

rand = (max) ->
  return 0 | Math.random() * max

class Thing
  constructor: (@i, @n) ->
    @color = "rgb(#{[rand(255), rand(255), rand(255)]})"
    @steps = []

  draw: ->
    ctx.fillStyle = @color
    ctx.fillRect @i * width, canvasHeight - @n, width, @n
    
  moveTo: (i)->
    @steps.push i

  go: ->
    if @steps.length > 0 
      i = @steps.shift()
      anim = $.Animation this, {i: i}, {duration: 200}
      anim.done this.go
        
for i in [0..totalCount - 1]
  something.push new Thing i, rand canvasWidth
  
swap = (a, i, j) ->
  x = a[i]
  a[i] = a[j]
  a[j] = x
  
  a[i].moveTo(i)
  a[j].moveTo(j)

partion = (a, start, end, pivotIndex) ->
  pivot = a[pivotIndex]
  swap a, pivotIndex, end
  p = start
  for i in [start..end - 1]
    if a[i].n < pivot.n
      swap a, p, i
      p += 1
  swap a, p, end
  return p

quicksort = (a, start, end) ->
  if end > start
    #use end as partion pivot index
    pivotIndex = partion a, start, end, end
    quicksort a, start, pivotIndex - 1
    quicksort a, pivotIndex + 1, end

quicksort something, 0, something.length - 1

for o in something
  o.go()