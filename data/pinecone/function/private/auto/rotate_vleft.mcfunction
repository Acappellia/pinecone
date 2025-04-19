scoreboard players add @s pinecone_vrotate_status 1

execute if score @s pinecone_vrotate_status matches 8.. run scoreboard players set @s pinecone_vrotate_status 0

function pinecone:private/auto/vrotate_trans