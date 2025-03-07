#check gamemode and tool
scoreboard players set #check_tool pinecone 0
execute if entity @s[gamemode=!creative] unless predicate pinecone:is_holding_tool run scoreboard players set #check_tool pinecone 1
execute if score #check_tool pinecone matches 1 run return run tellraw @s [{"text": "[","color": "white"},{"text": "Pinecone","color": "#22aaff"},{"text": "]","color": "white"},{"text": " 使用正确的工具 取下家具","color": "gray"}]

##determine if the point exists
tag @s add fur_destroyer
execute as @e[distance=..5,type=interaction,tag=interact_target,tag=pinecone_fur,limit=1] at @s run function pinecone:private/break/remove
tag @s remove fur_destroyer