forceload add 1600 1600

scoreboard objectives add pinecone dummy

scoreboard objectives add pinecone_place_cd minecraft.custom:time_since_death
scoreboard objectives add pinecone_seat_height_cm dummy
scoreboard objectives add pinecone_rotate_status dummy
scoreboard objectives add pinecone_furnitur_tick dummy

schedule function pinecone:private/slowtick 20t replace