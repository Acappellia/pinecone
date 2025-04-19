scoreboard players remove @s pinecone_vrotate_status 1

execute if score @s pinecone_vrotate_status matches ..-1 run scoreboard players set @s pinecone_vrotate_status 7

function pinecone:private/auto/vrotate_trans