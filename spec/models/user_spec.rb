require "rails_helper"

RSpec.describe User, type: :model do
  context "nameを指定している時" do
    let(:user) { build(:user) }
    it "記事が作成される" do
      expect(user).to be_valid
    end
  end

  context "nameを指定していない時" do
    let(:user) { build(:user, name: nil) }
    it "エラーする" do
      expect(user).to be_invalid
      expect(user.errors.details[:name][0][:error]).to eq :blank
    end
  end

  context "emailを指定していない時" do
    let(:user) { build(:user, email: nil) }
    it "エラーする" do
      expect(user).to be_invalid
      expect(user.errors.details[:email][0][:error]).to eq :blank
    end
  end

  context "passwordを指定していない時" do
    let(:user) { build(:user, password: nil) }
    it "エラーする" do
      expect(user).to be_invalid
      expect(user.errors.details[:password][0][:error]).to eq :blank
    end
  end
end
