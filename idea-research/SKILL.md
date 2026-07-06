---
name: idea-research
description: Research a side-project/business idea for profitability, tailored to Sirawit's profile (Thai fullstack dev, ex-civil-engineer cost estimator, Thoughtworks consultant). Covers global AND Thai market, applies hard viability filters, gives a brutal verdict, and always saves findings to a dated markdown file. Trigger when the user says "research this idea", "is X profitable", "should I build X", "/idea-research", or pitches any new app/SaaS/side-project concept.
---

# Idea Research

Research a business/side-project idea and deliver a brutally honest profitability verdict, personalized to Sirawit.

## Who this is for (apply to every verdict)

- **Sirawit**: fullstack dev (React, Angular, C#, Node.js), 4+ years in IT, consultant at Thoughtworks (Jetstar project). Before IT: **civil engineer — cost estimator** (concrete, rebar, area takeoff, BOQ). Thai, based in Thailand, football fan.
- **Constraints**: nights/weekends only (has a day job); solo or small team; no funding; wants side income because salary is flat.
- **Existing assets (unfair advantages — always score the idea against these)**:
  1. Teacher co-founder + partially built exam-mocking SaaS (distribution + proven payers) — the current benchmark bet.
  2. Cost-estimator domain expertise (rebar takeoff is still AI-unsolved; ราคากลาง knowledge).
  3. Thai-market native: language, LINE culture, PromptPay, FB Marketplace behavior.
  4. Thoughtworks CV → freelance/contract rate leverage is always an alternative use of the same hours.

## Research procedure

1. **Understand the idea shape first.** Classify it: marketplace / SaaS / consumer social / content / service. If it is "synchronized media consumption + chat room" in disguise (watch-together, read-together, listen-together), flag that immediately — that shape has failed for him-relevant reasons every time (see filters below).
2. **Global research (WebSearch/WebFetch)**:
   - Incumbents and funded players; their business model (B2B vs B2C, who actually pays).
   - **The graveyard**: search for failed/shutdown startups in the space and WHY they died (licensing, retention, cold-start). Graveyards teach more than success stories.
   - Independent data over vendor claims (e.g., vendor "98% accuracy" vs independent "±3%").
3. **Thai local research (search in Thai too)**:
   - Thai incumbents — including non-obvious ones: webboards (Soccersuck-style), LINE OAs, Facebook groups, human per-job services that a SaaS would replace.
   - Thai-specific moats a foreign incumbent can't cross: Thai language, government formats (ราคากลาง), LINE ecosystem, PromptPay, local regulation (e.g., Electronic Transactions Act — leases ≤3 yrs e-signable).
   - Thai user behavior reality: discovery happens on Facebook Marketplace/groups; coordination happens in LINE groups; gambling money saturates Thai football/sports content.
4. **Monetization reality**: who pays, how much, how often. "Fans/users would love it" is not a revenue model. B2B payer > consumer subscription > ads.

## Hard filters (kill-criteria — check every one)

1. **Does someone already PAY to solve this?** If no proven willingness to pay anywhere, the ocean is empty, not blue.
2. **Does Sirawit have unfair access to the payer?** (domain expertise, co-founder distribution, personal network). No access = every customer is a cold acquisition.
3. **Cold-start network effect?** If the product is worthless with 10 users (chat, community, marketplace), weight heavily against. One-user-gets-value products win for solo devs.
4. **Is the core content/media licensed by someone else?** (sports rights, music, ebooks). If yes, licensing IS the business model and a solo dev doesn't have one.
5. **Engagement shape**: spiky/seasonal (match days, exam season) hurts subscriptions and ads; steady workflow usage supports them.
6. **Free incumbent test**: can Discord/LINE/Facebook/Excel do 80% of it for free? The real competitor is usually free improvisation, not another startup.

The full 10 hard-won lessons live in the project's `CLAUDE.md` and `IDEAS.md` ("Reusable lessons") — apply all of them; highlights: trust markets (sell tools TO authorities, never imitate them), government spaces (build where it sets deadlines + ships Word files; flee where it builds platforms), LINE-workspace test (buyer must be unreachable by cheap global tools).

Rules of thumb established with him:
- *Fun ideas compete with everyone's hobby; boring ideas compete with nobody.* Why: fun ideas attract thousands of builders who'd make it free for joy (football chat → Discord/X/Soccersuck; book tracking → 16+ apps, Goodreads free, TV Time dead at 26M users), so price collapses to zero. Boring ideas (rebar takeoff, BOQ, exam prep, rent billing) repel hobbyist builders — boredom is the moat — and their users already pay to solve real workflow pain. If building it sounds fun, he's the 10,000th person building it; if it sounds boring, he might be the only one with both domain knowledge and dev skill.
- *Red ocean = proven demand; fear no-ocean instead. Differentiate via Thai-local moat + domain skill.*
- *New ideas feel better only because they're at 0% and haven't disappointed yet — always compare against finishing the exam SaaS.*

## Output requirements

0. **Assign a canonical idea ID first**: check `IDEAS.md` at the project root for the highest `#NN` and give the new idea the next number; add its one-line entry to the appropriate section of IDEAS.md (BUILD/VALIDATE/unresearched/killed) when the verdict lands. Note: idea IDs (`#NN` in IDEAS.md) and research-file prefixes (`NN-` in `research/`) are TWO SEPARATE sequences — link them with `[→ file-prefix]` markers in IDEAS.md, never conflate them. The user may reference ideas by ID ("research #23") — resolve via IDEAS.md.
1. **Always write a markdown file**: `research/NN-YYYY-MM-DD-<topic-slug>.md` under the current project directory (NN = next two-digit running number; check highest existing prefix in `research/`). Include: date, question, findings with inline source links, a "Filter scorecard & verdict" section (all 6 filters, verdict = KILL/VALIDATE/BUILD), risk table if useful, cheapest validation step, "All sources" list, links to related prior research files. Then update `SUMMARY.md` at the project root (scoreboard row + summary section). Filters are documented in `filters-explained.md` at the project root.
2. **Chat reply**: verdict FIRST (one line: build / validate / kill), then evidence, then how it ranks against his current option stack (exam SaaS → validated runner-ups → backlog). Include markdown source links.
3. **Always end with the cheapest possible validation step** that costs ฿0 and no code (interviews, landing page, asking his own agent/teacher/colleagues).
4. **Tone: brutal honesty.** No cheerleading. If the idea is weak, say weak and show why. If a sliver is salvageable, name the sliver precisely (niche, B2B pivot, acqui-target).

## Current option stack

**Single source of truth = `IDEAS.md` + `SUMMARY.md` at the project root — read those, don't trust this snapshot.** Snapshot as of 2026-07-04: BUILD = exam-mocking SaaS (#01), cost-estimation service (#02), job-hop (#03); VALIDATE = จป. compliance (#04), AI elder calls (#05), venue watch-party (#06), pet hotel (#07), rental workspace (#08), หมอดู CRM (#09), Thai text plugin (#10), estimator content+community (#107), web PDF takeoff+grouping (#108); ~48 pitched-unresearched (#11–54, #102–106); dead pile #55–101.

## Legacy option stack (historical, superseded by IDEAS.md)

1. Exam-mocking SaaS — **BUILD (researched 2026-07-04, first BUILD verdict)**: ฿5.5k–8k/course market, OpenDurian gap = mock simulation + analytics layer, StartDee graveyard says narrow vertical + charge from student #1. Scope: one exam, one mock, 10 students.
2. Thai cost-estimation: productized takeoff/BOQ service with self-built AI tooling → later SaaS (ราคากลาง moat, rebar still AI-unsolved).
3. LINE-native rental workspace for condo agents/landlords — validated shape, needs agent interviews.
3b. Thai pet hotel management SaaS (LINE-native booking/vaccine/photo-updates/PromptPay) — VALIDATE: global operators pay $20–300/mo, Thai pet economy >฿100B, no Thai-native tool; fails only access; needs 5 pet-hotel interviews.
3c. หมอดู booking/CRM SaaS — VALIDATE: mutelu economy ฿10–15B (+10–20%/yr), solo fortune tellers run real revenue through LINE/IG DMs; booking queue + PromptPay deposits + client history; verify no existing Thai player. Pattern note: rental/pet-hotel/หมอดู = one product family, "LINE-workspace for DM-run service businesses."
4. Venue-based football watch-party finder — only surviving football idea (venues pay).
5. Dead: watch-party chat, read-together rooms, radio rooms (cold-start + licensing + free incumbents); book read-tracking app (nobody pays — TV Time died at 26M users; Goodreads/Bookmory free; no unfair access); discreet dating app (demand real — Ashley Madison ~$300M/yr — but two-sided cold-start × secrecy kills viral loop, Visa Tier-1 payment risk, trust-and-safety liability a solo dev can't carry, Thailand = romance-scam epicenter, breach = blackmail-grade data); family tree app (records/DNA = the monetizable asset, owned by Ancestry/MyHeritage/FamilySearch — tree drawing is the free commodity part; build-once engagement; FamilySearch free + Thai-localized; 23andMe went bankrupt 2025 on the one-time-purchase shape); micro-SME e-tax invoice tool (squeezed: Paypers below, FlowAccount above); funeral coordination/เงินช่วยงาน ledger (grieving family = worst buyer moment, per-event engagement, notebook incumbent; deathtech winners are B2B2C like Empathy-via-employers).
