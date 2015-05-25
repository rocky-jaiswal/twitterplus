require 'rails_helper'

RSpec.describe 'friends requests', type: :request do

  it 'only shows friends for an authenticated user' do
    get friends_path
    expect(response.success?).to be(false)
  end

  context 'while logged in' do

    include_context 'logged in user'

    it 'only shows friends for the authenticated user' do
      get friends_path
      expect(response.success?).to be(true)
      expect(response.body).to eq(logged_in_user.unassigned_friends.to_json)
    end

  end

end
