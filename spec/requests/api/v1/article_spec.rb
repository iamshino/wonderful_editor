require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET api/v1/articles" do
    subject { get(api_v1_articles_path) }

    let!(:article1) { create(:article, updated_at: 1.days.ago) }
    let!(:article2) { create(:article, updated_at: 2.days.ago) }
    let!(:article3) { create(:article, updated_at: 3.days.ago) }

    it "記事一覧が取得できる" do
      subject

      res = JSON.parse(response.body)
      expect(res.length).to eq 3
      expect(res.map {|a| a["id"] }).to eq [article1.id, article2.id, article3.id]
      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/articles/:id" do
    subject { get(api_v1_article_path(article_id)) }

    let!(:article) { create(:article) }
    context "適切なidを指定した時" do
      let(:article_id) { article.id }
      it "指定したidのデータが取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res["id"]).to eq article.id
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["updated_at"]).to be_present
        expect(res["user"]["name"]).to eq article.user.name
        expect(res["user"]["email"]).to eq article.user.email
        expect(response).to have_http_status(200)
      end
    end

    context "idが存在しない時" do
      let(:article_id) { 10000 }
      it "エラーする" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
