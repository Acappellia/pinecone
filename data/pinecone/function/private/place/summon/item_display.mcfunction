# set item
data modify entity @s item set from storage pinecone:tmp place_fur_data.item_data

# set color
execute if data storage pinecone:tmp dyed_color run data modify entity @s item.components."minecraft:dyed_color" set from storage pinecone:tmp dyed_color

# set rotation
execute store result entity @s Rotation[0] float 1 run data get storage pinecone:tmp place_info.rotation

# init display
data merge entity @s {transformation:[-2,0,0,0,0,0,2,0,0,2,0,0,0,0,0,4],view_range:0.5,item_display:"fixed",teleport_duration:20}

# add tag
tag @s add pinecone_display
tag @s add pinecone_fur_base_new
execute if data storage pinecone:tmp place_fur_data.auto{rotate_left:1b} run tag @s add pinecone_rotate_left
execute if data storage pinecone:tmp place_fur_data.auto{rotate_right:1b} run tag @s add pinecone_rotate_right
execute if data storage pinecone:tmp place_fur_data.auto{rotate_vleft:1b} run tag @s add pinecone_rotate_vleft
execute if data storage pinecone:tmp place_fur_data.auto{rotate_vright:1b} run tag @s add pinecone_rotate_vright