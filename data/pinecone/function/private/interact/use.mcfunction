execute if entity @s[tag=pinecone_seat] unless score #player_sneak pinecone matches 1 run function pinecone:private/interact/sit/sit
execute if entity @s[tag=pinecone_shake] on vehicle run function pinecone:private/interact/shake/shake

execute if entity @s[tag=pinecone_transfer] run function pinecone:private/transfer/interact