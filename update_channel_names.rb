require 'uri'
require 'net/http'
require 'csv'
require 'json'



class UpdateChannelNames
  attr_accessor :org, :load_file
  attr_reader :api_key, :superuser_org_id

  def initialize(user_token, org_external, load_file_path, superuser_org_id = nil)
    @api_key = user_token
    @org_id = org_external
    @load_file = load_file_path
    @superuser_org_id = superuser_org_id
  end

  def make_request(channel_to_update, new_name)
    responses = ["weeeeeeeee!", "GREAT SUCCESS!", "Big Victory!", "Mission Accomplished!", "Major Key!", "ANOTHA ONE!"].sample
    url = URI("https://app.salsify.com/api/orgs/#{@org_id}/channels/#{channel_to_update}?serialize_system_ids=true")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Put.new(url)
    request['Content-Type'] = 'application/json'
    request['Authorization'] = "Bearer #{@api_key}"
    if @superuser_org_id != nil 
        request['x-auth-organization-ID'] = "#{@superuser_org_id}"
    else nil 
    end 
    request.body = "{\"channel\": {\"name\": \"#{new_name}\"}}"

    response = https.request(request)
    puts response.read_body
    puts response.code
    if response.code == '204'
      puts "#{responses} #{channel_to_update} renamed to #{new_name}"
    else puts "Renaming failed...Sad!"
    end 
  rescue StandardError => e
    puts "failed #{e}"
    nil
  end

  def file_run
    CSV.foreach(@load_file, headers: true).map do |row|
      sleep(0.2)
      make_request(row[0], row[1])
    end
  end
end

user_token = ARGV[0]
org_external = ARGV[1]
load_file_path = ARGV[2]
optional_superuser_org = ARGV[3]
test_call = UpdateChannelNames.new(user_token, org_external, load_file_path, optional_superuser_org)
puts test_call.file_run
