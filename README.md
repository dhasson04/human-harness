<p align="center">
  <img src="assets/banner.svg" alt="human-harness — a focus harness for a human with ADHD" width="820">
</p>

<p align="center">
  <img alt="license: MIT" src="https://img.shields.io/badge/license-MIT-2ea043">
  <img alt="Claude Code skill" src="https://img.shields.io/badge/Claude%20Code-skill-d97757">
  <img alt="dependencies: 0" src="https://img.shields.io/badge/dependencies-0-58a6ff">
  <img alt="status: distracted" src="https://img.shields.io/badge/status-distracted-d29922">
</p>

> Humans with ADHD are just LLMs with a terrible context window and no system prompt.
> So I gave myself one.

`human-harness` is a focus harness for a human with ADHD. It's the same scaffolding
I build to keep an LLM on task (one thing at a time, a system prompt, no wandering),
except it's pointed at you.

It runs inside [Claude Code](https://claude.com/claude-code) as a skill. You give it
a task; it casts you a system prompt, breaks the task into the single next physical
action, shows you **one thing at a time**, and when you drift it re-injects your
system prompt at you.

```
SYSTEM PROMPT
You are a focused senior software engineer. You ship. You do not open Twitter.

▶ NEXT ACTION
Open the auth PR and read the 3 review comments.        ~3 min

queued · don't load yet
· reply to Sarah          ~2m
· write the launch post   ~25m

off-limits
· Twitter · unrelated refactors · any new task
```

## Install (30 seconds)

It's a Claude Code skill — a single file, just like any other skill.

```bash
git clone https://github.com/dhasson04/human-harness
mkdir -p ~/.claude/skills/human-harness
cp human-harness/SKILL.md ~/.claude/skills/human-harness/SKILL.md
```

Restart Claude Code. That's it. No key, no config, nothing to connect.

## Use

```
/human-harness ship the auth PR and reply to Sarah
```

- It casts your **system prompt** (adapts to the task: `do my outreach` makes you a
  salesperson) and breaks the work into the single next physical action.
- Pick **Done / Stuck / Not now** (or type `d`/`s`/`n`). Stuck shrinks the step
  smaller. Not now requeues it, no guilt.
- Wander off-task and it re-injects your system prompt at you.

No arguments? It just asks: `> what do you want done?`

## License

MIT.
