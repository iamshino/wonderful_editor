# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:comment) { build(:comment) }
  context "bodyを指定している時" do
    it "コメントが作成される" do
      expect(comment).to be_valid
    end
  end

  context "bodyを指定していない時" do
    it "エラーする" do
      comment.body = nil
      expect(comment).to be_invalid
      expect(comment.errors.details[:body][0][:error]).to eq :blank
    end
  end
end
