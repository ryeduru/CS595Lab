# Whirlwind: Privacy-Preserving ETH Mixer

## Overview
This project implements a simple on-chain ETH mixer using Noir zero-knowledge circuits for deposit and withdrawal.  
Users deposit exactly 0.1 ETH, which is committed into a Merkle tree. Later, they withdraw anonymously by proving membership and revealing a nullifier to prevent double-spend.

## Repo Structure
