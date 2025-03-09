advancement revoke @s only pinecone:use_brush

#check & add cd
execute unless score @s pinecone_place_cd matches 0.. run return -1
scoreboard players set @s pinecone_place_cd -3

#get brush color
execute store result score #brush_current_color pinecone run data get entity @s SelectedItem.components."minecraft:custom_data".pinecone_brush_color

#set next color
scoreboard players add #brush_current_color pinecone 1
execute if score #brush_current_color pinecone matches 32.. run scoreboard players set #brush_current_color pinecone 0
execute store result storage pinecone:tmp brush_info.color int 1 run scoreboard players get #brush_current_color pinecone
function pinecone:private/brush/set_color with storage pinecone:tmp brush_info

#playsound
playsound block.copper_bulb.turn_on player @s ~ ~ ~ 1 1.2