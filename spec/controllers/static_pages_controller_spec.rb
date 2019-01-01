require 'spec_helper'

RSpec.describe StaticPagesController do
  subject {page}
  describe "GET home" do
    before(:each) {visit root_path}
      it {should have_content('App')}
      it {should have_title(full_title('Home'))}
  end
end