#!/bin/bash
# JCL1 - Orchestrating the Enterprise
# All steps done via VSCode Zowe Explorer
# JCL = Job Control Language — how you tell z/OS what to run and how

# Step 1: Submit JCLSETUP from ZXP.PUBLIC.JCL
# Creates personal datasets: Z76790.JCL, Z76790.LOAD, Z76790.OUTPUT etc.
# Key concept: &SYSUID. is a symbolic — auto-replaced with your userid
# Result: CC 0000

# Step 2: Set Jobs filter in Zowe Explorer
# Owner: Z76790
# Prefix: *
# Job ID: (blank)

# Step 3: Copy JCL1 member from ZXP.PUBLIC.JCL to Z76790.JCL
# This is a job that copies JCL2 using IEBGENER utility

# Step 4: Submit JCL1 from your own Z76790.JCL dataset
# Uses IEBGENER utility to copy JCL2 member
# Result: CC 0000

# Step 5: Introduce an intentional error to learn about non-zero return codes
# Edit JCL, submit, observe CC != 0000, understand the job log

# Step 6: Run COBOL program via JCL
# JCL references a compiled COBOL program in LOAD library
# Submit and verify output

# Step 7: Submit CHKJCL1 from ZXP.PUBLIC.JCL for validation
# Result: CC 0000

# Key JCL syntax concepts:
# //jobname  JOB  - defines the job
# //stepname EXEC PGM=program - runs a program
# //ddname   DD   - defines data (input/output)
# &SYSUID.  - symbolic substitution for userid
# CC 0000   - condition code zero = success
# JES (Job Entry Subsystem) - accepts, queues and processes jobs
