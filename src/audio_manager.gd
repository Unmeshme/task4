extends Node


func play_sfx(p_audio_stream: AudioStream, p_volume_db: float = 0.0, p_pitch_scale: float = 1.0) ->void:
	if p_audio_stream == null:
		return
	
	var m_player: AudioStreamPlayer = AudioStreamPlayer.new()
	m_player.stream = p_audio_stream
	m_player.bus = "sfx"
	m_player.volume_db = p_volume_db
	m_player.pitch_scale = p_pitch_scale
	
	add_child(m_player)
	m_player.play()

	m_player.connect("finished", m_player, "queue_free")
	yield(m_player, "finished")

#removing the positional_2d audio to reduce complexity
func play_bg_music(p_audio_stream: AudioStream) -> void:
	if p_audio_stream == null:
		return
	var m_player: AudioStreamPlayer = AudioStreamPlayer.new()
	m_player.stream = p_audio_stream
	m_player.bus = "background"
	
	add_child(m_player)
	m_player.play()


func mute_audio_bus(p_bus: String) -> void:
	var m_bus_index: int = AudioServer.get_bus_index(p_bus)
	AudioServer.set_bus_mute(m_bus_index, true)


func unmute_audio_bus(p_bus: String) -> void:
	var m_bus_index: int = AudioServer.get_bus_index(p_bus)
	AudioServer.set_bus_mute(m_bus_index, false)

