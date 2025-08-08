using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Colors }
using { /Verse.org/Random }
using { /Fortnite.com/Characters }

# Phase 1: Word Birth Device
word_birth_device := class(creative_device):
    @editable
    InputButton : button_device = button_device{}
    @editable
    WordProp : creative_prop = creative_prop{}
    @editable
    VFXSpawner : vfx_spawner_device = vfx_spawner_device{}
    @editable
    AudioPlayer : audio_player_device = audio_player_device{}

    var CurrentWord : string = ""
    var WordLength : int = 0
    var VowelCount : int = 0

    OnBegin&lt;override&gt;()&lt;suspends&gt; : void =
        InputButton.InteractedWithEvent.Subscribe(OnWordSubmitted)

    OnWordSubmitted(Agent : agent) : void =
        # Simulate word input for demo
        set CurrentWord = "FLAME"
        set WordLength = CurrentWord.Length
        set VowelCount = CountVowels(CurrentWord)
        SpawnWordObject()

    CountVowels(Word : string) : int =
        var Count : int = 0
        for (Char : Word):
            if (Char = 'A' or Char = 'E' or Char = 'I' or Char = 'O' or Char = 'U'):
                set Count += 1
        return Count

    SpawnWordObject() : void =
        # Procedural appearance based on word properties
        if (FirstChar := CurrentWord[0]):
            BaseColor := GetColorForLetter(FirstChar)
            Scale := vector3{X := 1.0 + (WordLength * 0.1), Y := 1.0, Z := 1.0}
            
            # Spawn and configure prop
            if (WordProp.TeleportTo[transform{
                Translation := vector3{X := 0.0, Y := 0.0, Z := 100.0},
                Rotation := rotation{},
                Scale := Scale
            }]):
                # Start effects
                VFXSpawner.Enable()
                AudioPlayer.Play()

    GetColorForLetter(Letter : char) : color =
        # Simple color mapping based on first letter
        case(Letter):
            'A' =&gt; NamedColors.Red
            'B' =&gt; NamedColors.Blue
            'C' =&gt; NamedColors.Green
            _ =&gt; NamedColors.White

# Phase 2: Challenge Manager
word_challenge_manager := class(creative_device):
    @editable
    PlatformTriggers : []trigger_device = array{}
    @editable
    LogicButtons : []button_device = array{}
    @editable
    ThemedArea : volume_device = volume_device{}

    var CompletedChallenges : int = 0

    OnBegin&lt;override&gt;()&lt;suspends&gt; : void =
        SetupPlatformChallenge()
        SetupLogicChallenge()
        SetupThemedChallenge()

    SetupPlatformChallenge() : void =
        for (Index -&gt; Trigger : PlatformTriggers):
            Trigger.TriggeredEvent.Subscribe(OnPlatformTriggered)

    OnPlatformTriggered(Agent : ?agent) : void =
        if (CompletedChallenges = 0):
            set CompletedChallenges += 1
            CheckProgress()

    SetupLogicChallenge() : void =
        for (Button : LogicButtons):
            Button.InteractedWithEvent.Subscribe(OnLogicButtonPressed)

    OnLogicButtonPressed(Agent : agent) : void =
        if (CompletedChallenges = 1):
            set CompletedChallenges += 1
            CheckProgress()

    SetupThemedChallenge() : void =
        ThemedArea.AgentEntersEvent.Subscribe(OnThemedAreaEntered)

    OnThemedAreaEntered(Agent : agent) : void =
        if (CompletedChallenges = 2):
            set CompletedChallenges += 1
            CheckProgress()

    CheckProgress() : void =
        if (CompletedChallenges &gt;= 3):
            # Signal completion to evolution phase
            Print("All challenges completed!")

# Phase 3: Word Evolution Device
word_evolution_device := class(creative_device):
    @editable
    WordProp : creative_prop = creative_prop{}
    @editable
    BuffGranter : item_granter_device = item_granter_device{}
    @editable
    EvolutionVFX : vfx_spawner_device = vfx_spawner_device{}

    EvolveWord(Agent : agent) : void =
        # Transform word object
        if (WordProp.TeleportTo[transform{
            Translation := vector3{X := 0.0, Y := 0.0, Z := 150.0},
            Rotation := rotation{},
            Scale := vector3{X := 2.0, Y := 2.0, Z := 2.0}
        }]):
            # Add evolution effects
            EvolutionVFX.Enable()
            
            # Grant themed buff
            BuffGranter.GrantItem(Agent)