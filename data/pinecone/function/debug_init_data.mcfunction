data modify storage pinecone:fur_data "minecraft:grass_block" set value {\
transfer:{},\
placement:{arb_rotation:1b,bounding_box:[0.25f,0.25f]},\
item_data:{id:"minecraft:leather_horse_armor",count:1,components:{item_model:"minecraft:grass_block",item_name:'"小草方块"'}},\
interaction:{is_seat:1b,seat_height:0.5,is_shake:1b},\
auto:{rotate_left:1b}}

data modify storage pinecone:fur_data "minecraft:dirt" set value {\
transfer:{},\
placement:{align_block:1b,offset:[1.0,0.0,0.0],bounding_box:[1.1f,2.5f],barrier:[[0,0,0],[0,1,0]],light:[{pos:[0,2,0],level:15}]},\
item_data:{id:"minecraft:leather_horse_armor",count:1,components:{item_model:"minecraft:dirt",item_name:'"大土方块"'}},\
interaction:{},\
auto:{}}

data modify storage pinecone:fur_data "minecraft:shroomlight" set value {\
transfer:{target:"minecraft:nether_wart_block",require_tool:1b},\
placement:{align_block:1b,arb_rotation:1b,bounding_box:[0.25f,0.25f],light:[{pos:[0,0,0],level:15}]},\
item_data:{id:"minecraft:leather_horse_armor",count:1,components:{item_model:"minecraft:shroomlight",item_name:'"菌光灯（开）"'}},\
interaction:{},\
auto:{rotate_right:1b}}

data modify storage pinecone:fur_data "minecraft:nether_wart_block" set value {\
transfer:{target:"minecraft:shroomlight"},\
placement:{align_block:1b,arb_rotation:1b,bounding_box:[0.25f,0.25f],light:[{pos:[0,0,0],level:0}]},\
item_data:{id:"minecraft:leather_horse_armor",count:1,components:{item_model:"minecraft:nether_wart_block",item_name:'"菌光灯（关）"'}},\
interaction:{},\
auto:{}}

data modify storage pinecone:fur_data "minecraft:leather_horse_armor" set value {\
transfer:{},\
placement:{arb_rotation:1b,bounding_box:[0.25f,0.25f]},\
item_data:{id:"minecraft:apple",count:1,components:{item_model:"minecraft:leather_horse_armor",item_name:'"染色测试"'}},\
interaction:{is_shake:1b},\
auto:{}}