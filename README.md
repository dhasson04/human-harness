<p align="center">
  <img src="https://cdn.jsdelivr.net/gh/jdecked/twemoji@latest/assets/svg/1f635-200d-1f4ab.svg" width="72" alt="😵‍💫">
  &nbsp; → &nbsp;
  <img src="https://cdn.jsdelivr.net/gh/jdecked/twemoji@latest/assets/svg/1f9d1-200d-1f4bb.svg" width="72" alt="🧑‍💻">
</p>

<h1 align="center">human-harness</h1>
<p align="center"><b>a focus harness for a human with ADHD</b></p>

<p align="center">
  <img alt="stars" src="https://img.shields.io/github/stars/dhasson04/human-harness?style=flat&color=2ea043">
  <img alt="last commit" src="https://img.shields.io/github/last-commit/dhasson04/human-harness?style=flat&color=58a6ff">
  <img alt="license: MIT" src="https://img.shields.io/badge/license-MIT-d29922">
  <img alt="Claude Code skill" src="https://img.shields.io/badge/Claude%20Code-skill-d97757">
  <img alt="dependencies: 0" src="https://img.shields.io/badge/dependencies-0-blue">
</p>

<p align="center">
  <a href="#before-and-after">Before / After</a> ·
  <a href="#install-30-seconds">Install</a> ·
  <a href="#how-it-works">How it works</a> ·
  <a href="#usage">Usage</a>
</p>

> Humans with ADHD are just LLMs with a terrible context window and no system prompt. So I gave myself one.

I engineer harnesses for LLMs: the scaffolding that feeds a model one task at a time and won't let it wander. `human-harness` is the same thing, pointed at me. It runs as a [Claude Code](https://claude.com/claude-code) skill. You hand it a task, it gives you a system prompt, breaks the task down to the single next action, and shows you one thing at a time. Drift, and it re-injects your system prompt at you.

## Before and after

<table>
<tr>
<td width="50%" valign="top">

**🧠 a todo list**

```
☐ ship the auth PR
☐ reply to Sarah
☐ write the launch post
☐ fix the billing bug
☐ review Dan's PR
☐ update the docs

started: 0
```

*twelve things, no idea where to start.*

</td>
<td width="50%" valign="top">

**🧑‍💻 human-harness**

```
SYSTEM PROMPT
You are a focused senior software
engineer. You do not open Twitter.

▶ NEXT ACTION
Open the auth PR, read the 3
review comments.          ~3 min
```

*one thing. started it.*

</td>
</tr>
</table>

## How it works

1. **You dump a task.** `/human-harness ship the auth PR, reply to Sarah`
2. **It casts a system prompt.** Picked from the task. Coding makes you a senior engineer, outreach makes you a salesperson. Fixed for the session.
3. **It atomizes.** The task becomes one concrete next action, small enough to actually start. Figuring out the next step is the hard part with ADHD, so the harness does it for you.
4. **It shows you one thing.** Never the full list. One action, a time estimate, and what is off-limits while you do it.
5. **You answer.** Done moves on. Stuck breaks the step into something smaller. Not now sends it to the back, no guilt.
6. **You drift, it pulls you back.** Go off-task and it re-injects your system prompt instead of following the tangent.

## Install (30 seconds)

```bash
git clone https://github.com/dhasson04/human-harness
mkdir -p ~/.claude/skills/human-harness
cp human-harness/SKILL.md ~/.claude/skills/human-harness/SKILL.md
```

No key, no config, no account. Claude Code is the engine.

## Usage

| command | what it does |
|---|---|
| `/human-harness <task>` | break a task down and run it, one action at a time |
| `/human-harness` | no task? it asks what you want done |
| `/human-harness about` | your model card |

The persona adapts to the work. `do my outreach` makes you a salesperson; `write the post` makes you a writer.

## FAQ

**Do I need an API key?** No. It runs inside Claude Code, which is already the model.

**Does it store my tasks?** No. Nothing is saved. The task lives in the session and that is it.

**Is it only for developers?** No. The system prompt adapts to whatever you hand it.

## License

MIT. Do whatever, just ship something.
