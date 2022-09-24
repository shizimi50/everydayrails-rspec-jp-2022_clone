require 'rails_helper'

RSpec.describe "Projects", type: :request do
  context "認証済みユーザーとして" do
    before do
      @user = FactoryBot.create(:user)
    end

    context "有効な属性値の場合" do
      it "プロジェクトを追加できること" do
        project_params = FactoryBot.attributes_for(:project) 
        sign_in @user
        expect {
          post projects_path, params: { project: project_params }
        }.to change(@user.projects, :count).by(1)
      end

      it "無効な属性値の場合" do
        project_params = FactoryBot.attributes_for(:project, :invalid)
        sign_in @user
        expect {
          post projects_path, params: { project: project_params }
        }.to_not change(@user.projects, :count)
      end
    end
  end
end
