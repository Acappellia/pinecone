#playsound
playsound block.stone.break block @a ~ ~ ~ 1 1

#init data
data remove storage pinecone:tmp remove_info

#copy furniture id
execute on vehicle on passengers as @s[type=item_display] run data modify storage pinecone:tmp remove_info.id set from entity @s item.components."minecraft:item_model"

#copy furniture data
function pinecone:private/break/copy_fur_data with storage pinecone:tmp remove_info

#remove barrier
execute if data storage pinecone:tmp remove_fur_data.placement.barrier[0] run function pinecone:private/break/barrier/loop

#remove light
execute if data storage pinecone:tmp remove_fur_data.placement.light[0] run function pinecone:private/break/light/loop

#modify item data
data modify storage pinecone:tmp remove_fur_data.placement.item_data merge value {components:{"minecraft:custom_data":{pinecone_fur:1b},"minecraft:consumable":{animation:"none",consume_seconds:1000000,has_consume_particles:false}}}

#give item
setblock 1600 -64 1600 bedrock
setblock 1600 -64 1600 shulker_box{Items:[{Slot:0b,id:"minecraft:apple",count:1}]}
data modify block 1600 -64 1600 Items[0] merge from storage pinecone:tmp remove_fur_data.placement.item_data
loot spawn ~ ~ ~ mine 1600 -64 1600 stone[minecraft:custom_data={drop_contents:1}]
setblock 1600 -64 1600 bedrock

#kill self
execute on vehicle run function pinecone:private/break/kill