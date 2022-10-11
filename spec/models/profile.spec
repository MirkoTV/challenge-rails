require "rails_helper"

RSpec.describe Profile do
  describe "validations" do
    it "allows alpha numeric and hyphen characters in username" do
      profile = Profile.new(username: "Bob-Doe5")

      expect(profile.valid?).to be(true)
    end

    it "does not allow special characters in username" do
      profile = Profile.new(username: "Bob?")

      expect(profile.valid?).to be(false)
    end

    it "does not allow duplicated names" do
      profile1 = Profile.create(username: "Bob")
      profile2 = Profile.create(username: "Bob")

      expect(profile1.valid?).to be(true)
      expect(profile2.valid?).to be(false)
    end
  end
end