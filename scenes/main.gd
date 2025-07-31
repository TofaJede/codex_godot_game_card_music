extends Control

# Preload the card scene for instantiation
var CardScene := preload("res://scenes/card.tscn")

@onready var card_container: HBoxContainer = $CardContainer
@onready var beat_timer: Timer = $BeatTimer

func _ready() -> void:
    # Create a few example cards with different tones
    for i in range(3):
        var card: Button = CardScene.instantiate()
        card.text = "Card %d" % (i + 1)
        card.frequency = 220.0 * (i + 1)
        card_container.add_child(card)
    # Connect beat timer
    beat_timer.timeout.connect(_on_beat)

func _on_beat() -> void:
    # Pulse animation on every simulated beat
    for card in card_container.get_children():
        var tween := create_tween()
        tween.tween_property(card, "scale", Vector2(1.1, 1.1), 0.1).from(Vector2.ONE)
        tween.tween_property(card, "scale", Vector2.ONE, 0.1)

