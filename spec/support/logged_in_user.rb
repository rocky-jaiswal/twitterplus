require 'rails_helper'

RSpec.shared_context 'logged in user' do

  let(:logged_in_user) do
    create(:user, :fully_loaded)
  end

  def login
    post_via_redirect user_session_path, 'user[email]' => logged_in_user.email, 'user[password]' => logged_in_user.password
  end

  before do
    login
  end

end
