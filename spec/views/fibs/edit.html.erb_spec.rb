require 'rails_helper'

RSpec.describe "fibs/edit", type: :view do
  before(:each) do
    @fib = assign(:fib, Fib.create!())
  end

  it "renders the edit fib form" do
    render

    assert_select "form[action=?][method=?]", fib_path(@fib), "post" do
    end
  end
end
