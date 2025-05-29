# Eyeriss-Inspired Accelerator – Processing Element Design

This project implements a **Processing Element (PE)** inspired by the Eyeriss accelerator architecture, designed to perform convolutional operations for deep neural networks. The PE simulates key functions such as data handshaking, memory access, and pipelined multiply-accumulate operations using Verilog modules.

## Project Goals

- Implement the core architecture of a PE used in Eyeriss: including input/output buffers, local memory, and arithmetic units.
- Perform **3D convolutional computations** with pipelined accumulation logic.
- Simulate memory hierarchy and data movement including **ScratchPad Memory**, buffer control, and synchronization.

## Architecture Overview

The PE receives:
- **IFMap (Input Feature Map)** and **Filter** matrices via local buffers.
- Internally stores partial results (Psum) and forwards them upon completion.

Key modules:
- `ScratchPad Memory` (Register-based and SRAM-based)
- `Read Controller` for IFMap and Filter movement
- `Write Controller` for storing computed Psum
- `Address Generator` for convolution indexing and stride
- `Main Controller` for pipeline start/stop and synchronization
- `Datapath` with multiplier and adder logic

## Simulation & Implementation

- RTL implemented in Verilog HDL
- Simulated using **ModelSim** with detailed testbenches
- Tested for stride and filter size flexibility
- Supports multi-cycle pipelined operation and dynamic input data

## Highlights

- Each module is parameterized to allow bit-width and size configuration.
- Modular design allows scaling to 12×14 Eyeriss-like array.
- All control and datapath modules are custom-written and fully testable.
- Emphasized **data reuse**, local storage, and minimal buffer stalls.

---

> Designed for Computer Aided Design – Fall 2024  
> Department of Computer Engineering – University of Tehran  