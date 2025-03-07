advancement revoke @s only pinecone:interact

#add tag
execute as @e[distance=..5,type=interaction,tag=pinecone_fur] if data entity @s interaction run tag @s add interact_target

#continue
function pinecone:private/interact/interact_2

#remove tag
execute as @e[distance=..5,type=interaction,tag=pinecone_fur] run function pinecone:private/interact/interact_remove_tag