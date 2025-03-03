# Pinecone | 松果核 家具框架

Minecraft Java 1.21.4+

（努力成为）简洁易用的家具生成框架

## 功能

- 根据模型一键导出家具资源包、数据包
- 支持的家具功能：
    - 放置、破坏
    - 染色
    - 自由放置，自由旋转；或对齐方块坐标，四向旋转
    - 支持多方块的碰撞体积
    - 椅子能做
    - 小家具能晃动
    - 支持家具间的模型转换
    - 支持简单的家具动画（自旋转）
- （尽可能）简单的家具功能配置（通过表格配置）
- 简单的指令操作
    - 获取家具
    - 获取工具/刷子
- 多家具包支持
    - 完全抛弃数字id，使用自定义的名称作为家具id
    - 家具id与模型名称相同

## 储存架构(nbt format)

pinecone:fur_data:{
    fur_id:{
        transfer_to:"target_fur_id"
        placement:{
            align_block:1b,
            arb_rotation:1b,
            total_offset:[0.0f,0.0f,0.0f]
            bounding_box:[1.0f,0.5f]
            barrier:[
                [0,0,0],
                [0,1,0]
            ],
            item_data:{
                id:"minecraft:firework_star",
                count:1,
                components:{
                    item_model:"fur_id"
                }
            }
        },
        interaction:{
            is_seat:1b,
            seat_height:0.5f
            is_shake:1b
        },
        auto:{
            rotation_left:1b,
            rotation_right:1b
        }
    },
    fur_id_2:{
        ...
    },
    ...
}