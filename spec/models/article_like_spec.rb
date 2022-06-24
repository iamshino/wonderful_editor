# == Schema Information
#
# Table name: article_likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_article_likes_on_article_id  (article_id)
#  index_article_likes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe ArticleLike, type: :model do

  context "userとarticleが存在するとき" do
    let(:article_like) { build(:article_like) }

    it "likeできる" do
    expect(article_like).to be_valid
    end
  end

  context "userのみ存在しないとき" do
    let(:article_like) { build(:article_like, user_id: nil) }

    it "likeできない" do
      expect(article_like).to be_invalid
      expect(article_like.errors.details[:user][0][:error]).to eq :blank
    end
  end

  context "articleのみ存在しないとき" do
    let(:article_like) { build(:article_like, article_id: nil) }

    it "likeできない" do
      expect(article_like).to be_invalid
      expect(article_like.errors.details[:article][0][:error]).to eq :blank
    end
  end
end
