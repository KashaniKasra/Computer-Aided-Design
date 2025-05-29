# Maclaurin Series Pipeline – Hardware Accelerator Design

This project implements a **pipelined hardware accelerator** for evaluating the **Maclaurin series expansion** of the exponential function `e^x`. The design uses a multi-stage pipeline to compute successive terms of the series efficiently using hardware-friendly techniques, including fixed-point arithmetic and modular control.

## Project Goals

- Efficiently compute `e^x` using the first 6 terms of the Maclaurin series:
  \
  e^x ≈ 1 + x + x²/2! + x³/3! + x⁴/4! + x⁵/5!
- Implement a pipelined architecture where each stage computes and accumulates a term of the series.
- Use fixed-point representation to handle fractional values in hardware.

## Pipeline Architecture

The accelerator consists of 6 pipeline stages:
1. Stage 0 – `1` (constant term)
2. Stage 1 – `x`
3. Stage 2 – `x²/2`
4. Stage 3 – `x³/6`
5. Stage 4 – `x⁴/24`
6. Stage 5 – `x⁵/120`

Each stage performs:
- Power computation (`x^n`) using pipelined multiplication
- Division by factorial (hardcoded)
- Accumulation with previous stage’s result

All operations are pipelined to support **streaming mode input** for high-throughput computation.

## Data Representation

- Inputs and outputs use **fixed-point format** (e.g., Q4.12)
- Internal multiplication results are truncated/rounded to fit pipeline width
- Overflow and saturation logic implemented to ensure numerical stability

## Simulation

- Testbench applies a stream of `x` values and verifies `e^x` approximation.
- Compared with MATLAB/Verilog reference models for accuracy.
- Simulated using **ModelSim**, waveform output validated for pipeline latency and result accuracy.

## Highlights

- Supports one output per clock cycle after pipeline fill
- Modular design: stages are independently reusable
- Designed for FPGA synthesis using Verilog HDL

---

> Developed for: Computer Aided Design – Spring 2025  
> University of Tehran | Department of Electrical and Computer Engineering  