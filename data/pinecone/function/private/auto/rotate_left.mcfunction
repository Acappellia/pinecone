scoreboard players add @s pinecone_rotate_status 1

execute if score @s pinecone_rotate_status matches 8.. run scoreboard players set @s pinecone_rotate_status 0

function pinecone:private/auto/rotate_trans