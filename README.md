# 1110 Sequence Detector

## Overview
This project implements a **1110 sequence detector** using both **Mealy** and **Moore** finite state machines (FSMs) in Verilog. The detector identifies the specific bit sequence "1110" in a serial input stream.

## Project Structure

### Files:
- **mealy.v** - Mealy FSM implementation
- **moorel.v** - Moore FSM implementation  
- **README.md** - This documentation file

## Mealy machine

**States:**
- **S0**: Start/Reset state
- **S1**: Received '1'
- **S2**: Received '11'  
- **S3**: Received '111'

**Output:** `out = 1` when `(state == S3) && (in == 0)`

### Moore Machine 
   
**States:**
- **S0**: Start/Reset state (output = 0)
- **S1**: Received '1' (output = 0)
- **S2**: Received '11' (output = 0)
- **S3**: Received '111' (output = 0)
- **S4**: Received '1110' (output = 1)

**Output:** `out = 1` only when `state == S4`

## Key Differences Between Mealy and Moore

| Aspect | Mealy Machine | Moore Machine |
|--------|---------------|---------------|
| **Output Dependency** | Current state + Current input | Current state only |
| **Output Timing** | Can change between clock edges | Changes only on clock edges |
| **Number of States** | 4 states | 5 states |
| **Output Duration** | Half clock cycle (typically) | Full clock cycle |
| **State Transitions** | More complex | Simpler |

## Test Sequences

The testbench verifies the following input sequences:

1. **`1-1-1-0`** - Valid sequence (should detect)
2. **`1-1-0`** - Invalid sequence (should not detect)  
3. **`1-1-1-0`** - Valid sequence (should detect)

## Simulation Results

### Mealy Machine Behavior:
- Output goes high immediately when the 4th bit is '0' after '111'
- Output pulse duration depends on input timing
- More responsive but potentially glitchy

### Moore Machine Behavior:
- Output goes high only in state S4 (after complete sequence)
- Output remains high for exactly one clock cycle
- More stable but delayed response

