# Pinecone | 松果核 家具框架

![pinecone-logo.png](https://s2.loli.net/2025/03/11/mZ47VIS5LtuEUeF.png)

**当前版本 b0.1 Minecraft Java 1.21.4**

## 简介

简洁易用的家具生成框架，面向零数据包基础的模型作者，提供了从java模型到原版游戏内家具的一键打包工具。

导出的家具包可以直接添加到游戏，在生存或创造使用进行建筑装饰。也可以同时安装多个家具包，自由搭配。

框架将为每个未来的 Minecraft Java 正式版提供更新。模型作者如需要更新家具包，可使用新版本的框架再次导出。

## 功能

- 根据模型一键导出家具资源包+数据包的二合一包
- 支持的家具功能：
    - 放置、破坏、染色
    - 使用切石机合成家具
    - 支持自由放置或对齐方块坐标
    - 支持多方块的碰撞体积
    - 支持不同亮度的光源
    - 支持家具间的模型转换
    - 支持摇晃、旋转的简单动画效果
    - **椅子能坐**
- 通过表格即可简单配置家具
- 提供指令操作一键获取家具与颜料刷
- 多家具包支持
    - 使用模型的名称作为家具id
    - 使用相同的框架导出的不同家具包可以共同使用
    - 家具包可任意安装和卸载

## 框架使用方法

- 下载压缩包或克隆本仓库
- 在Blockbench或其他工具制作家具模型
    - 如需要染色支持，请在对应的模型面使用染色皮革的着色方法
- 导出`.json`模型与`.png`贴图，放置在`models_to_add/`路径下
    - 无需保证相对路径正确，但需要保证每个模型都指向了对应的贴图
    - `models_to_add/`路径下可以是任意文件结构，可以把所有的 `.json` 和 `.png` 简单的放置在这个目录
    - 无关文件不需要放在这个路径下
- 编辑家具配置表 `furniture_import_sheet.csv` 文件
    - 格式需要按照示例数据填写
    - 请参照后一小结的注意事项
    - 文件需要保存为 UTF-8 格式
- 运行 `generate_pack.py`
    - 按照提示输入家具包名称
- 家具包生成后会自动打包为 `pinecone-<pack_name>-1.21.4.zip`
    - 如果需要修改，可以直接修改目录下的内容，然后将 `data/`，`assets/`，`pack.mcmeta`，`pack.png`，`LICENCE` 手动打包

## 家具配置表

表格提供了一些示例，按照示例格式填写即可。注意事项：

- 填写后请删除已有的示例数据
- 家具id需要填写家具的模型名称，即`.json`文件名（不包含`.json`后缀）
- 家具id，家具名称不可省略
- 交互体积一列的填写格式为`[宽度,高度]`，两个值请统一保留小数点。如果留空则默认值为`[1.0,1.0]`
- 坐标的填写格式为`[x,y,z]`，三个坐标值请统一保留小数点，或统一为整数
- 屏障、光源、空气方块的配置，必须在对齐方块时才会生效
- 为了防止csv读取出错，最后一列占位符请不要空着
- 导出时目前不会进行csv填写格式检查，如果导出错误请检查是否填错，或者联系作者支持

TBD

## 家具包安装

将导出的家具包作为数据包添加到地图，并同时作为资源包添加到游戏即可。

## 游戏内使用

- `/function <pack_name>:give_all`
    - 获取 `<pack_name>` 家具包添加的所有家具
- 工作台合成颜料刷
    - 使用 刷子+任意染料+任意粘稠的液体/胶状物 合成
- 切石机制作家具
    - 根据配置时指定的配方合成

---

## 开发备注

### 储存架构(nbt format)

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

### 主要逻辑(pseudocode)

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

### 实体 Tag

- 家具intearction `pinecone_fur`
- 家具item_display `pinecone_display`
- 家具item_display_base `pinecone_base`

- interaction-座椅 `pinecone_seat`
- interaction-晃动 `pinecone_shake`
- interaction-转换 `pinecone_transfer`

- item_display-左转动 `pinecone_rotate_left`
- item_display-右转动 `pinecone_rotate_right`

### 导出脚本操作

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
