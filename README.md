<div class="sag">
    <th><img alt="GitHub License" src="https://img.shields.io/github/license/suleymangunel/VirusLab?style=plastic&label=License"></th>
    <th><img alt="Static Badge" src="https://img.shields.io/badge/Language-QuickBASIC-red?style=plastic"></th>
    <th><img alt="Static Badge" src="https://img.shields.io/badge/Platform-x86-blue?style=plastic"></th>
    <th><img alt="Static Badge" src="https://img.shields.io/badge/OS-MS─DOS-black?style=plastic"></th>
</div>

# Virus Laboratory
Creating Computer Viruses for educational use

## ⚠️ Purpose ⚠️</br>
This project documents the behavior of a BASIC program called VL.BAS, which generates an assembly skeleton file (usually virus.asm).</br>
This README provides educational, archival, and analytical context only, without any malicious functionality or execution instructions.

### ⚖️ Legal & Ethical Notice (Read First)</br>

This repository exists solely for historical, cybersecurity, and reverse-engineering research purposes.</br>
Creating, executing, or distributing self-replicating or destructive code is illegal and unethical.</br>
This documentation does not include or enable building a working or harmful binary.</br>
Any experiments must be conducted in a fully isolated (air-gapped) virtual machine, with no network connectivity or shared folders.</br>

## What It Does (High-Level Description)</br>
VL.BAS is a code-generator written in Microsoft BASIC (QBASIC/QuickBASIC) style.</br>
It outputs a text file — typically named virus.asm — containing an assembly skeleton built from predefined string templates.</br>
The generated file appears to be an assembly program stub — not necessarily functional or malicious by itself. </br>

## File Structure
VL.BAS — BASIC generator script (input).</br>
virus.asm — Generated assembly skeleton (output).</br>

## Design Overview (Safe Abstraction)</br>
Below is a non-executing, conceptual summary typical of educational BASIC-to-ASM generators from the DOS era.

#### - Template Engine</br>VL.BAS stores a series of predefined text templates in memory and writes them line by line into an .asm file.

#### - String Output</br>Each assembly directive is printed using BASIC’s file output commands (PRINT # or similar).

#### - Parameters & Placeholders</br>The script may insert variable elements like date, author signature, or simple labels (.model, .code, entry point) inside the output file.

#### - Safe Defaults</br>For educational usage, the generated assembly should contain no file I/O, replication, or system interrupts — only harmless text or logic structures (e.g., “Hello, world” routines).

## Safe Analysis & Testing (Educational Only)</br>
### Environment:</br>
- Use an isolated VM (VirtualBox, VMware).</br>
- Disable all networking, USB, and shared folders.</br>
- Take a snapshot before running anything.</br>

### Analysis Steps:</br>
- Open VL.BAS in a text editor; identify which lines print to the .asm file.</br>
- Inspect virus.asm as plain text only for any system calls or interrupt usage — do not assemble or execute.</br>

### Do Not:</br>
- Compile, assemble, or link the produced .asm file.</br>
- Add payloads, persistence routines, or any form of self-modifying/replicating behavior.</br>

## FAQ</br>
Q: Can this be run or compiled?</br>
A: No. This README is intentionally non-executable and for analysis only.</br>

Q: Why is it called virus.asm?</br>
A: Likely a historical or educational label. The documentation does not condone or support malware creation.</br>

## Contribution Guidelines
If you intend to improve this repository:</br>
- Only contribute documentation, safe disassembly notes, or encoding-repair scripts.</br>
- Do not submit makefiles, batch scripts, or linking instructions that produce binaries.</br>

## License</br>
- Recommended: CC BY-NC-SA 4.0</br>
- Attribution required</br>
- Non-commercial use only</br>
- Share alike under the same license</br>
- Ensures the content remains educational and responsible</br>

