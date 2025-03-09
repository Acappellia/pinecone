#init data
data remove storage pinecone:tmp transfer_info

#copy furniture id
execute on vehicle on passengers as @s[type=item_display] run data modify storage pinecone:tmp transfer_info.origin_id set from entity @s item.components."minecraft:item_model"

#copy furniture data
function pinecone:private/transfer/copy_fur_data with storage pinecone:tmp transfer_info

#check tool
scoreboard players set #check_tool pinecone 0
execute if data storage pinecone:tmp transfer_origin_fur_data.transfer{require_tool:1b} as @p[tag=fur_user,distance=..6] unless predicate pinecone:is_holding_tool run scoreboard players set #check_tool pinecone 1
execute if score #check_tool pinecone matches 1 run return -1 
#tellraw @s [{"text": "> ","color": "#22aaff"},{"text": " 使用任意锄头切换家具","color": "gray"}]

#copy target id
data modify storage pinecone:tmp transfer_info.target_id set from storage pinecone:tmp transfer_origin_fur_data.transfer.target

#copy target data
function pinecone:private/transfer/copy_fur_data_target with storage pinecone:tmp transfer_info

#modify entities
function pinecone:private/transfer/modify/interaction
execute on vehicle on passengers as @s[type=item_display] run function pinecone:private/transfer/modify/item_display

#set barrier
execute if data storage pinecone:tmp transfer_target_fur_data.placement.barrier[0] run function pinecone:private/transfer/barrier/loop

#set light
execute if data storage pinecone:tmp transfer_target_fur_data.placement.light[0] run function pinecone:private/transfer/light/loop

#set air
execute if data storage pinecone:tmp transfer_target_fur_data.placement.air[0] run function pinecone:private/transfer/air/loop

#particle
playsound block.chiseled_bookshelf.insert block @a ~ ~ ~ 1 1
particle crit ~ ~0.1 ~ 0.2 0.2 0.2 0.1 5