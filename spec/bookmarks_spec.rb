require 'bookmarks'

describe Bookmarks do

  it 'returns a list of bookmarks' do
    expect(Bookmarks.all).to include "http://www.google.com"
  end

end