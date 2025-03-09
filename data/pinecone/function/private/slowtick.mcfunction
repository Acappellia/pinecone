execute as @e[type=item_display,tag=pinecone_display,tag=pinecone_rotate_left] at @s run function pinecone:private/auto/rotate_left
execute as @e[type=item_display,tag=pinecone_display,tag=pinecone_rotate_right] at @s run function pinecone:private/auto/rotate_right

schedule function pinecone:private/slowtick 20t replace