require 'rails_helper'

RSpec.describe "fibs/index", type: :view do
  before(:each) do
    assign(:fibs, [
      Fib.create!(),
      Fib.create!()
    ])
  end

  it "renders a list of fibs" do
    render
  end
end
