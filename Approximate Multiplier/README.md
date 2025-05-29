
# Approximate Multiplier – Digital System Design Project

This project implements an **Approximate Multiplier** using Verilog, focusing on energy-efficient computation in resource-constrained systems such as IoT and embedded devices. The design balances hardware simplicity and performance by discarding non-significant bits to reduce computational overhead while maintaining acceptable output accuracy.

## Project Objectives

- Gain proficiency in RTL design and Verilog modeling.
- Implement and simulate an approximate multiplication circuit using an 8x8 synthesizable multiplier.
- Optimize for **reduced power consumption**, **higher speed**, and **lower complexity**.
- Demonstrate trade-offs between precision and hardware efficiency.

## Approximation Methodology

1. **Bit Trimming Technique**:  
   Each 16-bit input is parsed from MSB to LSB. As soon as the first `1` is encountered, remaining lower bits are discarded.  
   This effectively reduces operands to **8-bit effective segments**, which are multiplied using a standard 8x8 multiplier.

2. **Result Reconstruction**:  
   Final 32-bit output is created by left-padding the multiplication result with:
   - Leading zeros for the total number of *worthless bits* (preceding MSB).
   - Trailing zeros for the total number of *discarded bits*.

   ```
   Final Result = {Worthless Zeros, A_eff × B_eff, Discarded Zeros}
   ```

## Components

- **Input RAM**:  
  - Stores 16-bit operands loaded from a `.txt` file.
  - Operands are read on rising edge of clock.

- **Output RAM**:  
  - Stores 32-bit results of the multiplication.
  - Results are written to a text file in hexadecimal format on clock edge.

- **Top-Level Design**:  
  - Implemented using a classic **Controller / Datapath / Top Module** separation (Huffman-style design).
  - Includes:
    - `Start` signal (edge-triggered from 0 → 1)
    - `Done` signal (active-high for one clock after processing last data)


## Key Signals

- `start` – begins the computation process.
- `done` – indicates the operation is complete after final multiplication.
- `clk` – rising-edge triggered synchronization.
- `reset` – resets all states in the controller and datapath.

## Notes

- All designs are tested using **ModelSim**.
- Approximation introduces **controlled and bounded error** for energy-performance benefits.
- Followed university policies and academic integrity requirements.

---

> Designed as part of the **Digital System Design** course – Spring 2025  
> University of Tehran | Department of Electrical and Computer Engineering  