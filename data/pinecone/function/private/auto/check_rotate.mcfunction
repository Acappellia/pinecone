#check dupe tick
execute if score @s pinecone_furnitur_tick = #furniture_tick pinecone run return -1
scoreboard players operation @s pinecone_furnitur_tick = #furniture_tick pinecone

#check tag
execute if entity @s[tag=pinecone_rotate_left] at @s run return run function pinecone:private/auto/rotate_left
execute if entity @s[tag=pinecone_rotate_right] at @s run return run function pinecone:private/auto/rotate_right

execute if entity @s[tag=pinecone_rotate_vleft] at @s run return run function pinecone:private/auto/rotate_vleft
execute if entity @s[tag=pinecone_rotate_vright] at @s run return run function pinecone:private/auto/rotate_vright