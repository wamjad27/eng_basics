require 'rails_helper'

RSpec.describe "fibs/show", type: :view do
  before(:each) do
    @fib = assign(:fib, Fib.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
