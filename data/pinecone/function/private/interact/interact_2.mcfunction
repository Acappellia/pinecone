#check cd
execute unless score @s pinecone_place_cd matches 0.. run return -1

##check sneak_place
execute if predicate pinecone:is_sneaking if predicate pinecone:is_holding_furniture if entity @s[gamemode=!adventure] run return run function pinecone:private/place/use_fur

##get sneak status
scoreboard players reset #player_sneak pinecone
execute if predicate pinecone:is_sneaking run scoreboard players set #player_sneak pinecone 1

#add cd
scoreboard players set @s pinecone_place_cd -4

##check dye
execute if predicate pinecone:is_holding_brush if entity @s[gamemode=!adventure] run return run function pinecone:private/dye/dye

##interact
tag @s add fur_user
execute as @e[distance=..5,type=interaction,tag=interact_target,tag=pinecone_fur,limit=1] at @s run function pinecone:private/interact/use
tag @s remove fur_user