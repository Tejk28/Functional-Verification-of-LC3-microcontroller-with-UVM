# Functional-Verification-of-LC3-microcontroller-with-UVM

Author: Tejashree Kulkarni

University: North Carolina State University;  Professor: Bob Oden

Course: ECE 748; Advance Verification with UVM;  Duration: Aug 2023- December2023 

The technology used:  UVM methodologies, SVA, SVTB, CRV testing, Layered testbench Arch, OOPs

Project Accomplishment:

- Tested L3C decode block design using reusable UVM testbench agents of environment, monitor, driver BFM  
- Generated testbench code for other stages using UVMF libraries and integrated all 5 stages of the LC3 microcontroller. 
- Developed a functional coverage model involving CRV and directed 

Structure of Project:
The project is divided in 3 main parts. 
p1: Create UVM interface package for decode input and output.
  p1a: Create UVM interface package from scratch for decode block of LC3 micro-controller (input interface)
  p1b: Create UVM interface package for decode input and output using UVMF

p2: Create UVM environment and testbench for the decode block
  p2a: Create UVM environment and testbench for the decode block from scratch. Here all prediction, and scoreboarding was written from scratch
  p2b: UVM environment and testbench for decode block using UVMF. Result obtained were same. Goal was to learn creating testbench from scratch & using UVMF

p3: Create a UVM environment and test bench for LC3 that includes the decode environment.
 
