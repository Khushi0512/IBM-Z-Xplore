#!/bin/bash
# WRAPUP - Z Open Automation Utilities Challenge
# All commands used to complete this challenge

# Step 1: SSH in
ssh z76790@204.90.115.200

# Step 2: Write a line to JCL3OUT dataset using decho
decho -a "This line goes at the bottom" 'Z76790.JCL3OUT'

# Step 3: Copy members.py from public directory
cp /z/public/members.py ~

# Step 4: Run the script
# When prompted: enter Z76790.COMPLETE
# When asked to create: enter y
python3 members.py

# Output: prints full system linklist including:
# VENDOR.LINKLIB, SYS1.MIGLIB, SYS1.CSSLIB, SYS1.STEALNKE ...etc

# Step 5: Submit CHKAUTO from ZXP.PUBLIC.JCL via VSCode Zowe Explorer
