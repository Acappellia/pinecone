advancement revoke @s only pinecone:break

#add tag
execute as @e[distance=..5,type=interaction,tag=pinecone_fur] if data entity @s attack run tag @s add interact_target

#continue
function pinecone:private/break/break_2

#remove tag
execute as @e[distance=..5,type=interaction,tag=pinecone_fur] run function pinecone:private/break/break_remove_tag