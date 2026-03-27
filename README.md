# Grayscale Processor Timing Optimization (Static Timing Analysis)

This project demonstrates timing analysis and optimization of a grayscale image processor using an ASIC RTL-to-GDS flow (OpenLane) and post-layout static timing analysis (OpenSTA).

## Overview

Two versions of the same design were implemented:

- **Baseline (clocked)**: single-stage combinational logic between input and register  
- **Pipelined**: logic split across multiple pipeline stages to improve timing  

Both designs were synthesized, placed & routed, and analyzed using extracted parasitics.

## Flow

- RTL design in SystemVerilog  
- OpenLane RTL-to-GDS flow (Sky130)  
- Post-layout STA using OpenSTA (RC-extracted)  

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

## Critical Path Analysis

- Baseline worst path: ~6.40 ns (input → flip-flop)
- Pipelined worst path: ~4.25 ns (input → flip-flop)
- Input delay constraint: 1.00 ns

The improvement comes from reducing logic depth per stage, not from changing functionality.

## Skills Demonstrated

- Static Timing Analysis (STA)
- WNS / TNS interpretation
- Setup vs Hold analysis
- Critical path debugging
- Timing-driven RTL optimization (pipelining)
- ASIC flow experience (OpenLane, Sky130)

## Tools

- OpenLane
- OpenSTA
- Sky130 PDK
- Icarus Verilog / GTKWave (verification)

## Notes

All results are from open-source tools and standard PDKs.  
Design and data are non-proprietary.
