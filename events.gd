extends Node


@warning_ignore_start("unused_signal")

#region - - UI SCENE SIGNALS - - - #
signal screen_changed (new_screen: Control)

#signal
#signal next_level

#region - - LEVEL SIGNALS - - - #
signal level_start_request
signal level_end_request
signal level_started
signal level_ended
signal level_completed
#signal level_restarted

#signal score_incremented(increment_amount: int)
#signal level_score_changed_requested( new_score: int )

signal level_ammo_changed (new_ammo_count: int)
signal level_score_changed (new_score: int)
signal level_attempts_changed (new_attempt_count: int)


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
