---
slug: "/SeriesAcceleration/Introduction"
date: "2020-11-01"
title: "Introduction"
categories: ["Mathematics", "Series Acceleration"]
description: "The main motivation for Series Acceleration is to accelerate series."
---

# Motivation

We are all fimiliar with finite sums of the type $a_0 + a_1 + \dots + a_N = \sum_{n=0}^N a_n = S_\mathrm{finite}$.
A very basic concept in mathematics are infinite series, where we sum up infinitely many terms: $a_0 + a_1 + \dots = \lim_{N \to \infty} \sum_{n=0}^N = S_\mathrm{infinite}$. From the outset it is not obvious wether $S_\mathrm{infinite}$ exists (which it often does not do in the naiive sense). Furthermore, it is not clear in which cases $S_\mathrm{finite}$ may be a good approximation for $S_\mathrm{infinite}$.
The aim of this series of blog articles is to develop methods that are
  - able to obtain an approximation of $S_\mathrm{infinite}$ that is better than naiively summing up $m$ terms.
  - able to extract information, even in cases where the naiive sum for $S_\mathrm{infinite}$ diverges.
