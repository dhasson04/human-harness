# human-harness — Spec

> A harness for humans. We build scaffolding that keeps LLMs focused — feed them
> one task at a time, with the right context, and don't let them wander. This is
> the same thing, for a person with ADHD.

**Status:** v1 built · **Surface:** Claude Code skill (`/human-harness`) · **License:** MIT

---

## 0. The thing we are designing toward (the post)

Everything in this spec exists to make one artifact real: a front-page post.

> **Title:** *Attention Is All You Need (But I Have ADHD)*
>
> I have ADHD. I also build agent harnesses for LLMs all day — the scaffolding
> that feeds a model one task at a time and won't let it wander off. One day it
> hit me: *I* am the model with no harness. So I built one for myself — a Claude
> Code skill. You give it a task; it casts you a system prompt — *"You are a
> focused senior software engineer. You ship. You do not open Twitter."* — breaks
> the task into the single next action, feeds you one thing at a time, and when
> you drift it **re-injects your system prompt at you.** Open source, no key, no
> signup, no brain to connect.
>
> **[screenshot of the frame]**
>
> First comment: *"Humans are just LLMs with a terrible context window and no
> system prompt. So I gave myself one."*

**The core concept: it prompts you.** No brain, no connectors, no MCP. You are the
model; the skill (running in Claude Code) is the harness wrapping you. (Connectors
could come back later as an *optional* context source — but they are not the concept.)

**Requirements this post imposes on us:**
1. **One clean screenshot** of the rendered frame — persona banner + the single
   NEXT ACTION — that reads on its own with no caption.
2. **`/human-harness` works instantly in Claude Code** — no key, no account,
   nothing to connect or install beyond dropping in one file.
3. A repo that is **funny to read** and **actually works** (the crowd will install it).

---

## 1. The magic moment (one screenshot)

The launch artifact is a single screenshot of the frame — the harness casting your
system prompt and handing you exactly one action. No clip, no timing, no loop to
film. The persona banner and the NEXT-ACTION box are co-heroes:

```
  ╔══════════════════════════════════════════════════════════════╗
  ║  SYSTEM PROMPT                                                 ║
  ║  You are a focused senior software engineer.                   ║
  ║  You ship. You do not open Twitter.                            ║
  ╚══════════════════════════════════════════════════════════════╝

  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  ┃  ▶ NEXT ACTION                                                ┃
  ┃    Open PR #412. Read the 3 review comments, lines 40–90.     ┃
  ┃    ~3 min                                                     ┃
  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  queued · do not load yet · off-limits: Twitter, unrelated refactors
  [d] done     [s] stuck     [n] not now
```

The post lives or dies on this one image: **a system prompt, deadpan, pointed at a
human.** It needs zero explanation.

---

## 2. Product rules (these ARE the brand — do not violate)

- **One card. Never the backlog.** The backlog is where ADHD dreams go to die.
  Showing a list is the failure mode that turns this into yet another todo app.
- **"Stuck" is kind, not a scold.** It re-atomizes the task *smaller* and offers
  the very next physical action. It never says "you failed."
- **"Not now" reschedules, never deletes.** Guilt is the enemy. Nothing is lost.
- **The nudge re-injects context — it is not a bell.** A bare alarm fails ADHD
  adults (alarm fatigue; an adult SMS-reminder RCT showed *no* effect). On drift
  the harness **re-shows the one task** (restates it, contextual, persistent),
  never just pings. Cadence is gentle and tunable.
