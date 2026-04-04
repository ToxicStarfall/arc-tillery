extends Node


@warning_ignore_start("unused_signal")

signal game_loading_started
signal game_loading_ended
signal game_ready
signal game_reset

#region - - UI SCENE SIGNALS - - - #
#signal screen_changed (new_screen: Control)
#endregion - - - - #


#region - - LEVEL SIGNALS - - - #
signal level_pause_request
signal level_unpause_request

signal level_started
signal level_ended
signal level_completed
#signal level_restarted
signal level_paused
signal level_unpaused

signal level_ammo_changed (new_ammo_count: int)
signal level_score_changed (new_score: int)
signal level_attempts_changed (new_attempt_count: int)

signal camera_lock_changed ()

signal particles_emitted (particles: Node2D, position: Vector2)

#endregion - - - - #


#region - - WEAPON CONTROLS - - - #
# UI Requests
signal weapon_fire_requested
signal weapon_angle_change_requested (new_angle: float)
signal weapon_power_change_requested (new_power: float)

# UI / General Updates
signal weapon_fired (projectile: Projectile)
signal weapon_angle_changed (new_angle: float)
signal weapon_power_changed (new_power: float)
#endregion - - - - #

@warning_ignore_restore("unused_signal")
