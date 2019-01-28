# IOToolkit
 - 工具介绍
  采用c++ 编写 windows 环境下的输入输出控制工具
 - 愿景
  为主流IO设备提供统一的控制接口,免除日常开发中复杂的IO适配过程
- 存在形式
 以c++动态链接库的形式存在

# 特点
- IO设备无关的开发体验
- 较完整的事件模型机制
- 高灵活度的自定义配置
- 可拓展的插件开发
- 包含日志调试输出

# 安装&介绍

**0. 构建动态链接库**
[IOToolkit](https://github.com/MrBaoquan/IODevice/tree/v1.x.y/IOToolkit)为编译后的主二进制文件,[IOUI](https://github.com/MrBaoquan/IOUI/tree/master/v1.0.0/IOToolkit)为编译后的插件二进制文件
IOToolkit库本身适配了键盘鼠标/Joystick设备的开发接口，其他(如板卡)IO设备需要进行[插件开发](https://github.com/MrBaoquan/IOUI)以进行拓展
只需要将两部分IOToolkit合并，即为一个完整的IOToolkit开发库

**1. 配置隐式链接dll环境**
```
#include "IODeviceController.h"
#pragma comment(lib,"IODevice.lib")

/** 引用命名空间 */
using namespace dh = DevelopHelper;

```

**2. 编写配置文件**

```
<IORoot>
  <Device Name="Standard" Type="Standard">
      <Action Name="Jump">
          <Key Name="SpaceBar"></Key>
      </Action>

      <Axis Name="MoveLR">
          <Key Name="Left" Scale="-1"></Key>
          <Key Name="Right" Scale="1"></Key>
      </Axis>
  </Device>
  
  <Device Name="Joystick" Type="Joystick">
    <Action Name ="AnyKey">
      <Key Name ="AnyKey"></Key>
    </Action>

    <Axis Name="MoveLR">
      <Key Name="JS_X"></Key>
    </Axis>
  </Device>
  
  <Device Name="PCI2312A" Type="External" DllName="PCI2312A" Index="0"></Device>
</IORoot>

```

**3. 绑定所需事件**
```
void Start()
{
    /** 获取相关设备 */
    dh::IODevice& standardDevice = dh::IODeviceController::Instance().GetIODevice("Standard");
    
    /** 绑定 键盘设备 "Jump" 动作按下事件 */
    standardDevice.BindAction("Jump", dh::IE_Pressed, this, &YourClass::OnJump);

    /** 绑定 键盘设备 "MoveLR" 轴事件 */
    standardDevice.BindAxis("MoveLR", this, &YourClass::OnMoveLR);

    /** 绑定 Joystick 设备 "MoveLR" 轴事件 */
    standardDevice.BindAxisKey(dh::EKeys::JS_X, this, &YourClass::OnMoveLR);

    /** 绑定 Joystick 设备 "任意键" 按下事件 */
    standardDevice.BindAction("AnyKey", dh::IE_Pressed, this, &YourClass::OnKeyDown);

    /** 绑定 鼠标左键 双击事件 " */
    standardDevice.BindKey(dh::EKeys::LeftMouseButton, dh::IE_DoubleClick, this, &YourClass::OnLMBDoubleClick);

    /** 绑定 PCI2312A 设备 第 0 通道号 弹起事件 */
    dh::IODeviceController::Instance().GetIODevice("PCI2312A").
        BindKey(dh::EKeys::Button_00, dh::IE_Released, this, &YourClass::OnButton_00Released);
}
```

**4. 循环更新**
```
void Update()
{
    /** 循环调用Update函数更新设备内部状态，需要循环调用 */
	dh::IODeviceController::Instance().Update();
}
```

**5. 处理输入逻辑**
```
class YourClass
{
public:

void OnJump()
{
    // TODO: 跳跃逻辑
}
void OnMoveLR(float val)
{
    // TODO: 左右移动逻辑
}

void OnKeyDown(dh::FKey key)
{
    // key 按键 被按下
}

void OnLMBDoubleClick()
{
    // 鼠标左键双击
}

void OnButton_00Released()
{
    // PCI2312A 板卡第 0 个通道弹起
}

};
```

**6.其他方法**
更多相关操作接口，见[IODevice.h](https://github.com/MrBaoquan/IODevice/blob/v1.x.y/IODevice/Source/Public/IODevice.h)