- **No guilt mechanics, ever.** The barrier to starting is accumulated shame
  (Brendan Mahan's "Wall of Awful"), not difficulty. So: no overdue counters, no
  red badges, no "you've had this for 3 days." The tool never adds a brick.
- **Body double for one — scaffolding, not pressure.** Position as *externalized
  executive function* (the report's strongest-supported mechanism), NOT
  accountability/social-pressure (that mechanism was specifically refuted). The
  harness is a calm companion that holds the next step for you — it is never
  disappointed in you, never judgy. Keep nudge copy deadpan-mechanical.
- **Finishing must feel good.** A small, satisfying completion beat every time.
- **Zero friction to start.** Runs with a local file + the user's own LLM key.
- **Play purely on the meme — no competitive positioning.** We never compare
  ourselves to other tools (Focusmate, Tiimo, etc.). No comparison tables, no
  "the thing none of them do." The joke carries it; positioning kills the vibe.

> **Evidence (deep-research, 2026-05-31):** the core mechanic is clinically
> well-supported. "One task, remove the next-step decision" maps to ADHD
> paralysis research; AI atomization is the *wedge* because decomposition is
> itself an EF burden (CHADD, ADD.org, Barkley); externalized EF has RCT support
> (ACCESS, Cohen's d .39–1.21). **Soft spots:** standalone alarms fail adults →
> nudges must re-inject context; body-doubling's *pressure* mechanism is refuted
> → no shame framing. **Unverified:** the virality/launch playbook — treat all
> launch tactics as guesses. Only hard launch fact: Reddit enforces subreddit +
> sitewide rules, so read r/ADHD's live rules before posting.

---

## 2b. The meme layer (the skin — this is what makes it spread)

The mechanics make it *useful*; the skin makes it *shareable*. Every surface
treats **the human as the LLM and the skill as the harness wrapping it.** The
rendered frame *is* the meme. The register is **deadpan, never jokey** — the
comedy is the straight-faced equivalence, not a punchline. No meme references.

- **Speak to the human like it's the model.** Borrow inference/agent vocabulary,
  pointed at a person, stated flatly:
  - the persona is literally a `SYSTEM PROMPT` block aimed at you
  - drift nudge → `⚠ agent off-task. re-injecting system prompt → "…"` (THE shot)
  - it refers to you as **"the agent"** / **"the model"** in system lines.
- **The system prompt is the hero** (THE core mechanic, not flavor): "You are a
  focused senior software engineer. You ship. You do not open Twitter." It's cast
  per task (adapts the role), and **it's what gets re-injected at you when you
  drift.** The screenshot lives on this block.
- **`off-limits` stays dry and true** — concrete distractions for this task in the
  same flat config voice as the real steps. Never a comedy bit.
- **Restraint — the joke is an easter egg, not a banner.** No mascot, no model-card
  table. One quiet line under the README title (`context window: 1 · status:
  distracted`) is the whole nod. Found, not shouted.

The funniest part is that none of it is trying to be funny — it's literally true.

## 3. The flows (all of v1, nothing more)

| Flow | What it does | Notes |
|---|---|---|
| **System prompt** | Iconic default ships built-in; persists, editable via file | No step to do. Re-injected at you on drift. The hero joke. |
| **Prompt yourself** | You type the task — "what do you want done?" | One input box. No fields, no tags, no projects, no brain, no Linear. |
| **Atomize** | LLM turns your task prompt (conditioned on your system prompt) into a *ranked* list of single next-actions + "why now" | The intelligence. The validated wedge. Structured output. |
| **Focus** | Renders exactly **one** card: task + just-in-time context + "why now" + 3 actions | The constraint = the feature. |
| **Loop / Nudge** | On `done`/`stuck`/`not-now`, fetch the next card. Going quiet re-injects your system prompt | What makes it a *harness*, not a list. |

**Non-goals for v1:** brain/connectors of any kind (MCP included), activity/window
watching, calendar sync, mobile, multi-user, a web UI. All explicitly later — and
the brain is now *optional future*, not core.

---

## 4. Architecture

It's a **Claude Code skill** — like `caveman`. One file, no code, no deps.

```
human-harness  (one repo, MIT)
├── SKILL.md     the whole product: persona casting + atomize + frame + loop
├── README.md    the meme, model-card voice, hero frame on top, install
└── SPEC.md      this doc
```

**Claude itself is the atomizer.** The skill is instructions, not a program: when
the user runs `/human-harness <task>`, Claude casts a system-prompt persona,
breaks the task into the single next physical action, renders the frame, and runs
a turn-based done/stuck/not-now loop — re-injecting the persona when the user
drifts off-task. That's the whole machine.

- **Zero setup.** No API key, no accounts, no connectors, no deps. Runs wherever
  Claude Code runs — Claude is the model, so there's nothing to configure.
- **Turn-based, not timed.** A skill can't run background timers, so "drift" = an
  off-task *message*, which is the punchier beat anyway.
- **No persisted state.** The persona is derived per task (default dev flavor,
  adapts to the task's domain). Nothing on disk.
- **Distribution:** drop `SKILL.md` into `~/.claude/skills/human-harness/`, exactly
  like caveman. (A `.claude-plugin` manifest for one-command install is later.)
- **Connectors (Linear/MCP) are optional *future*, not core.** Never required.

---

## 5. Build order

1. ✅ **`SKILL.md`** — persona casting, atomize, the frame, the turn-based loop.
2. ✅ **The hero frame** — persona banner + NEXT-ACTION box as co-heroes, deadpan.
3. ✅ **Meme README** — model-card voice, hero frame on top, 30-second install.
4. ▶ **Verify in Claude Code** — install the skill, run `/human-harness`, check the
   frame renders and the loop/drift behave. (Pivoted from a TS CLI to a skill —
   no API key, and the "Claude runs you" recursion lands harder.)
5. **Screenshot the frame**, dogfood a few days, *then* post.

**The brutal-honesty rule:** the crowd that finds this funny will install it within
five minutes and roast us if it doesn't work. The clean screenshot *is* the
marketing — but the skill has to actually render it. Frame quality > everything.

---

## 6. Open questions (decide as we build)

- Default nudge interval? (lean: ~20–25 min focus blocks, tunable)
- Card "why now" — always shown, or only when non-obvious?
- "Stuck" re-atomize: one level deep, or recursive until trivially small?
- Name lock-in: `human-harness` (current pick) vs. alternatives.
