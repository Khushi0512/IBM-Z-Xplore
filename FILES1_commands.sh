#!/bin/bash
# FILES1 - Not Just Members Only
# All steps done via VSCode Zowe Explorer GUI
# This challenge covers z/OS datasets, members, copy, rename, delete

# Step 1: Set filter in Zowe Explorer to show:
# Z76790, ZXP.PUBLIC

# Step 2: Submit PDSBUILD from ZXP.PUBLIC.JCL
# This creates your personal datasets: Z76790.INPUT, Z76790.OUTPUT etc.
# Result: CC 0000

# Step 3: Explore Z76790.INPUT (PDS - Partitioned Data Set)
# Members inside are unique per user

# Step 4: Rename a member
# Right-click member in Zowe Explorer -> Rename Member

# Step 5: Delete a member
# Right-click member -> Delete Member

# Step 6: Copy a member between datasets
# Right-click -> Copy Member, then right-click destination -> Paste Member

# Step 7: Sequential dataset access
# Open Z76790.OUTPUT (sequential dataset, not PDS - no members, just flat data)

# Step 8: Create your own member
# Right-click Z76790.JCL -> Create New Member -> type name -> add content -> save

# Step 9: Submit validation job
# Right-click CHKFILES1 in ZXP.PUBLIC.JCL -> Submit Job
# Result: CC 0000

# Key concepts learned:
# PDS (Partitioned Data Set) - like a folder, contains members
# Sequential dataset - flat file, read top to bottom
# Members - individual files inside a PDS
# IEBGENER - z/OS utility for copying datasets
