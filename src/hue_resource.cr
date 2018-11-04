require "json"

class HueResource
  @hub_status_json : Hash(String, JSON::Any)
  @state : Hash(String, String)
  # getter @state : Hash(String, String), 
  #                 @detail : String
  #               @name: String

  def initialize(key, hub_status_json : JSON::Any)
    @hub_status_json = hub_status_json.as_h
    detail = @hub_status_json.fetch("type","none").to_s
    name = @hub_status_json.fetch("name","none").to_s
    @state = { "key" => key, "detail" => detail, "name" => name}
  end

  def gen_reskey(detail)
    @state.merge!({ "id" => detail + @state["key"]})
  end
end
