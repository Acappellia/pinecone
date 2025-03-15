data modify entity @s teleport_duration set value 20
#execute on vehicle run tag @s add pinecone_fur_base_record
tp @s ~ ~ ~ ~45 ~
ride @s mount @n[type=item_display,distance=..1,tag=pinecone_fur_base_record]
#execute on vehicle run tag @s remove pinecone_fur_base_record