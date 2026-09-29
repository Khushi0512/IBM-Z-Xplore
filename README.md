# IBM Z Xplore — Fundamentals Track

I spent the better part of a week doing IBM's Z Xplore Fundamentals challenges, and honestly it was one of those experiences where you go in thinking "how hard can it be" and come out the other side with genuine respect for mainframe engineering. This repo has all the code, commands and notes from that run.

Quick context: IBM Z Xplore is a free learning platform where you get actual access to a real z/OS mainframe (not a simulator) and complete hands-on challenges. The Fundamentals track has 5 challenges — VSC1, USS1, CODE1, REXX1, and WRAPUP. I completed all 5, finishing with 13 programs completed on the platform.

---

## The Setup

Everything runs through VSCode with the Zowe Explorer extension connected to IBM's mainframe at `204.90.115.200`. You SSH in, poke around actual z/OS datasets, write JCL, run Python, use REXX — the whole thing. It's a lot more hands-on than most certifications I've come across.

---

## Challenge 1 — VSC1 (Visual Studio Code + Zowe)

This one was about getting comfortable with the environment itself. The Zowe Explorer plugin for VSCode becomes your window into everything — datasets, jobs, USS files. You browse z/OS datasets the same way you'd browse a folder on your laptop, which is a surprisingly clean experience once you get past the initial setup.

The main thing I learned here was the difference between data sets and members (think of a PDS like a folder, and members like files inside it), and how JCL jobs get submitted and monitored right from the sidebar. You look for `CC 0000` in the job output — that's your green light.

---

## Challenge 2 — USS1 (UNIX System Services)

This was the one that clicked things into place for me. USS is essentially a POSIX-compliant UNIX environment running inside z/OS, and once you're SSH'd in it feels surprisingly familiar — `ls`, `cd`, `pwd`, `touch`, `mkdir`, all the usual suspects work exactly as you'd expect.

The actual challenge had a cipher puzzle. There's a script called `scramble.sh` that applies a Caesar cipher rotation to a secret file. Your job is to figure out the correct number of rotations (between 1 and 26) to decode it. I ran a loop to test all rotations and landed on **rotation 17** as the answer.

```bash
./scramble.sh /z/public/secret.txt 17
# Output: congratulations! you unscrambled the message in the uss challenge!!
```

After cracking that, the final `ussout.txt` file needed three things in order:
1. The decoded secret message
2. Disk usage output from `du -ak`
3. Current timestamp from `date`

Then submit `CHKUSS1` from `ZXP.PUBLIC.JCL` via the Zowe Explorer. The key thing with output redirection here — `>` overwrites, `>>` appends. Got that wrong once and had to rebuild the file.

**Tab completion** in the USS shell is genuinely life-changing by the way. The PDF even mentions it and they're not wrong.

---

## Challenge 3 — CODE1 (Python on z/OS)

Python runs natively on the mainframe and the code looks exactly like Python anywhere else — same syntax, same logic, same headaches when your indentation is off by one space.

The challenge walked through:
- Variables and data types
- `if/else` conditionals  
- `while` loops
- Modifying existing programs

The main deliverable was `marbles.py` — a countdown program that starts with 10 marbles, prints an asterisk visual for each one, warns you when you're running low (≤ 3), and prints a final "You are all out of marbles" message when the loop ends.

The tricky part was getting the indentation right for the `if` block inside the `while` loop, and making sure the final print statement was *outside* the loop entirely. Python being whitespace-sensitive makes this either very elegant or very annoying depending on your mood.

```python
while (marbles > 0):
    print(marble_dots[:marbles])
    print("You have " + str(marbles) + " marbles left.")
    if marbles <= 3:
        print("Warning: You are running low on marbles!!")
    marbles -= 1
    print("")

print("You are all out of marbles")
```

Submit `CHKCODE` from `ZXP.PUBLIC.JCL` when it looks right.

---

## Challenge 4 — REXX1 (Enterprise IT Duct Tape)

REXX ("Restructured Extended Executor") is a scripting language built into z/OS that's been around since the 80s and still gets used daily on production mainframes. The challenge name calls it "enterprise IT duct tape" which is pretty accurate — it's the glue that holds a lot of z/OS automation together.

