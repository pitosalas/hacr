require "./hue_resource"

# Represent Hue Sensors
class Sensor < HueResource

  def initialize(timestamp, key, hashvalue)
    super
    detail = @state.fetch("detail").to_s
    key = analyze_detail(detail)
    on = hashvalue["state"][key].to_s
    gen_reskey("s")
    @state.merge! ({"on" => on})
  end

  def analyze_detail(detail)
    key = "status"
    if detail == "CLIPPresence"
      key = "presence"
    elsif detail == "Geofence"
      key = "presence"
    elsif detail == "CLIPGenericFlag"
      key = "flag"
    elsif detail == "Daylight"
      key = "daylight"
    end
    key
  end

  
end