#init data
data remove storage pinecone:tmp place_info
data remove storage pinecone:tmp mainhand
data remove storage pinecone:tmp offhand

#copy from hands
data modify storage pinecone:tmp mainhand set from entity @s SelectedItem
data modify storage pinecone:tmp offhand set from entity @s Inventory[{Slot:-106b}]

#check which hand
execute if data storage pinecone:tmp offhand.components."minecraft:custom_data".pinecone_fur run data modify storage pinecone:tmp place_info.hand set value "offhand"
execute if data storage pinecone:tmp mainhand.components."minecraft:custom_data".pinecone_fur run data modify storage pinecone:tmp place_info.hand set value "mainhand"

#copy hand data
function pinecone:private/place/copy_hand_data with storage pinecone:tmp place_info

#copy furniture id
data modify storage pinecone:tmp place_info.id set from storage pinecone:tmp hand_item.components."minecraft:item_model"

#copy dyed color
data remove storage pinecone:tmp dyed_color
data modify storage pinecone:tmp dyed_color set from storage pinecone:tmp hand_item.components."minecraft:dyed_color"

#copy furniture data
function pinecone:private/place/copy_fur_data with storage pinecone:tmp place_info

#if not align_block summon
execute unless data storage pinecone:tmp place_fur_data.placement{align_block:1b} run return run execute summon marker run function pinecone:private/place/snap_to_block

#if align_block check block

#get player rotation
function pinecone:private/place/get_rotation_4

#get offset
data merge storage pinecone:tmp {place_info:{offsetX:0.0,offsetY:0.0,offsetZ:0.0}}
data modify storage pinecone:tmp place_info.offsetX set from storage pinecone:tmp place_fur_data.placement.offset[0]
data modify storage pinecone:tmp place_info.offsetY set from storage pinecone:tmp place_fur_data.placement.offset[1]
data modify storage pinecone:tmp place_info.offsetZ set from storage pinecone:tmp place_fur_data.placement.offset[2]

#apply offset
function pinecone:private/place/apply_offset with storage pinecone:tmp place_info