require 'external/client'

class ReportService
  def initialize
    @client = ::External::Client.new
  end

  def reports
    profiles = @client.fetch_profiles
    repositories = @client.fetch_repositories

    profiles.map do |profile|
      {
        username: profile["username"],
        repositories: repositories.select{ |repository| repository["profile_id"] == profile["id"] }
                                  .map do |repository|
                                    {
                                      name: repository["name"],
                                      tags: repository["tags"]
                                    }
                                  end
      }
    end
  end
end
