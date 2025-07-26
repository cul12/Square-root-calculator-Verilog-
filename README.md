# Square root calculator (Verilog)
This repository contains a Verilog-based implementation of a **Square Root Calculator** using a modular **datapath-controller architecture**.

#### Project Overview:

The system computes the square root of a given number, including non-perfect squares, providing approximate floating-point results. It is divided into two main components:

### Datapath:

The datapath module is responsible for performing the core computations. It includes:

* **Register units** to store low, high, and mid pointers.
* **ALU logic** for calculating the midpoint and performing arithmetic operations like squaring and comparisons.
* **Intermediate registers** to store squared midpoints and other intermediary values for iterative approximation.
* **Multipliers and comparators** to refine the square root result.

### Controller (FSM):

The controller uses a **Finite State Machine (FSM)** to manage:

* **Control signals** (load/reset/enable) for datapath registers.
* Step-by-step coordination of the square root calculation process.
* Adaptive behavior depending on whether the input is a perfect square or not.

### Top Module Integration:

The top-level module integrates both datapath and controller units, handling the overall square root computation logic in a synchronized manner.

### Testbench:

Comprehensive testbenches validate the design:

* Tests include **edge cases**, such as non-perfect square inputs.
* Verifies that the output approximates floating-point square roots for such inputs.
