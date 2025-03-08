#get dye color
data modify storage pinecone:tmp dyed_color set from entity @s SelectedItem.components."minecraft:dyed_color"

#dye color
execute as @e[distance=..5,type=interaction,tag=interact_target,tag=pinecone_fur,limit=1] at @s run function pinecone:private/dye/dye_color