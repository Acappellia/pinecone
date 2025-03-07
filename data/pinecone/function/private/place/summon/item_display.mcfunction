# set item
data modify entity @s item set from storage pinecone:tmp place_fur_data.placement.item_data

# set rotation
execute store result entity @s Rotation[0] float 1 run data get storage pinecone:tmp place_info.rotation

# init display
data merge entity @s {transformation:[-2,0,0,0,0,0,2,0,0,2,0,0,0,0,0,4],view_range:0.5,item_display:"fixed",teleport_duration:20}

# add tag
tag @s add pinecone_display
execute if data storage pinecone:tmp place_fur_data.auto{rotate_left:1b} run tag @s add pinecone_rotate_left
execute if data storage pinecone:tmp place_fur_data.auto{rotate_right:1b} run tag @s add pinecone_rotate_right

# ride on base
ride @s mount @n[distance=..0.1,tag=pinecone_fur_base,type=item_display]