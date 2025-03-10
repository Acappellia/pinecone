# set item
data modify entity @s item set from storage pinecone:tmp transfer_target_fur_data.item_data

# init display
data merge entity @s {transformation:[-2,0,0,0,0,0,2,0,0,2,0,0,0,0,0,4],view_range:0.5,item_display:"fixed",teleport_duration:20}

# add tag
tag @s add pinecone_display
tag @s remove pinecone_rotate_left
tag @s remove pinecone_rotate_right
execute if data storage pinecone:tmp transfer_target_fur_data.auto{rotate_left:1b} run tag @s add pinecone_rotate_left
execute if data storage pinecone:tmp transfer_target_fur_data.auto{rotate_right:1b} run tag @s add pinecone_rotate_right