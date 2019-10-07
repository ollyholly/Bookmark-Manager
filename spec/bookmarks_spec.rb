require 'bookmarks'

describe Bookmarks do

  let(:bookmark_list) { ["http://google.com", "http://facebook.com"] }

  it 'returns a list of bookmarks' do
    expect(described_class.all).to eq bookmark_list
  end

end