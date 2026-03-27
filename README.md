# Grayscale Processor Timing Optimization (STA)

This project analyzes and resolves timing violations in a grayscale image processor using post-layout static timing analysis (STA). By introducing pipelining, the design achieves timing closure at 200 MHz under RC-extracted conditions.

## Overview

Two versions of the same design were implemented:

- **Baseline (clocked)**: single-stage combinational logic between input and register  
- **Pipelined**: logic split across multiple pipeline stages to improve timing  

Both designs were synthesized, placed & routed, and analyzed with extracted parasitics.

## Flow

- RTL design in SystemVerilog  
- Synthesis, place & route, and RC extraction  
- Post-layout STA using OpenSTA  

## Timing Results (5 ns clock, 200 MHz)

| Metric | Clocked | Pipelined |
|---|---:|---:|
| Worst Path Arrival | 6.40 ns | 4.25 ns |
| WNS | -1.48 ns | 0.00 ns |
| TNS | -9.30 ns | 0.00 ns |
| Worst Setup Slack | -1.48 ns | +0.75 ns |
| Worst Hold Slack | +0.38 ns | +0.33 ns |
| Timing Status | ❌ Fail | ✅ Pass |

## Key Insight

The baseline design failed setup timing due to excessive combinational depth in a single cycle.

Pipelining reduced the critical path delay by ~2.15 ns, enabling full timing closure at 200 MHz.

This demonstrates how reducing combinational depth directly improves setup timing and enables frequency scaling without changing functionality.

## Critical Path Analysis

- Baseline worst path: ~6.40 ns (input → flip-flop)
- Pipelined worst path: ~4.25 ns (input → flip-flop)
- Input delay constraint: 1.00 ns

The improvement comes from reducing logic depth per stage, not from changing functionality.

## Skills Demonstrated

- Post-layout STA with RC parasitics  
- WNS/TNS analysis and timing closure  
- Setup vs hold constraint debugging  
- Critical path identification and optimization  
- Timing-driven RTL pipelining  

## Tools

- OpenSTA  
- Sky130 PDK  
- Icarus Verilog / GTKWave  

## Notes

All results are generated using open-source tools and standard PDKs.  
Design and data are non-proprietary.
