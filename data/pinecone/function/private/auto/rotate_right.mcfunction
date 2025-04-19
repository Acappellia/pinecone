scoreboard players remove @s pinecone_rotate_status 1

execute if score @s pinecone_rotate_status matches ..-1 run scoreboard players set @s pinecone_rotate_status 7

function pinecone:private/auto/rotate_trans