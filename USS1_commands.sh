#!/bin/bash
# USS1 - UNIX System Services Challenge
# All commands used to complete this challenge

# Step 1: Connect via SSH
ssh z76790@204.90.115.200

# Step 2: Set up home directory
uss-setup
ls

# Step 3: Navigate directories
pwd
cd directory1
pwd
cd ..
cd ~
cd /z/public/test
cd ~

# Step 4: Create files and folders
touch mynewfile
ls
mkdir mynewdir
ls

# Step 5: Find the correct rotation for the scramble cipher
# Tested rotations 1-26, rotation 17 was correct
./scramble.sh /z/public/secret.txt 17

# Step 6: Build ussout.txt with 3 sections
./scramble.sh /z/public/secret.txt 17 > ussout.txt   # decoded message
du -ak >> ussout.txt                                    # disk usage
date >> ussout.txt                                      # timestamp

# Verify
cat ussout.txt

# Step 7: Submit validation job CHKUSS1 from ZXP.PUBLIC.JCL via VSCode Zowe Explorer
