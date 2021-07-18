---
title: ubuntu中vscode的C/C++环境配置
comments: false
top: false
date: 2021-01-23 16:01:56
tags: [ubuntu]
categories: 
	- [教程,ubuntu配置]
headimg: https://gitee.com/Langwenchong/figure-bed/raw/master/20210704153640.png
---

虽然devC++和codeBlock都已经配置好了c环境可以直接使用，但是我还是更青睐于VScode即使他需要自己配置环境，但是多学一个本领也不是坏事~，本篇文章只是记录一下ubuntu上vscode配置c/c++环境的过程😊

<!-- more -->

说起来也不太难，主要就是gcc+gdb安装以及Json文件的配置。下面是具体步骤照着执行即可配置完成：

首先我们需要先安装gcc和gdb，这里直接输入以下指令即可：

```
sudo apt-get install gcc
sudo apt-get install g++
sudo apt-get install gdb
```

上面中的gcc是用于编译c文件的，g++是编译c++文件的，最好全都安装，gdb是常用的一种debug程序，具体使用请参考指导文章。可能安装时需要输入密码，密码就是ubuntu账户的密码。

安装完成以后，我们现在新建一个文件夹我这里命名为了code，那么以后所有的C/C++文件都需要写在这个文件夹里才可以编译运行，然后我们用VScode打开这个文件夹。在这个code文件夹下新建一个文件夹命名为.vscode（一定注意前面有一个点）。然后在这个.vscode文件夹下新建两个json文件分别命名为launch.json和tasks.json。然后分别将以下两个代码复制到相对应的json文件中：

launch.json:

```c
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "C/C++",
            "type": "cppdbg",
            "request": "launch",
            "program": "${fileDirname}/${fileBasenameNoExtension}",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "preLaunchTask": "compile",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
    ]
}
```

tasks.json

```c
{
    "version": "2.0.0",
    "tasks": [{
            "label": "compile",
            "command": "g++",
            "args": [
                "-g",
                "${file}",
                "-o",
                "${fileDirname}/${fileBasenameNoExtension}"
            ],
            "problemMatcher": {
                "owner": "cpp",
                "fileLocation": [
                    "relative",
                    "${workspaceRoot}"
                ],
                "pattern": {
                    "regexp": "^(.*):(\\d+):(\\d+):\\s+(warning|error):\\s+(.*)$",
                    "file": 1,
                    "line": 2,
                    "column": 3,
                    "severity": 4,
                    "message": 5
                }
            },
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ]
}
```

安装完成以后我们点击vscode插件商店（红色圈中的按钮）：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210123161455.png)

然后搜索C/C++和coderunner插件，安装完成后，我们在code文件下新建一个c文件和.vscode同级进行编译测试，请讲一下代码复制到你自己新建的C文件中：

```c
#include <stdio.h>
#include <stdlib.h>
int main() {
    for (float y = 1.5f; y > -1.5f; y -= 0.1f) {
        for (float x = -1.5f; x < 1.5f; x += 0.05f) {
            float a = x * x + y * y - 1;
            putchar(a * a * a - x * x * y * y * y <= 0.0f ? '*' : ' ');
        }
        putchar('\n');
    }
    return 0;
}
```

那么现在我们的Code文件夹的结构应该如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210123162452.png)

也就是说以后所有的c文件都要放到code文件夹下与.vscode同级别的c文件。然后接下来我们进行编译运行，我们使用快捷键Ctrl+shift+B来进行编译，编译完成后应该会生成.exe文件例如a.c编译完成后生成a.exe，b.c编译完成后生成的b.exe。然后点击vscode右上角的小三角进行exe文件执行：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210123162804.png)

如果能够运行成功就会输出一颗大💗，那么本次文章分享就结束啦。