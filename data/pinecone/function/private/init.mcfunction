forceload add 1600 1600

scoreboard objectives add pinecone dummy
scoreboard players set #10 pinecone 10
scoreboard players set #12 pinecone 12
scoreboard players set #2 pinecone 2
scoreboard players set #214748 pinecone 214748
scoreboard players set #-3648 pinecone -3648
scoreboard players set #10000 pinecone 10000

scoreboard objectives add pinecone_place_cd minecraft.custom:time_since_death
scoreboard objectives add pinecone_seat_height_cm dummy
scoreboard objectives add pinecone_vrotate_status dummy

function pinecone:debug_init_data

schedule function pinecone:private/slowtick 20t replace