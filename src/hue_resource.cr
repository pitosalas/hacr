require "json"

class HueResource
  @hub_status_json : Hash(String, JSON::Any)
  property state : Hash(String, String)

  def initialize(timestamp, key, hub_status_json : JSON::Any)
    @hub_status_json = hub_status_json.as_h
    detail = @hub_status_json.fetch("type", "none").to_s
    name = @hub_status_json.fetch("name", "none").to_s
    @state = {"key" => key, "detail" => detail, "name" => name, "timestamp" => format(timestamp), "dump" => @hub_status_json.to_s}
  end

  def gen_reskey(detail)
    @state.merge!({"id" => detail + @state["key"]})
  end

  def id
    @state["id"]
  end

  def array(selectors)
    selectors.map { |key| @state.fetch(key, "none") }
  end

  def format(string_time)
    time = Time.parse_utc(string_time, "%Y-%m-%dT%H:%M:%S")
    time = time.in Time::Location.local
    time.to_s("%H:%M:%S")
  end
end
