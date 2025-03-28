# A LNS-based Square Root Computation
***Made by deLini1612 as a part of ICS project***

---
# Results

Synthesis using **Quartus** and board **5CGXFC7C7F23C8** (Cyclone V Family), with **110ns** clock period (same as the combinational architecture in ADE project to compare).

I synthesis 8 architecture with different Input width and the number of segment we used for correction terms.

The last row is the result of combinational architecture (a3) in the [ADE project](https://github.com/deLini1612/Square_root_computing) to compute the square root   

| **IN_WIDTH** | **NUM_SEGMENT** | **ALMs**   | **Register** | **Max Frequency** | **Max relative error** | **Mean relative error** | **RMS relative error** | **Std relative error** |
|:------------:|:---------------:|:----------:|:------------:|:-----------------:|:----------------------:|:-----------------------:|:----------------------:|:----------------------:|
|      64      |        8        |    397     |      123     |     31.46 MHz     |                        |                         |                        |                        |
|      32      |        8        |    173     |      56      |     41.03 MHz     | 0.000639101115967491   |                         | 0.003445562087835243   |                        |
|      16      |        8        |    78      |      27      |     56.59 MHz     | 0.003518591652798224   |                         | 0.009181484925181359   |                        |
|       8      |        8        |    33      |      12      |     86.84 MHz     |0.0599048412524975      |                         |  0.09844854654547804   |                        |
|      64      |        16       |    423     |      108     |     31.49 MHz     |                        |                         |                        |                        |
|      32      |        16       |    186     |      59      |     42.48 MHz     |0.0006513585274076803   |                         | 0.003445562087835243   |                        |
|      16      |        16       |    82      |      26      |     49.33 MHz     | 0.003513636456835285   |                         |   0.008977195407614253 |                        |
|       8      |        16       |    36      |      14      |     85.03 MHz     |0.06027968342421467     |                         | 0.09841214743820413    |                        |
|   **_64_**   |    **_None_**   | **_1352_** |   **_111_**  |  **_10.07 MHz_**  |      NA                |                         |                        |                        |
