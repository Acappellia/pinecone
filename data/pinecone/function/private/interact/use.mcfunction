execute if entity @s[tag=pinecone_transfer] run return run function pinecone:private/transfer/interact

execute if entity @s[tag=pinecone_seat] run tellraw @a "seat"
execute if entity @s[tag=pinecone_shake] run tellraw @a "shake"