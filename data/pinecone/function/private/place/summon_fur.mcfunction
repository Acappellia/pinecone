#play sound
playsound block.chiseled_bookshelf.place block @a ~ ~ ~ 1 1

#get rotation
function pinecone:private/place/get_rotation

#summon interaction & item_display
execute summon item_display run function pinecone:private/place/summon/item_display_base
execute summon interaction run function pinecone:private/place/summon/interaction
execute summon item_display run function pinecone:private/place/summon/item_display
tag @n[type=item_display,distance=..1,tag=pinecone_fur_base_new] remove pinecone_fur_base_new

#remove hand item
function pinecone:private/place/remove_hand_item with storage pinecone:tmp place_info