
#extends CollisionChecker
extends RigidBody2D
class_name DestructableObject2


@export var particle_scene: PackedScene
@export var impact_audio: AudioStream
@export var destruction_audio: AudioStream

@export var durability: float = 100.0
@export var resistance: float = 20.0
@export var threshhold: float = 1024.0

var collision_monitor: CollisionMonitor
var collision_speed_threshold = 128.0


func _ready():
	#super()
	body_entered.connect( _on_body_entered )
	collision_monitor = CollisionMonitor.new()

	if impact_audio: $ImpactAudioPlayer.stream = impact_audio
	if destruction_audio: $DestructionAudioPlayer.stream = destruction_audio
	pass


func _physics_process(_delta: float) -> void:
	if linear_velocity.round() != Vector2.ZERO:
		#print(linear_velocity)
		pass


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#if state.get_contact_count():
		#print(get_contact_count())
	var collision = collision_monitor.integrate_forces(state, collision_speed_threshold)
	if collision:
		damage_force(collision.velocity)
		particle_effect(collision)


func _on_body_entered(body: Node):
	pass


func damage_force(force: Vector2):
	var magnitude = force.length()
	if magnitude * (resistance / 100) > threshhold or durability <= 0:
	#if force.length() > threshhold:
		if $DestructionAudioPlayer is RandomAudioStreamPlayer2D: $DestructionAudioPlayer.play_random()
		else: $DestructionAudioPlayer.play()

		$Sprite2D.hide()
		$CollisionShape2D.set_deferred("disabled", true)
		await $DestructionAudioPlayer.finished
		queue_free()
	else:
		if $ImpactAudioPlayer is RandomAudioStreamPlayer2D: $ImpactAudioPlayer.play_random()
		else: $ImpactAudioPlayer.play()

		#print(magnitude, " ", (resistance / 100))
		#print(magnitude * (resistance / 100))
		durability -= magnitude * (resistance / 100)



func particle_effect(collision: Dictionary):
	var p = particle_scene.instantiate()
	p.amount = 4 + (collision.velocity.length() / Game.PIXELS_PER_METER)
	p.global_position = collision.position

	#get_tree().get_root().add_child(p)
	Game.current_level.add_child(p)

	p.emitting = true
	p.finished.connect( func(): p.queue_free() )
	#Events.particles_emitted.emit(p, collision.position)
	pass
