# PetTopia Roadmap 🐾

This is our plan for building PetTopia step by step.  
We’ll update this file as we go so it shows what’s done and what’s next.

---

## Phase 1 – Core Gameplay Loop
**Goal:** Get the pet alive on screen with basic interactions.  
**Tasks:**
- Make `Global.gd` singleton with hunger, happiness, energy, coins
- Add feed, play, rest functions
- Build Home scene with pet sprite, bars, and buttons
- Connect buttons to Global functions
- Bars update when stats change  
**Deliverable:** Pet visible, buttons work, bars move when clicked

---

## Phase 2 – Shop & Inventory
**Goal:** Add a shop where we can spend coins.  
**Tasks:**
- Create Shop scene with item buttons (food, toy)
- Show coin balance
- Buying items deducts coins and changes stats
- Track items in inventory  
**Deliverable:** Shop works, coins go down, stats change when buying

---

## Phase 3 – Stats & Progression
**Goal:** Show overall stats and achievements.  
**Tasks:**
- Create Stats scene with labels for hunger, happiness, energy, coins
- Add level + XP system
- Add simple achievements (like “Fed pet 10 times”)  
**Deliverable:** Stats screen shows live values, achievements unlock

---

## Phase 4 – Visuals & UX
**Goal:** Make the game look and feel better.  
**Tasks:**
- Add multiple pet sprites (dog, cat, etc.)
- Add animations for idle/happy/hungry
- Add sounds (click, eat, play)
- Style UI with fonts and icons  
**Deliverable:** Game feels alive with animations, sounds, and polished UI

---

## Phase 5 – Save/Load
**Goal:** Keep progress when closing the game.  
**Tasks:**
- Implement save system (JSON or ConfigFile)
- Load data on startup
- Handle missing/corrupt save gracefully  
**Deliverable:** Progress is saved and restored between sessions

---

## Phase 6 – Final Polish & Release
**Goal:** Finish and share the app.  
**Tasks:**
- Balance stat changes and item costs
- Add tutorial overlay
- Export builds (Windows, Mac, Android)
- Write final README with instructions  
**Deliverable:** A complete PetTopia app ready to play and share

---

## Notes
- We’ll move tasks to “Done” in GitHub Projects when finished
- This file should always match what’s happening in the project
