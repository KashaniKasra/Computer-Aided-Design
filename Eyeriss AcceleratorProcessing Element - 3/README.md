# Eyeriss Accelerator – PE Array Design (Final Phase)

This project completes the final phase of a multi-stage effort to design a **Processing Element (PE) array** inspired by the Eyeriss deep learning accelerator. It focuses on connecting multiple PEs in a row to perform a full 1D convolution operation in parallel, demonstrating data reuse, pipelined execution, and buffer communication using shared ScratchPad memory and global memory buffers.

## Project Goal

Design and implement a scalable array of `N` PEs (parameterized), each capable of:
- Receiving its own input row (IFMap) and filter row
- Performing 1D convolution independently and simultaneously
- Passing accumulated results through psum buffers to neighboring PEs
- Writing the final accumulated results to a shared Global Buffer (16KB SRAM)

## Architecture Summary

- Each PE performs a convolution on a row of input and filter data.
- PEs are connected in a chain:
  - psum of one PE is passed to the next for accumulation.
  - The last PE outputs the final result.
- PEs are controlled to ensure synchronized start and output.

### ⬇Inputs and Flow
- Input (IFMap) and Filter data are preloaded into a 16KB Global Buffer.
- The system loads these into the ScratchPad memory of each PE.
- All PEs start simultaneously, using their internal controller and datapath.

### ⬆Outputs
- The final PE writes output results to the upper 16KB of Global Buffer.

## Components

- `SRAM` module: 32KB total (divided into 16KB input, 16KB output)
- `PE` modules: Parameterized and modular
- `Address Generator`: To fetch correct slices of IFMap and Filter
- `Main Controller`: Synchronizes multiple PE instances
- `Zero Buffer`: Used to initialize and propagate psum values
- `Top Module`: Instantiates the full row of PEs and connects buffers

## Simulation and Validation

- Simulation done via **ModelSim**
- Testbench initializes Global Buffer and activates processing pipeline
- Five comprehensive test cases executed using `sim_top.tcl`
- Correctness validated via end-to-end output comparison

## Notes

- Fully parameterized for number of PEs (`N`)
- All PE operations follow the three convolution modes as in prior phases
- Project submitted with clean HDL code, proper modularity, and tested functionality

---

> Course: Computer Aided Design – Winter 1403  
> University of Tehran – School of Electrical & Computer Engineering