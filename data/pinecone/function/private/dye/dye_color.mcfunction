#change color
execute on vehicle run data modify entity @s item.components."minecraft:dyed_color" set from storage pinecone:tmp dyed_color

#effect
playsound item.brush.brushing.sand.complete block @a ~ ~ ~ 1 1
particle wax_on ~ ~ ~ 0.3 0.3 0.3 0 5