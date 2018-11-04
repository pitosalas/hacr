require "./hue_resource"

# Represent Hue Sensors
class Sensor < HueResource
  getter :detail, :on, :name

  def initialize(key, hashvalue)
    super
    key = analyze_detail @detail
    @on = hashvalue.dig("state", key)
    gen_reskey("s")
    @state.merge! ({"on" => @on})
  end

  def array(selectors)
    selectors.map { |key| @state[key] }
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