This challenge introduced the **Zowe CLI**, which you install on your local machine (not the mainframe) and use to issue TSO commands without needing a full terminal session open.

```bash
npm i -g @zowe/cli
```

The flow was:
1. Run `SOMEREXX` directly using `zowe tso issue command` — this gives you a big ASCII art "GREETINGS FROM REXX" banner
2. Start a TSO Address Space with `zowe tso start as` — it gives you back a key like `Z76790-194-aadiaaap`
3. Use that key to send commands to the persistent address space
4. Run `GUESSNUM` — an interactive number guessing game (1-10) that works through the address space

The address space thing is interesting conceptually. Think of it as reserving a block of system memory that stays alive between commands, so you can have a back-and-forth conversation with an interactive program. Without it, each command is stateless.

Guessed the number in 2 tries (tried 5, then 3 — got lucky).

```
You got it! And it only took you 2 tries!
READY
```

Submit `CHKREXX1` from `ZXP.PUBLIC.JCL`.

---

## Challenge 5 — WRAPUP (Z Open Automation Utilities / ZOAU)

The final one ties everything together. ZOAU is a Python library that gives you native access to z/OS operations — creating datasets, submitting jobs, reading system info — all from within a Python script. It's essentially the bridge between "I know Python" and "I can automate z/OS tasks."

The script (`members.py`) does three things:
1. Asks for a dataset name and creates it as a sequential dataset if it doesn't exist
2. Pulls the system **linklist** — the full list of libraries loaded at z/OS startup
3. Writes that linklist out to the dataset

Two fixes were needed in the original script:

**Fix 1** — The dataset type was `"???"` as a placeholder. Changed to `"SEQ"` for sequential:
```python
datasets.create(dsname, dataset_type="SEQ", primary_space="1k", secondary_space="1k")
```

**Fix 2** — Uncommented the correct linklist function (ZOAU had a version update and the function name changed):
```python
linklist_output = zsystem.list_linklist()
```

**Fix 3** — The `datasets.write()` arguments were in the wrong order. The dataset name comes first:
```python
datasets.write(dsname, linklist_output, append=False)
```

Run it, enter `Z76790.COMPLETE` when prompted, say `y` to create the dataset, and the linklist prints out — entries like `SYS1.MIGLIB`, `SYS1.CSSLIB`, `VENDOR.LINKLIB` and about 20 more system libraries.

Submit `CHKAUTO` from `ZXP.PUBLIC.JCL` to finish.

---

## Results

**13 Programs Completed** across the Fundamentals track. Badge 01 (Fundamentals + Concepts) pending verification on the IBM Z Xplore platform.

The challenges covered: USS navigation, Caesar cipher decoding, Python on z/OS, REXX scripting, TSO address spaces, Zowe CLI, and ZOAU automation. Not bad for a week.

---

## Repo Structure

```
IBM-Z-Xplore/
├── USS1/
│   └── commands.sh          # all USS commands used
├── CODE1/
│   └── marbles.py           # the marble countdown program
├── REXX1/
│   └── commands.sh          # Zowe CLI commands for REXX challenge
├── WRAPUP/
│   ├── members.py           # ZOAU Python script (fixed version)
│   └── commands.sh          # commands for WRAPUP challenge
└── outputs/
    ├── ussout_sample.txt    # USS1 final output file
    ├── rexx_greeting.txt    # SOMEREXX ASCII art output
    └── guessnum_session.txt # GUESSNUM interactive session log
```

---

## How to Push This Repo

```bash
git init
git add .
git commit -m "IBM Z Xplore Fundamentals - all 5 challenges complete"
git remote add origin https://github.com/YOUR_USERNAME/IBM-Z-Xplore.git
git branch -M main
git push -u origin main
```

Replace `YOUR_USERNAME` with your GitHub username. Create the repo on GitHub first (no README, no .gitignore — empty repo).

---

## Tech Stack

- IBM z/OS mainframe (real hardware, not simulated)
- VSCode + Zowe Explorer extension
- Zowe CLI (`@zowe/cli`)
- Python 3 on z/OS
- REXX scripting language
- ZOAU (Z Open Automation Utilities)
- JCL (Job Control Language)
- USS (UNIX System Services)
- TSO (Time Sharing Option)
