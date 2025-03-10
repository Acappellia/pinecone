# Pinecone | 松果核 家具框架

Minecraft Java 1.21.4+

（努力成为）简洁易用的家具生成框架

## 功能

- 根据模型一键导出家具资源包、数据包的统一包
- 支持的家具功能：
    - 放置、破坏
    - 染色
    - 支持自由放置或对齐方块坐标
    - 支持多方块的碰撞体积
    - 支持不同亮度的光源
    - 椅子能坐
    - 支持家具间的模型转换
    - 一些简单的动画效果
- 通过表格简单配置家具功能
- 简单的指令操作
    - 获取家具
    - 获取工具/刷子
- 多家具包支持
    - 完全抛弃数字id，使用模型的名称作为家具id

## 使用方法

- 下载压缩包或克隆本仓库
- 在blockbench导出材质模型与贴图，放置在同目录下的 `models_to_add/` 路径下
    - 无需保证相对路径正确，但需要保证每个模型都指向了对应的贴图
    - `models_to_add/` 路径下可以是任意文件结构，可以把所有的 `.json` 和 `.png`
    - 无关文件不需要放在这个路径下
- 按照后面的要求格式编辑 `furniture_import_sheet.csv` 文件
    - 文件需要保存为 UTF-8 格式
- 运行 `generate_pack.py`
    - 按照提示输入家具包名称
- 家具包生成后会自动打包为 `generated_pack.zip`
    - 如果需要修改，可以直接修改目录下的内容后，然后将 `data/`，`assets/`，`pack.mcmeta`，`pack.png` 手动打包

## 家具生成表

表格提供了一些示例，按照示例格式填写即可
填写时请删除示例数据
TBD

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

## 导出脚本功能

```
read import_sheet.csv;
read pack name from input;
copy all picture to dest;
for each furniture in csv:
    change dir in .json model;
    copy .json model to dest;
    create recipe;
    record recipe in advancement;
    record furniture data in mcfunction;
generate datapack namespace;
generage pack.mcmeta;
make zip;
```