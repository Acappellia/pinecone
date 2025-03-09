execute if entity @s[tag=pinecone_transfer] run return run function pinecone:private/transfer/interact

execute if entity @s[tag=pinecone_seat] run function pinecone:private/interact/sit/sit
execute if entity @s[tag=pinecone_shake] on vehicle on passengers as @s[type=item_display] run function pinecone:private/interact/shake/shake