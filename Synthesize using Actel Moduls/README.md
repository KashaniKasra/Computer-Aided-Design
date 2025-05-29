# Synthesis using ACTEL Modules

This project involves the synthesis and simulation of a **custom multiplier unit** using ACTEL-compatible Verilog modules, focusing on low-level hardware modeling and signal propagation logic. The design was implemented as part of the Computer Aided Design course to demonstrate modular hardware construction and synthesis flow.

## Objectives

- Construct a functional **multiplier unit** using Verilog modules simulating ACTEL primitives.
- Analyze combinational logic paths and control signal interactions (e.g., `x_inp`, `y_inp`, `p_inp`, `c_inp`).
- Generate synthesis results suitable for ACTEL FPGA toolchain.

## Core Logic

The `mult_unit` module receives four binary inputs:
- `x_inp`, `y_inp`: Multiplicands
- `p_inp`: Partial product input
- `c_inp`: Carry input

And produces:
- `x_out`, `y_out`: Forwarded inputs for chaining
- `p_out`: Partial product output
- `c_out`: Carry output

### Internal Circuit Operations
- **AND Gates**: 
  - `xy = x_inp & y_inp`
  - Intermediates: `and_sec_out`, `and_third_out`, `and_fourth_out`
- **XOR Logic**:
  - Calculates `p_out` from a 3-input XOR on `p_inp`, `xy`, and `c_inp`.
- **OR Logic**:
  - Combines carry effects via a 3-input OR on intermediate AND gate outputs to compute `c_out`.

## Simulation Strategy

- Used testbenches to verify output correctness of `p_out` and `c_out` under all input combinations.
- Designed the module to be easily chainable for multi-bit multiplication arrays.

## Modular Components

- `And.v`: Implements 2-input AND gate.
- `OR_inp_3.v`: 3-input OR gate used for carry combination.
- `Xor_inp_3.v`: 3-input XOR for partial product computation.
- `mult_unit.v`: The main multiplier logic block.

## Synthesis

- Compatible with ACTEL Libero SoC toolchain.
- RTL and gate-level simulations completed with waveform inspection.
- Emphasis on logic minimization and propagation delay evaluation.

> Developed for the Computer Aided Design course – Spring 2025  
> University of Tehran – Department of Electrical and Computer Engineering  