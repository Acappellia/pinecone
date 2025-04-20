scoreboard players add #furniture_tick pinecone 1
execute if score #furniture_tick pinecone matches 101.. run scoreboard players set #furniture_tick pinecone 1

execute as @a at @s run function pinecone:private/auto/tick_furniture

schedule function pinecone:private/slowtick 20t replace