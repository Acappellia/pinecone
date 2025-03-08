#width & height
data modify entity @s width set from storage pinecone:tmp transfer_target_fur_data.placement.bounding_box[0]
data modify entity @s height set from storage pinecone:tmp transfer_target_fur_data.placement.bounding_box[1]

#store seat height
scoreboard players set @s pinecone_seat_height_cm 50
execute store result score @s pinecone_seat_height_cm run data get storage pinecone:tmp transfer_target_fur_data.interaction.seat_height 100

#tag
tag @s add pinecone_fur
tag @s remove pinecone_transfer
tag @s remove pinecone_seat
tag @s remove pinecone_shake

execute if data storage pinecone:tmp transfer_target_fur_data.transfer.target run tag @s add pinecone_transfer
execute if data storage pinecone:tmp transfer_target_fur_data.interaction{is_seat:1b} run tag @s add pinecone_seat
execute if data storage pinecone:tmp transfer_target_fur_data.interaction{is_shake:1b} run tag @s add pinecone_shake
