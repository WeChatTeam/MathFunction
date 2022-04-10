# Some MathFunction in Verilog
## 概述  
这里面用`veilog`实现了一些数学算法，因为***Xilinx***的IP核接口是***AXI4***的没办法，我只好自己重写。  

---

## 目前进展(2022.4.10)
- 旋转模式的**CORDIC**算法，采用流水线描述。  
  
---
  
## 文件结构
`cordic_trig`：各种**CORDIC**算法。  

---

## 时序说明
`cordic_trig`

---

## 备注
使用**CORDIC**算法时，用到了我自己写的[标准D触发器](https://github.com/WeChatTeam/StandardDFF.git)。