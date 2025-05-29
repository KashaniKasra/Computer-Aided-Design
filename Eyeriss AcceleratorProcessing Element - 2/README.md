# Eyeriss Accelerator – Extended Processing Element (PE) Architecture

This project builds upon a basic PE structure inspired by the **Eyeriss CNN accelerator**, extending it with advanced memory, control, and operational logic to support more flexible convolutional modes. It is the second phase of a hardware accelerator design project, focused on simulating pipelined processing and dynamic mode control.

## Goals

- Complete the design of a fully functional **Processing Element (PE)** with memory and control logic.
- Enable support for **multiple convolutional modes**, including:
  - Shared filters with same input
  - Shared input with different filters
  - Shared channels with different data
- Simulate **multi-step convolution accumulation** (Psum management).

## Architectural Enhancements

- **ScratchPad Memory** (Psum) for partial sums
- **Read & Write Controllers**:
  - Manage IFMap and Filter data flow
  - Handle data output after computation
- **Address Generator**:
  - Controls stride and convolution windowing
- **Main Controller**:
  - Coordinates PE mode
  - Enables flexible computation scenarios
  - Ensures synchronization with global buffers
- **Datapath**:
  - Multiply-accumulate logic in a two-stage pipeline
  - Modular and bit-width parameterized design

## Operation Modes

The PE can operate in three distinct convolutional settings:
1. **Same Input, Different Filters** – to parallelize across kernels
2. **Same Filter, Different Inputs** – for batch or spatial parallelism
3. **Different Channels** – for feature map fusion

Each mode is determined by a `mode` signal, and changes the address generation and memory control logic accordingly.

## Simulation & Validation

- Simulated using **ModelSim**
- All modules designed for reuse and parameterization
- Supports multi-Psum accumulation and zero-buffer initialization
- Testbenches handle various stride and filter combinations

> Course: Computer Aided Design – Fall 2024  
> Department of Electrical & Computer Engineering – University of Tehran