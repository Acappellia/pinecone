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
    - 支持不同亮度的光源
    - 椅子能做
    - 小家具能晃动
    - 支持家具间的模型转换
    - 支持简单的家具动画（自旋转）
- （尽可能）简单的家具功能配置（通过表格配置）
- 简单的指令操作
    - 获取家具
    - 获取工具/刷子
- 多家具包支持
    - 完全抛弃数字id，使用模型的名称作为家具id

## 储存架构(nbt format)

```
pinecone:fur_data:{
    fur_id:{
        transfer:{
            target:"target_id",
            require_tool:1b
        },
        placement:{
            align_block:1b,
            arb_rotation:1b,
            offset:[0.0,0.0,0.0],
            bounding_box:[1.0f,0.5f],
            barrier:[
                [0,0,0],
                [0,1,0]
            ],
            light:[
                {
                    pos:[0,2,0],
                    level:15
                }
            ],
            air:[
                [0,3,0]
            ]
            item_data:{
                id:"minecraft:leather_horse_armor",
                count:1,
                components:{
                    item_model:"fur_id"
                }
            }
        },
        interaction:{
            is_seat:1b,
            seat_height:0.5,
            is_shake:1b
        },
        auto:{
            rotate_left:1b,
            rotate_right:1b
        }
    },
    fur_id_2:{
        ...
    },
    ...
}
```

## 主要逻辑(pseudocode)

```
void place_furniture :{
    get fur_id;
    get properties from storage;
    ray_cast;
    move_pos to target;
    if align_block:{
        align to block;
        apply offset;
        if has_barrier || has_light:{
            for block in barrier_list:{
                move_pos to block;
                if block is replaceable:{
                    place barrier;
                }
            }
            for block in light_list:{
                move_pos to block;
                if block is replaceable:{
                    place light;
                }
            }
        }
        place_furniture;
    }
    else:{
        place_furniture;
    }
}
```

```
void place_furniture:{
    check player rotation, copy to storage;
    summon interaction with width and height;
    if has_interaction:{
        tag interaction add interact;
    }
    if has_auto:{
        tag interaction add auto;
    }
    summon item_display;
    init transformation;
    copy item_data to item_display;
    copy dyed_color to item_display;
    ride item_display on interaction;
}
```

```
void remove_furniture:{
    get fur_id;
    get properties from storage;
    if has_barrier || has_light:{
        for block in barrier_list:{
            move_pos to block;
            if block is replaceable:{
                remove barrier;
            }
        }
        for block in light_list:{
            move_pos to block;
            if block is replaceable:{
                remove light;
            }
        }
    }
    summon item;
    kill entities;
}
```

```
void transfer_furniture:{
    get fur_id;
    get properties;
    get transfer target id;
    get target proterties;
    update interaction tag;
    update item_display model;
    update blocks;
}
```

## Tag

家具intearction pinecone_fur
家具item_display pinecone_display
家具base pinecone_base

interaction-座椅 pinecone_seat
interaction-晃动 pinecone_shake
interaction-转换 pinecone_transfer

item_display-左转动 pinecone_rotate_left
item_display-右转动 pinecone_rotate_right