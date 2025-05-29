
# Circular Buffer

This project implements a **parameterized Circular FIFO Buffer** in Verilog with support for both parallel and synchronous read/write operations. Designed in the context of hardware accelerators like **Eyeriss**, it focuses on efficient data buffering for parallel processing in CNN-based architectures.

## Project Objectives

- Gain practical experience with handshake-based FIFO buffer design.
- Implement a circular memory structure that supports simultaneous read/write with depth management.
- Integrate the buffer into systems requiring continuous high-speed data exchange without stalling.

## Background

The buffer simulates dataflow in **Convolutional Neural Networks (CNNs)** and their hardware accelerators. Such architectures require local data reuse, minimal memory movement, and fast parallel access — exactly what circular buffers enable.

The project was inspired by memory and control designs used in **Eyeriss**, a hardware accelerator tailored for deep learning applications on resource-constrained platforms like FPGAs and mobile SoCs.

## Buffer Types Implemented

1. **Basic FIFO Buffer**  
   - Supports sequential read and write.
   - Implements RAM with address-based control.
   - Includes signals for `full`, `empty`, `write_en`, and `read_en`.

2. **Circular FIFO Buffer**  
   - Implements pointer-based circular indexing.
   - Supports simultaneous read and write operations.
   - Wraps around when end of memory is reached.

## Key Features

- Fully parameterized for:
  - Buffer depth and data width
  - Parallel read/write size (`PAR_READ`, `PAR_WRITE`)
- Handshake logic using `valid` and `ready` signals
- Memory-mapped structure using addressable RAM
- Overflow/underflow protection and signal generation

## ⚙️ Signals Overview

| Signal      | Description                              |
|-------------|------------------------------------------|
| `clk`       | System clock (positive edge triggered)   |
| `reset`     | Resets all registers and state machines  |
| `write_en`  | Enables write to buffer                  |
| `read_en`   | Enables read from buffer                 |
| `full`      | Indicates buffer is full                 |
| `empty`     | Indicates buffer is empty                |
| `valid`     | Output data is valid                     |
| `ready`     | Buffer is ready to accept input          |

## 🏁 Final Notes

- Design follows a modular approach using `datapath` and `controller`.
- Buffer is suitable for real-time and pipelined hardware systems.
- Developed and tested using **ModelSim**.

---

> Developed for the **Computer Aided Design** course – Fall 2024  
> University of Tehran | Department of Electrical and Computer Engineering  