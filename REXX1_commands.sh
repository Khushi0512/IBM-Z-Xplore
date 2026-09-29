#!/bin/bash
# REXX1 - Enterprise IT Duct Tape Challenge
# All commands used to complete this challenge
# Run these from LOCAL terminal (CMD), NOT SSH

# Step 1: Install Zowe CLI
npm i -g @zowe/cli
zowe

# Step 2: Verify profiles
zowe config list
zowe config list defaults

# Step 3: Test connection
zowe files list ds "ZXP.PUBLIC.*"

# Step 4: Run SOMEREXX directly
zowe tso issue command "exec 'Z76790.SOURCE(SOMEREXX)'" --ssm

# Step 5: Start TSO Address Space
zowe tso start as
# Returns key: Z76790-194-aadiaaap

# Step 6: Run SOMEREXX via address space
zowe tso send as Z76790-194-aadiaaap --data "exec 'Z76790.SOURCE(SOMEREXX)'"

# Step 7: Run GUESSNUM (number guessing game 1-10)
zowe tso send as Z76790-194-aadiaaap --data "exec 'Z76790.SOURCE(GUESSNUM)'"

# Step 8: Send guesses
zowe tso send as Z76790-194-aadiaaap --data "5"   # wrong
zowe tso send as Z76790-194-aadiaaap --data "3"   # correct - "You got it! And it only took you 2 tries!"

# Step 9: Submit CHKREXX1 from ZXP.PUBLIC.JCL via VSCode Zowe Explorer
