extends Node


@warning_ignore_start("unused_signal")

signal level_start_request
signal level_end_request
signal level_started
signal level_ended
signal level_restarted

#region - - WEAPON CONTROLS - - - #
# UI Requests
signal weapon_fire_requested
signal weapon_angle_change_requested (new_angle: float)
signal weapon_power_change_requested (new_power: float)
# UI / General Updates
signal weapon_fired (weapon: Weapon)
signal weapon_angle_changed (new_angle: float)
signal weapon_power_changed (new_power: float)
#endregion - - - - #
