extends Button

# Frequency of the synth tone in Hertz
@export var frequency: float = 440.0

# Cached references to child nodes for particles and audio
@onready var particles: GPUParticles2D = $Particles
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
var playback: AudioStreamGeneratorPlayback

func _ready() -> void:
    # Prepare an audio generator for simple sine wave tones
    var generator := AudioStreamGenerator.new()
    generator.mix_rate = 44100
    generator.buffer_length = 0.2
    audio_player.stream = generator
    audio_player.play()
    playback = audio_player.get_stream_playback() as AudioStreamGeneratorPlayback

func _pressed() -> void:
    # Called when the card (button) is clicked
    play_tone(frequency)
    particles.restart() # Trigger particle burst

func play_tone(freq: float, length: float = 0.2) -> void:
    # Generates a short sine wave and feeds it to the audio playback
    var frames := int(44100 * length)
    var data := PackedVector2Array()
    var phase := 0.0
    var increment := TAU * freq / 44100.0
    for i in frames:
        var sample := sin(phase)
        phase += increment
        data.append(Vector2(sample, sample))
    playback.push_buffer(data)

