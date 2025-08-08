Phase 1: The Word’s Birth
Goal: Capture a player-submitted word, spawn a glowing physical object whose appearance is procedurally generated, and trigger echo effects (visual/audio) based on the word. Modular Logic:
The player interacts with a Button Device to submit their word.
The Verse device processes the word, calculates its length and vowels, determines a color using the first letter, and manipulates a Creative Prop for physical manifestation.
A VFX Spawner Device and Audio Player Device bind effects and sounds to the prop.
Devices Needed:
Button Device (for input)
Creative Prop (for the word’s physical object)
VFX Spawner Device (for visual echo)
Audio Player Device (for audio echo)

Phase 2: The Word’s Trial
Goal: The word object triggers three modular challenges, each associated with a property of the word:
Challenge A: Number of platforms = word length
Challenge B: Number of logic orbs = vowel count
Challenge C: Themed trial based on meaning (customizable combat/obstacle)
Modular Logic:
Triggers and buttons unlock/manage different challenge phases.
Each challenge subscribes to its devices/events, and tracks progress.
You can easily swap out, add, or change the challenge logic.
Devices Needed:
Trigger Devices (platform triggers that activate as platforms appear/disappear)
Button Devices (for logic orb activation)
Volume Device (for tracking entry into themed zones or combat areas)
Any custom prop/devices representing orbs, challenge objects, or themed obstacles.

Phase 3: The Word’s Evolution
Goal: On completing all three challenges, the word object evolves: changes appearance/effects, and grants the player a unique buff linked to the word’s theme. Modular Logic:
The Verse device transforms the creative prop: alters its scale/location, triggers new visual/audio effects, and grants a temporary buff (using an Item Granter Device).
Devices Needed:
Creative Prop (the word object to be transformed)
VFX Spawner Device (new evolution effect)
Item Granter Device (for buffs/abilities tied to the word theme)

Modularity & Swapping Components
The system is split across three Verse devices: one for spawning/word logic, one for handling modular challenges, and one for evolution/buff.
Each device uses @editable references for flexible assignment of game objects/effects in UEFN Details panel.
You can swap VFX, audio assets, platform objects, orb props, challenge triggers, or evolution effects just by editing device references or replacing code logic in the challenge manager.
Challenge unlocking is based on tracked properties (length, vowel count, meaning), which makes future additions simple.
Step-by-Step Setup in UEFN
1. Create Verse Files
*Verse → Verse Explorer* → right-click folder → New Verse File (name: word_birth_device, word_challenge_manager, word_evolution_device)
Paste each phase’s code and save.
2. Build Verse Code
*Verse → Build Verse Code* (Ctrl+Shift+B). Devices show in Content Browser.
3. Place Devices in Level
Drag each Verse device into your level.
For each, also drag the referenced devices (Button Device, Creative Prop, etc.).
4. Assign References and Configure Devices
Select each Verse device in Details panel and set:
For word_birth_device: assign Button Device, Creative Prop, VFX Spawner, Audio Player.
For word_challenge_manager: assign all triggers, buttons, themed area volume.
For word_evolution_device: assign evolution VFX, buff granter, evolved prop.
For platform triggers: set up trigger sequence and linked platforms.
For logic orbs: use customizable props, assign their colors as needed.
Themed obstacles: add props/vfx as appropriate for each word’s meaning.
5. Play-test and Iterate
Launch session, play through word’s journey, make adjustments for props/challenges/buffs as needed.
Additional Tips
Adjust procedural glow, sounds, and colors in the Verse code for each word’s “birth.”
You can expand challenge logic by adding more device interactions or using Verse’s failure context for puzzles.
Assign different buffs/items per word theme using UEFN item/buff assets.
For multiplayer, expand each event handler to support multiple agents and synchronize progression.